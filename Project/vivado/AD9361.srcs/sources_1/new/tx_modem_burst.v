`timescale 1ns / 1ps

module tx_modem_burst #(
    parameter integer PAYLOAD_BYTES  = 16,
    parameter integer BUFFER_SAMPLES = 2048,
    parameter integer GAP_CYCLES     = 307200
)(
    input wire clk,
    input wire resetn,
    input wire enable,

    // Direct signed sample outputs: no external slices needed.
    output wire signed [15:0] tx_i,
    output wire signed [15:0] tx_q,
   (* X_INTERFACE_IGNORE = "true" *)
   output wire tx_valid,

    // Diagnostic outputs.
    output reg burst_active,
    output reg burst_last,
    output reg error
);

    localparam [2:0] WAIT_START = 3'd0;
    localparam [2:0] FILL       = 3'd1;
    localparam [2:0] PLAY       = 3'd2;
    localparam [2:0] GAP        = 3'd3;
    localparam [2:0] FAULT      = 3'd4;

    reg [2:0] state;

    reg modem_start;

    wire modem_busy;
    wire modem_done;
    wire modem_overflow;

    wire [31:0] modem_data;
    wire        modem_valid;
    wire        modem_last;
    wire        modem_ready;

    (* ram_style = "block" *)
    reg [31:0] sample_memory [0:BUFFER_SAMPLES-1];

    reg [15:0] write_index;
    reg [15:0] read_index;
    reg [15:0] stored_samples;

    reg [31:0] gap_count;
    reg [31:0] playback_data;

    assign modem_ready =
        resetn && (state == FILL);

    // Split packed samples inside this RTL.
    assign tx_i =
        resetn ? playback_data[15:0] : 16'd0;

    assign tx_q =
        resetn ? playback_data[31:16] : 16'd0;

    // Valid every clock after reset.
    // Idle periods carry zero-valued samples.
    assign tx_valid = resetn;

    tx_rrc_top #(
        .PAYLOAD_BYTES  (PAYLOAD_BYTES),
        .MAX_CODED_PAIRS(2048),
        .AMPLITUDE     (8192)
    ) modem (
        .clk            (clk),
        .resetn         (resetn),
        .start          (modem_start),

        .busy           (modem_busy),
        .packet_done    (modem_done),
        .overflow_error (modem_overflow),

        .m_axis_tdata   (modem_data),
        .m_axis_tvalid  (modem_valid),
        .m_axis_tlast   (modem_last),
        .m_axis_tready  (modem_ready)
    );

    always @(posedge clk) begin
        if (!resetn) begin
            state          <= WAIT_START;
            modem_start    <= 1'b0;

            write_index    <= 16'd0;
            read_index     <= 16'd0;
            stored_samples <= 16'd0;

            gap_count      <= 32'd0;
            playback_data  <= 32'd0;

            burst_active   <= 1'b0;
            burst_last     <= 1'b0;
            error          <= 1'b0;
        end
        else begin
            modem_start   <= 1'b0;
            playback_data <= 32'd0;
            burst_active  <= 1'b0;
            burst_last    <= 1'b0;

            if (modem_overflow) begin
                error <= 1'b1;
                state <= FAULT;
            end
            else begin
                case (state)

                    WAIT_START: begin
                        if (enable && !modem_busy) begin
                            write_index <= 16'd0;
                            modem_start <= 1'b1;
                            state       <= FILL;
                        end
                    end

                    FILL: begin
                        if (modem_valid && modem_ready) begin
                            sample_memory[write_index] <=
                                modem_data;

                            if (modem_last) begin
                                stored_samples <=
                                    write_index + 16'd1;

                                read_index <= 16'd0;
                                state      <= PLAY;
                            end
                            else if (write_index ==
                                     BUFFER_SAMPLES - 1) begin
                                error <= 1'b1;
                                state <= FAULT;
                            end
                            else begin
                                write_index <=
                                    write_index + 16'd1;
                            end
                        end
                    end

                    PLAY: begin
                        playback_data <=
                            sample_memory[read_index];

                        burst_active <= 1'b1;

                        if (read_index ==
                            stored_samples - 16'd1) begin

                            burst_last <= 1'b1;
                            read_index <= 16'd0;
                            gap_count  <= 32'd0;
                            state      <= GAP;
                        end
                        else begin
                            read_index <= read_index + 16'd1;
                        end
                    end

                    GAP: begin
                        if ((GAP_CYCLES == 0) ||
                            (gap_count == GAP_CYCLES - 1)) begin

                            gap_count <= 32'd0;
                            state     <= WAIT_START;
                        end
                        else begin
                            gap_count <= gap_count + 32'd1;
                        end
                    end

                    FAULT: begin
                        // Output stays zero until reset.
                        state <= FAULT;
                    end

                    default: begin
                        error <= 1'b1;
                        state <= FAULT;
                    end

                endcase
            end
        end
    end

endmodule