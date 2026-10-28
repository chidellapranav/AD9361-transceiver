`timescale 1ns / 1ps

module rrc_interpolator (
    input wire clk,
    input wire resetn,

    // Input: one QPSK symbol, packed {Q, I}.
    input  wire [31:0] s_axis_tdata,
    input  wire        s_axis_tvalid,
    input  wire        s_axis_tlast,
    output wire        s_axis_tready,

    // Output: interpolated samples, packed {Q, I}.
    output wire [31:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready,

    output wire        busy,
    output reg         packet_done
);

    // Current symbol and eight previous symbols.
    reg signed [15:0] history_i [0:8];
    reg signed [15:0] history_q [0:8];

    reg [1:0] phase;

    reg sample_active;
    reg packet_active;
    reg current_symbol_last;

    reg flushing;
    reg [5:0] flush_remaining;

    reg signed [39:0] accumulator_i;
    reg signed [39:0] accumulator_q;

    reg signed [33:0] product_i;
    reg signed [33:0] product_q;

    integer k;
    integer n;

    // --------------------------------------------------------
    // 33-tap RRC:
    // beta = 0.35, samples/symbol = 4, span = 8 symbols.
    //
    // Coefficients scaled by 2^14.
    // Their integer sum is 65536, corresponding to gain 4
    // for an interpolator.
    // --------------------------------------------------------
    function signed [17:0] coefficient;
        input integer index;

        begin
            case (index)
                 0: coefficient =  18'sd33;
                 1: coefficient =  18'sd217;
                 2: coefficient =  18'sd156;
                 3: coefficient = -18'sd155;
                 4: coefficient = -18'sd414;
                 5: coefficient = -18'sd241;
                 6: coefficient =  18'sd417;
                 7: coefficient =  18'sd1064;
                 8: coefficient =  18'sd930;
                 9: coefficient = -18'sd359;
                10: coefficient = -18'sd2201;
                11: coefficient = -18'sd3072;
                12: coefficient = -18'sd1379;
                13: coefficient =  18'sd3369;
                14: coefficient =  18'sd9897;
                15: coefficient =  18'sd15586;
                16: coefficient =  18'sd17840;
                17: coefficient =  18'sd15586;
                18: coefficient =  18'sd9897;
                19: coefficient =  18'sd3369;
                20: coefficient = -18'sd1379;
                21: coefficient = -18'sd3072;
                22: coefficient = -18'sd2201;
                23: coefficient = -18'sd359;
                24: coefficient =  18'sd930;
                25: coefficient =  18'sd1064;
                26: coefficient =  18'sd417;
                27: coefficient = -18'sd241;
                28: coefficient = -18'sd414;
                29: coefficient = -18'sd155;
                30: coefficient =  18'sd156;
                31: coefficient =  18'sd217;
                32: coefficient =  18'sd33;
                default: coefficient = 18'sd0;
            endcase
        end
    endfunction

    // --------------------------------------------------------
    // Remove coefficient scaling, round and saturate.
    //
    // Rounding: nearest integer, with half-way ties toward
    // positive infinity.
    // --------------------------------------------------------
    function [15:0] quantize;
        input signed [39:0] value;

        reg signed [39:0] rounded;

        begin
            rounded = (value + 40'sd8192) >>> 14;

            if (rounded > 40'sd32767)
                quantize = 16'h7FFF;
            else if (rounded < -40'sd32768)
                quantize = 16'h8000;
            else
                quantize = rounded[15:0];
        end
    endfunction

    // --------------------------------------------------------
    // Polyphase convolution.
    //
    // phase 0 uses taps 0,4,8,...,32
    // phase 1 uses taps 1,5,9,...,29
    // phase 2 uses taps 2,6,10,...,30
    // phase 3 uses taps 3,7,11,...,31
    // --------------------------------------------------------
    always @* begin
        accumulator_i = 40'sd0;
        accumulator_q = 40'sd0;

        product_i = 34'sd0;
        product_q = 34'sd0;

        for (k = 0; k < 9; k = k + 1) begin
            product_i =
                history_i[k] * coefficient(phase + 4*k);

            product_q =
                history_q[k] * coefficient(phase + 4*k);

            accumulator_i = accumulator_i + product_i;
            accumulator_q = accumulator_q + product_q;
        end
    end

    assign m_axis_tdata = {
        quantize(accumulator_q),
        quantize(accumulator_i)
    };

    assign m_axis_tvalid =
        resetn && sample_active;

    assign m_axis_tlast =
        m_axis_tvalid &&
        flushing &&
        (flush_remaining == 6'd1);

    assign s_axis_tready =
        resetn && !sample_active;

    assign busy = packet_active;

    // --------------------------------------------------------
    // Symbol acceptance and sample output control.
    // State advances only on accepted transfers.
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            for (n = 0; n < 9; n = n + 1) begin
                history_i[n] <= 16'sd0;
                history_q[n] <= 16'sd0;
            end

            phase               <= 2'd0;
            sample_active       <= 1'b0;
            packet_active       <= 1'b0;
            current_symbol_last <= 1'b0;

            flushing            <= 1'b0;
            flush_remaining     <= 6'd0;
            packet_done         <= 1'b0;
        end
        else begin
            packet_done <= 1'b0;

            // Load one new QPSK symbol.
            if (s_axis_tvalid && s_axis_tready) begin
                for (n = 8; n > 0; n = n - 1) begin
                    history_i[n] <= history_i[n-1];
                    history_q[n] <= history_q[n-1];
                end

                history_i[0] <= $signed(s_axis_tdata[15:0]);
                history_q[0] <= $signed(s_axis_tdata[31:16]);

                phase               <= 2'd0;
                sample_active       <= 1'b1;
                packet_active       <= 1'b1;
                current_symbol_last <= s_axis_tlast;
            end

            if (m_axis_tvalid && m_axis_tready) begin

                if (flushing) begin

                    if (flush_remaining == 6'd1) begin
                        sample_active   <= 1'b0;
                        packet_active   <= 1'b0;
                        flushing        <= 1'b0;
                        flush_remaining <= 6'd0;
                        phase           <= 2'd0;
                        packet_done     <= 1'b1;

                        // Isolate the next packet from this tail.
                        for (n = 0; n < 9; n = n + 1) begin
                            history_i[n] <= 16'sd0;
                            history_q[n] <= 16'sd0;
                        end
                    end
                    else begin
                        flush_remaining <= flush_remaining - 6'd1;

                        if (phase == 2'd3) begin
                            phase <= 2'd0;

                            for (n = 8; n > 0; n = n - 1) begin
                                history_i[n] <= history_i[n-1];
                                history_q[n] <= history_q[n-1];
                            end

                            history_i[0] <= 16'sd0;
                            history_q[0] <= 16'sd0;
                        end
                        else begin
                            phase <= phase + 2'd1;
                        end
                    end

                end
                else begin

                    if (phase == 2'd3) begin
                        phase <= 2'd0;

                        if (current_symbol_last) begin
                            // The last symbol's first four
                            // samples have transferred.
                            // Emit remaining impulse-response
                            // samples through tap 32.
                            flushing        <= 1'b1;
                            flush_remaining <= 6'd29;

                            for (n = 8; n > 0; n = n - 1) begin
                                history_i[n] <= history_i[n-1];
                                history_q[n] <= history_q[n-1];
                            end

                            history_i[0] <= 16'sd0;
                            history_q[0] <= 16'sd0;
                        end
                        else begin
                            // Wait for the next input symbol.
                            sample_active <= 1'b0;
                        end
                    end
                    else begin
                        phase <= phase + 2'd1;
                    end

                end
            end
        end
    end

endmodule