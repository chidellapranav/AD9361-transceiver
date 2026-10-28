`timescale 1ns / 1ps

module tb_rrc_multisymbol;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;

    reg [31:0] input_data = 32'd0;
    reg input_valid = 1'b0;
    reg input_last  = 1'b0;
    wire input_ready;

    wire [31:0] output_data;
    wire output_valid;
    wire output_last;
    reg  output_ready = 1'b0;

    wire busy;
    wire packet_done;

    wire signed [15:0] output_i;
    wire signed [15:0] output_q;

    assign output_i = output_data[15:0];
    assign output_q = output_data[31:16];

    rrc_interpolator dut (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (input_data),
        .s_axis_tvalid  (input_valid),
        .s_axis_tlast   (input_last),
        .s_axis_tready  (input_ready),

        .m_axis_tdata   (output_data),
        .m_axis_tvalid  (output_valid),
        .m_axis_tlast   (output_last),
        .m_axis_tready  (output_ready),

        .busy           (busy),
        .packet_done    (packet_done)
    );

    // --------------------------------------------------------
    // Reference model storage
    // --------------------------------------------------------
    integer taps [0:32];

    reg signed [15:0] symbols_i [0:5];
    reg signed [15:0] symbols_q [0:5];

    reg [31:0] reference [0:63];

    integer symbol_length = 0;
    integer expected_samples = 0;

    integer input_count = 0;
    integer sample_count = 0;
    integer passed_tests = 0;
    integer done_count = 0;

    integer positive_clips = 0;
    integer negative_clips = 0;

    integer ready_cycle = 0;
    integer test_number = 0;
    integer init_index;

    reg test_active = 1'b0;
    reg test_complete = 1'b0;

    reg [31:0] expected_signature;
    reg [31:0] reference_signature;
    reg [31:0] actual_signature;

    reg was_stalled = 1'b0;
    reg [33:0] held_output;

    // --------------------------------------------------------
    // Reference rounding:
    // nearest integer, ties toward positive infinity.
    //
    // Division-based model, independent of DUT's arithmetic
    // right-shift implementation.
    // --------------------------------------------------------
    function signed [63:0] round_q14;
        input signed [63:0] value;

        begin
            if (value >= 0)
                round_q14 = (value + 64'sd8192) / 64'sd16384;
            else
                round_q14 =
                    -((-value + 64'sd8191) / 64'sd16384);
        end
    endfunction

    function [15:0] clip16;
        input signed [63:0] value;

        begin
            if (value > 64'sd32767)
                clip16 = 16'h7FFF;
            else if (value < -64'sd32768)
                clip16 = 16'h8000;
            else
                clip16 = value[15:0];
        end
    endfunction

    // --------------------------------------------------------
    // Direct convolution:
    //
    // y[t] = SUM(symbol[j] * taps[t - 4*j])
    //
    // Valid tap indices are 0 through 32.
    // --------------------------------------------------------
    task build_reference;
        integer t;
        integer j;
        integer tap_index;

        reg signed [63:0] sum_i;
        reg signed [63:0] sum_q;
        reg signed [63:0] rounded_i;
        reg signed [63:0] rounded_q;

        begin
            expected_samples = 4 * (symbol_length - 1) + 33;

            positive_clips = 0;
            negative_clips = 0;
            reference_signature = 32'd0;

            for (t = 0; t < expected_samples; t = t + 1) begin
                sum_i = 64'sd0;
                sum_q = 64'sd0;

                for (j = 0; j < symbol_length; j = j + 1) begin
                    tap_index = t - 4*j;

                    if ((tap_index >= 0) && (tap_index <= 32)) begin
                        sum_i =
                            sum_i + symbols_i[j] * taps[tap_index];

                        sum_q =
                            sum_q + symbols_q[j] * taps[tap_index];
                    end
                end

                rounded_i = round_q14(sum_i);
                rounded_q = round_q14(sum_q);

                if (rounded_i > 32767)
                    positive_clips = positive_clips + 1;

                if (rounded_q > 32767)
                    positive_clips = positive_clips + 1;

                if (rounded_i < -32768)
                    negative_clips = negative_clips + 1;

                if (rounded_q < -32768)
                    negative_clips = negative_clips + 1;

                reference[t] = {
                    clip16(rounded_q),
                    clip16(rounded_i)
                };

                // Weighted sum modulo 2^32.
                // An additional cross-check, not a CRC.
                reference_signature =
                    reference_signature + reference[t] * (t + 1);
            end

            if (reference_signature !== expected_signature)
                $fatal(
                    1,
                    "FAIL: reference model signature expected=%08h actual=%08h",
                    expected_signature,
                    reference_signature
                );
        end
    endtask

    // --------------------------------------------------------
    // Deliberate output stalls
    // --------------------------------------------------------
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle  = 0;
            output_ready = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;
            output_ready = ((ready_cycle % 7) >= 3);
        end
    end

    // --------------------------------------------------------
    // Monitor actual accepted input/output transfers
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin

            if (was_stalled &&
                ({output_valid, output_last, output_data}
                    !== held_output))
                $fatal(
                    1,
                    "FAIL: RRC output changed during stall"
                );

            was_stalled = output_valid && !output_ready;

            held_output = {
                output_valid,
                output_last,
                output_data
            };

            if (packet_done)
                done_count = done_count + 1;

            if (output_valid && !busy)
                $fatal(1, "FAIL: pending output while busy is low");

            if (input_valid && input_ready) begin
                if (!test_active || input_count >= symbol_length)
                    $fatal(1, "FAIL: unexpected input symbol");

                if (input_data !== {
                    symbols_q[input_count],
                    symbols_i[input_count]
                })
                    $fatal(1, "FAIL: input symbol mismatch");

                if (input_last !==
                    (input_count == symbol_length - 1))
                    $fatal(1, "FAIL: input TLAST");

                input_count = input_count + 1;
            end

            if (output_valid && output_ready) begin

                if (!test_active || test_complete)
                    $fatal(1, "FAIL: unexpected output sample");

                if (sample_count >= expected_samples)
                    $fatal(1, "FAIL: too many output samples");

                if (output_data !== reference[sample_count])
                    $fatal(
                        1,
                        "FAIL: test=%0d sample=%0d expected=%08h actual=%08h",
                        test_number,
                        sample_count,
                        reference[sample_count],
                        output_data
                    );

                if (output_last !==
                    (sample_count == expected_samples - 1))
                    $fatal(
                        1,
                        "FAIL: output TLAST at sample %0d",
                        sample_count
                    );

                actual_signature =
                    actual_signature +
                    output_data * (sample_count + 1);

                $display(
                    "TEST=%0d SAMPLE=%0d I=%0d Q=%0d PACKED=%08h LAST=%b PASS",
                    test_number,
                    sample_count,
                    output_i,
                    output_q,
                    output_data,
                    output_last
                );

                sample_count = sample_count + 1;

                if (sample_count == expected_samples) begin
                    if (input_count != symbol_length)
                        $fatal(1, "FAIL: missing input symbols");

                    if (actual_signature !== expected_signature)
                        $fatal(1, "FAIL: output signature mismatch");

                    $display("");
                    $display(
                        "TEST %0d PASS: all %0d samples match direct convolution",
                        test_number,
                        expected_samples
                    );

                    $display(
                        "EXPECTED SIGNATURE: %08h",
                        expected_signature
                    );

                    $display(
                        "ACTUAL SIGNATURE  : %08h",
                        actual_signature
                    );

                    $display(
                        "REFERENCE SATURATION EVENTS: positive=%0d negative=%0d",
                        positive_clips,
                        negative_clips
                    );

                    passed_tests = passed_tests + 1;
                    test_complete = 1'b1;
                end
            end
        end
    end

    // --------------------------------------------------------
    // Configure and run one packet
    // --------------------------------------------------------
    task run_test;
        input integer case_id;

        integer j;

        begin
            wait (!busy);
            @(negedge clk);

            test_number = case_id + 1;

            input_count     = 0;
            sample_count    = 0;
            actual_signature = 32'd0;
            test_complete   = 1'b0;

            if (case_id == 0) begin
                symbol_length = 4;
                expected_signature = 32'h03690142;

                // QPSK sequence: 00, 01, 11, 10.
                symbols_i[0] =  16'sd8192;
                symbols_q[0] =  16'sd8192;

                symbols_i[1] =  16'sd8192;
                symbols_q[1] = -16'sd8192;

                symbols_i[2] = -16'sd8192;
                symbols_q[2] = -16'sd8192;

                symbols_i[3] = -16'sd8192;
                symbols_q[3] =  16'sd8192;
            end
            else begin
                symbol_length = 6;
                expected_signature = 32'h93316CE1;

                // Deliberately large input to force saturation.
                for (j = 0; j < 6; j = j + 1) begin
                    symbols_i[j] = 16'sh7FFF;
                    symbols_q[j] = 16'sh8000;
                end
            end

            build_reference;

            if (case_id == 0) begin
                if ((positive_clips != 0) || (negative_clips != 0))
                    $fatal(1, "FAIL: unexpected clipping in QPSK reference");
            end
            else begin
                if ((positive_clips != 12) || (negative_clips != 12))
                    $fatal(1, "FAIL: saturation reference mismatch");
            end

            test_active = 1'b1;

            $display("");
            $display("========================================");
            $display("START TEST %0d", test_number);

            // Add input-valid gaps between some symbols.
            for (j = 0; j < symbol_length; j = j + 1) begin
                repeat (j % 3) @(negedge clk);

                @(negedge clk);
                input_data = {symbols_q[j], symbols_i[j]};
                input_valid = 1'b1;
                input_last = (j == symbol_length - 1);

                $display(
                    "INPUT SYMBOL %0d: I=%0d Q=%0d",
                    j,
                    symbols_i[j],
                    symbols_q[j]
                );

                @(posedge clk);
                while (!input_ready)
                    @(posedge clk);

                @(negedge clk);
                input_valid = 1'b0;
                input_last  = 1'b0;
            end

            wait (test_complete);

            repeat (4) @(negedge clk);

            if (busy)
                $fatal(1, "FAIL: filter remained busy");

            if (done_count != case_id + 1)
                $fatal(1, "FAIL: completion pulse count");

            test_active = 1'b0;

            $display("========================================");
        end
    endtask

    initial begin
        taps[ 0] =    33;
        taps[ 1] =   217;
        taps[ 2] =   156;
        taps[ 3] =  -155;
        taps[ 4] =  -414;
        taps[ 5] =  -241;
        taps[ 6] =   417;
        taps[ 7] =  1064;
        taps[ 8] =   930;
        taps[ 9] =  -359;
        taps[10] = -2201;
        taps[11] = -3072;
        taps[12] = -1379;
        taps[13] =  3369;
        taps[14] =  9897;
        taps[15] = 15586;
        taps[16] = 17840;

        // Symmetric second half of the filter.
        for (init_index = 17;
             init_index < 33;
             init_index = init_index + 1)
            taps[init_index] = taps[32 - init_index];

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        run_test(0);
        run_test(1);

        if (passed_tests != 2)
            $fatal(1, "FAIL: incomplete tests");

        $display("");
        $display(
            "OVERALL PASS: multi-symbol RRC convolution, saturation, tail, restart and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule