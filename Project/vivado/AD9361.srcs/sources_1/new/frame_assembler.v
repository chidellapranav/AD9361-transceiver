`timescale 1ns / 1ps

module frame_assembler #(
    // Allowed range: 1 through 65535.
    parameter integer MAX_CODED_PAIRS = 2048
)(
    input  wire        clk,
    input  wire        resetn,

    // Must be valid when the first coded pair is accepted.
    input  wire [15:0] payload_length_bytes,

    // Coded payload input from conv_encoder.
    input  wire [1:0]  s_axis_tdata,
    input  wire        s_axis_tvalid,
    input  wire        s_axis_tlast,
    output wire        s_axis_tready,

    // Complete frame output to the future QPSK mapper.
    output reg  [1:0]  m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready,

    output wire        busy,
    output reg         packet_done,

    // Sticky error: oversized packets are discarded.
    // Cleared by reset.
    output reg         overflow_error
);

    localparam [1:0] LOAD_PACKET = 2'd0;
    localparam [1:0] SEND_PREFIX = 2'd1;
    localparam [1:0] SEND_BODY   = 2'd2;
    localparam [1:0] DROP_PACKET = 2'd3;

    localparam [31:0] SYNC_WORD = 32'h1ACFFC1D;

    reg [1:0] state;

    // Explicit packet storage. Read style is asynchronous;
    // Vivado may implement this using distributed memory.
    reg [1:0] packet_memory [0:MAX_CODED_PAIRS-1];

    reg [15:0] write_count;
    reg [15:0] read_index;
    reg [15:0] pair_count;
    reg [15:0] payload_length_latched;

    reg [6:0] prefix_index;

    reg [7:0] sequence_number;
    reg [63:0] header;

    wire [15:0] incoming_pair_count;
    wire [15:0] selected_payload_length;
    wire [47:0] header_first_six_bytes;

    assign incoming_pair_count = write_count + 16'd1;

    // Handles a packet containing only one coded pair too.
    assign selected_payload_length =
        (write_count == 0)
        ? payload_length_bytes
        : payload_length_latched;

    assign header_first_six_bytes = {
        8'h11,
        sequence_number,
        selected_payload_length,
        incoming_pair_count
    };

    // --------------------------------------------------------
    // CRC-16/CCITT-FALSE over six bytes, MSB first.
    // poly=1021, init=FFFF, refin=false, refout=false,
    // xorout=0000.
    // --------------------------------------------------------
    function [15:0] header_crc16;
        input [47:0] bytes_in;

        reg [15:0] c;
        integer b;

        begin
            c = 16'hFFFF;

            for (b = 47; b >= 0; b = b - 1) begin
                if (c[15] ^ bytes_in[b])
                    c = {c[14:0], 1'b0} ^ 16'h1021;
                else
                    c = {c[14:0], 1'b0};
            end

            header_crc16 = c;
        end
    endfunction

    assign s_axis_tready =
        resetn &&
        ((state == LOAD_PACKET) || (state == DROP_PACKET));

    assign m_axis_tvalid =
        resetn &&
        ((state == SEND_PREFIX) || (state == SEND_BODY));

    assign m_axis_tlast =
        m_axis_tvalid &&
        (state == SEND_BODY) &&
        (read_index == pair_count - 16'd1);

    assign busy =
        (state != LOAD_PACKET) || (write_count != 0);

    // --------------------------------------------------------
    // Output selection.
    // Indices advance only on accepted output transfers,
    // so DATA and LAST remain stable during stalls.
    // --------------------------------------------------------
    always @* begin
        m_axis_tdata = 2'b00;

        if (state == SEND_PREFIX) begin

            if (prefix_index < 32) begin
                // Preamble: 00,01,11,10 repeated eight times.
                case (prefix_index[1:0])
                    2'd0: m_axis_tdata = 2'b00;
                    2'd1: m_axis_tdata = 2'b01;
                    2'd2: m_axis_tdata = 2'b11;
                    2'd3: m_axis_tdata = 2'b10;
                endcase
            end
            else if (prefix_index < 48) begin
                // Prefix indices 32..47: 32-bit sync word.
                m_axis_tdata =
                    SYNC_WORD >> (2 * (47 - prefix_index));
            end
            else begin
                // Prefix indices 48..79: 64-bit header.
                m_axis_tdata =
                    header >> (2 * (79 - prefix_index));
            end

        end
        else if (state == SEND_BODY) begin
            m_axis_tdata = packet_memory[read_index];
        end
    end

    // --------------------------------------------------------
    // Capture packet, construct header, and transmit frame.
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            state                  <= LOAD_PACKET;
            write_count            <= 16'd0;
            read_index             <= 16'd0;
            pair_count             <= 16'd0;
            payload_length_latched <= 16'd0;

            prefix_index           <= 7'd0;
            sequence_number        <= 8'd0;
            header                 <= 64'd0;

            packet_done            <= 1'b0;
            overflow_error         <= 1'b0;
        end
        else begin
            packet_done <= 1'b0;

            case (state)

                LOAD_PACKET: begin
                    if (s_axis_tvalid && s_axis_tready) begin

                        packet_memory[write_count] <=
                            s_axis_tdata;

                        if (write_count == 0)
                            payload_length_latched <=
                                payload_length_bytes;

                        if (s_axis_tlast) begin
                            pair_count <= incoming_pair_count;

                            header <= {
                                header_first_six_bytes,
                                header_crc16(header_first_six_bytes)
                            };

                            write_count  <= 16'd0;
                            read_index   <= 16'd0;
                            prefix_index <= 7'd0;
                            state        <= SEND_PREFIX;
                        end
                        else if (write_count ==
                                 MAX_CODED_PAIRS - 1) begin

                            // Buffer filled before packet ended.
                            // Discard the whole packet.
                            overflow_error <= 1'b1;
                            write_count    <= 16'd0;
                            state          <= DROP_PACKET;
                        end
                        else begin
                            write_count <= write_count + 16'd1;
                        end
                    end
                end

                SEND_PREFIX: begin
                    if (m_axis_tvalid && m_axis_tready) begin
                        if (prefix_index == 7'd79) begin
                            read_index <= 16'd0;
                            state      <= SEND_BODY;
                        end
                        else begin
                            prefix_index <= prefix_index + 7'd1;
                        end
                    end
                end

                SEND_BODY: begin
                    if (m_axis_tvalid && m_axis_tready) begin
                        if (read_index == pair_count - 16'd1) begin
                            state           <= LOAD_PACKET;
                            read_index      <= 16'd0;
                            sequence_number <= sequence_number + 8'd1;
                            packet_done     <= 1'b1;
                        end
                        else begin
                            read_index <= read_index + 16'd1;
                        end
                    end
                end

                DROP_PACKET: begin
                    // Resynchronize on the oversized packet's end.
                    if (s_axis_tvalid &&
                        s_axis_tready &&
                        s_axis_tlast) begin

                        write_count <= 16'd0;
                        state       <= LOAD_PACKET;
                    end
                end

                default: begin
                    state       <= LOAD_PACKET;
                    write_count <= 16'd0;
                end

            endcase
        end
    end

endmodule