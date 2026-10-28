`timescale 1ns / 1ps

module conv_encoder (
    input  wire       clk,
    input  wire       resetn,

    // Byte input from the scrambler
    input  wire [7:0] s_axis_tdata,
    input  wire       s_axis_tvalid,
    input  wire       s_axis_tlast,
    output wire       s_axis_tready,

    // One coded pair per transfer
    output wire [1:0] m_axis_tdata,
    output wire       m_axis_tvalid,
    output wire       m_axis_tlast,
    input  wire       m_axis_tready,

    output reg        packet_done
);

    reg [7:0] byte_buffer;
    reg [2:0] bit_index;
    reg       byte_last;
    reg       have_byte;

    reg [5:0] state;

    reg       tail_active;
    reg [2:0] tail_index;

    wire       input_bit;
    wire [6:0] encoder_word;

    // During termination, feed six zero bits.
    assign input_bit =
        tail_active ? 1'b0 : byte_buffer[bit_index];

    // Bit 6 = current input.
    // Bits 5:0 = six previous input bits, newest first.
    assign encoder_word = {input_bit, state};

    // Pair ordering:
    // bit 1 = generator 171 octal
    // bit 0 = generator 133 octal
    assign m_axis_tdata[1] =
        ^(encoder_word & 7'o171);

    assign m_axis_tdata[0] =
        ^(encoder_word & 7'o133);

    assign m_axis_tvalid =
        resetn && (have_byte || tail_active);

    assign m_axis_tlast =
        m_axis_tvalid &&
        tail_active &&
        (tail_index == 3'd5);

    // Accept another byte only after the previous byte
    // has been completely encoded.
    assign s_axis_tready =
        resetn && !have_byte && !tail_active;

    always @(posedge clk) begin
        if (!resetn) begin
            byte_buffer <= 8'h00;
            bit_index   <= 3'd0;
            byte_last   <= 1'b0;
            have_byte   <= 1'b0;

            state       <= 6'd0;
            tail_active <= 1'b0;
            tail_index  <= 3'd0;

            packet_done <= 1'b0;
        end
        else begin
            packet_done <= 1'b0;

            // Accept one input byte.
            if (s_axis_tvalid && s_axis_tready) begin
                byte_buffer <= s_axis_tdata;
                byte_last   <= s_axis_tlast;
                bit_index   <= 3'd0;
                have_byte   <= 1'b1;
            end

            // Advance encoding only when a pair transfers.
            if (m_axis_tvalid && m_axis_tready) begin

                state <= encoder_word[6:1];

                if (tail_active) begin

                    if (tail_index == 3'd5) begin
                        tail_active <= 1'b0;
                        tail_index  <= 3'd0;
                        state       <= 6'd0;
                        packet_done <= 1'b1;
                    end
                    else begin
                        tail_index <= tail_index + 1'b1;
                    end

                end
                else if (have_byte) begin

                    if (bit_index == 3'd7) begin
                        have_byte <= 1'b0;
                        bit_index <= 3'd0;

                        if (byte_last) begin
                            tail_active <= 1'b1;
                            tail_index  <= 3'd0;
                        end
                    end
                    else begin
                        bit_index <= bit_index + 1'b1;
                    end
                end
            end
        end
    end

endmodule