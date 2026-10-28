`timescale 1ns / 1ps

module tb_tx_rrc;

    parameter PRINT_EACH_SAMPLE = 1;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg start  = 1'b0;

    wire busy;
    wire packet_done;
    wire overflow_error;

    wire [31:0] sample_data;
    wire        sample_valid;
    wire        sample_last;
    reg         sample_ready = 1'b0;

    wire signed [15:0] output_i;
    wire signed [15:0] output_q;

    assign output_i = sample_data[15:0];
    assign output_q = sample_data[31:16];

    tx_rrc_top dut (
        .clk            (clk),
        .resetn         (resetn),
        .start          (start),

        .busy           (busy),
        .packet_done    (packet_done),
        .overflow_error (overflow_error),

        .m_axis_tdata   (sample_data),
        .m_axis_tvalid  (sample_valid),
        .m_axis_tlast   (sample_last),
        .m_axis_tready  (sample_ready)
    );

    localparam [63:0] PREAMBLE =
        64'h1E1E1E1E1E1E1E1E;

    localparam [31:0] SYNC_WORD =
        32'h1ACFFC1D;

    localparam [63:0] HEADER_0 =
        64'h1100001000A6C77B;

    localparam [63:0] HEADER_1 =
        64'h1101001000A66D2A;

    localparam [331:0] CODED_BODY =
        332'hD94C76B7F6A583058F0ADDFE169A38B8DBECADD1FC09040E990E808C106AD2AF668D912E89BE944DFAB;

    reg [491:0] reference_frame;

    integer taps [0:32];

    reg signed [15:0] reference_i [0:245];
    reg signed [15:0] reference_q [0:245];

    reg [31:0] reference_samples [0:1012];

    reg [31:0] expected_signature;
    reg [31:0] reference_signature;
    reg [31:0] actual_signature;

    integer frame_number = 0;
    integer input_count  = 0;
    integer sample_count = 0;
    integer done_count   = 0;
    integer passed_frames = 0;

    integer ready_cycle = 0;
    integer final_stall_cycles = 0;
    integer init_index;

    reg test_active = 1'b0;
    reg frame_complete = 1'b0;

    reg was_stalled = 1'b0;
    reg [33:0] held_output;

    // --------------------------------------------------------
    // Independent reference arithmetic
    // --------------------------------------------------------
    function signed [63:0] round_q14;
        input signed [63:0] value;
        begin
            if (value >= 0)
                round_q14 =
                    (value + 64'sd8192) / 64'sd16384;
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
    // Build reference symbols and sample-time convolution.
    // No DUT outputs are used to construct this reference.
    // --------------------------------------------------------
    task build_reference;
        input integer case_id;

        integer j;
        integer t;
        integer tap_index;

        reg [1:0] pair_value;
        reg signed [63:0] sum_i;
        reg signed [63:0] sum_q;

        begin
            if (case_id == 0) begin
                reference_frame = {
                    PREAMBLE, SYNC_WORD, HEADER_0, CODED_BODY
                };

                expected_signature = 32'hF13AF905;
            end
            else begin
                reference_frame = {
                    PREAMBLE, SYNC_WORD, HEADER_1, CODED_BODY
                };

                expected_signature = 32'hF3A0F905;
            end

            for (j = 0; j < 246; j = j + 1) begin
                pair_value =
                    reference_frame >> (2 * (245 - j));

                case (pair_value)
                    2'b00: begin
                        reference_i[j] =  16'sd8192;
                        reference_q[j] =  16'sd8192;
                    end

                    2'b01: begin
                        reference_i[j] =  16'sd8192;
                        reference_q[j] = -16'sd8192;
                    end

                    2'b11: begin
                        reference_i[j] = -16'sd8192;
                        reference_q[j] = -16'sd8192;
                    end

                    2'b10: begin
                        reference_i[j] = -16'sd8192;
                        reference_q[j] =  16'sd8192;
                    end
                endcase
            end

            reference_signature = 32'd0;

            for (t = 0; t < 1013; t = t + 1) begin
                sum_i = 64'sd0;
                sum_q = 64'sd0;

                for (j = 0; j < 246; j = j + 1) begin
                    tap_index = t - 4*j;

                    if ((tap_index >= 0) && (tap_index <= 32)) begin
                        sum_i =
                            sum_i +
                            reference_i[j] * taps[tap_index];

                        sum_q =
                            sum_q +
                            reference_q[j] * taps[tap_index];
                    end
                end

                reference_samples[t] = {
                    clip16(round_q14(sum_q)),
                    clip16(round_q14(sum_i))
                };

                // Weighted sum modulo 2^32.
                // This signature supplements per-sample checking.
                reference_signature =
                    reference_signature +
                    reference_samples[t] * (t + 1);
            end

            if (reference_signature !== expected_signature)
                $fatal(
                    1,
                    "FAIL: reference signature expected=%08h actual=%08h",
                    expected_signature,
                    reference_signature
                );
        end
    endtask

    // --------------------------------------------------------
    // Backpressure, including a forced final-sample stall.
    // --------------------------------------------------------
    always @(negedge clk) begin
        if (!resetn) begin
            sample_ready = 1'b0;
            ready_cycle = 0;
            final_stall_cycles = 0;
        end
        else begin
            ready_cycle = ready_cycle + 1;

            if ((sample_count == 1012) &&
                (final_stall_cycles < 3)) begin

                sample_ready = 1'b0;
                final_stall_cycles = final_stall_cycles + 1;
            end
            else begin
                sample_ready = ((ready_cycle % 7) >= 3);
            end

            if (sample_count != 1012)
                final_stall_cycles = 0;
        end
    end

    // --------------------------------------------------------
    // Monitors
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin
            if (overflow_error)
                $fatal(1, "FAIL: unexpected coding-buffer overflow");

            if (was_stalled &&
                ({sample_valid, sample_last, sample_data}
                    !== held_output))
                $fatal(
                    1,
                    "FAIL: final sample stream changed during stall"
                );

            was_stalled = sample_valid && !sample_ready;

            held_output = {
                sample_valid, sample_last, sample_data
            };

            if (packet_done)
                done_count = done_count + 1;

            if (sample_valid && !busy)
                $fatal(1, "FAIL: sample pending while busy is low");

            // Verify the actual QPSK stream entering the RRC.
            if (dut.symbol_valid && dut.symbol_ready) begin
                if (!test_active || input_count >= 246)
                    $fatal(1, "FAIL: unexpected QPSK symbol");

                if (dut.symbol_data !== {
                    reference_q[input_count],
                    reference_i[input_count]
                })
                    $fatal(
                        1,
                        "FAIL: QPSK mismatch at symbol %0d",
                        input_count
                    );

                if (dut.symbol_last !== (input_count == 245))
                    $fatal(1, "FAIL: QPSK TLAST");

                input_count = input_count + 1;
            end

            // Verify each accepted final sample.
            if (sample_valid && sample_ready) begin
                if (!test_active || frame_complete)
                    $fatal(1, "FAIL: unexpected output sample");

                if (sample_count >= 1013)
                    $fatal(1, "FAIL: extra output sample");

                if (sample_data !== reference_samples[sample_count])
                    $fatal(
                        1,
                        "FAIL: frame=%0d sample=%0d expected=%08h actual=%08h",
                        frame_number,
                        sample_count,
                        reference_samples[sample_count],
                        sample_data
                    );

                if (sample_last !== (sample_count == 1012))
                    $fatal(
                        1,
                        "FAIL: sample TLAST at index %0d",
                        sample_count
                    );

                actual_signature =
                    actual_signature +
                    sample_data * (sample_count + 1);

                if (PRINT_EACH_SAMPLE)
                    $display(
                        "FRAME=%0d SAMPLE=%0d I=%0d Q=%0d PACKED=%08h LAST=%b PASS",
                        frame_number,
                        sample_count,
                        output_i,
                        output_q,
                        sample_data,
                        sample_last
                    );

                sample_count = sample_count + 1;

                if (sample_count == 1013) begin
                    if (input_count != 246)
                        $fatal(1, "FAIL: missing QPSK symbols");

                    if (actual_signature !== expected_signature)
                        $fatal(1, "FAIL: output signature mismatch");

                    $display("");
                    $display("========================================");
                    $display("FRAME %0d PASS", frame_number);
                    $display("QPSK SYMBOLS CHECKED: %0d", input_count);
                    $display("RRC SAMPLES CHECKED : %0d", sample_count);

                    $display(
                        "EXPECTED SIGNATURE : %08h",
                        expected_signature
                    );

                    $display(
                        "ACTUAL SIGNATURE   : %08h",
                        actual_signature
                    );

                    $display(
                        "PASS: every sample matches direct convolution"
                    );

                    $display("========================================");

                    passed_frames = passed_frames + 1;
                    frame_complete = 1'b1;
                end
            end
        end
    end

    task run_frame;
        input integer case_id;

        begin
            wait (!busy);
            @(negedge clk);

            frame_number = case_id + 1;
            input_count = 0;
            sample_count = 0;
            actual_signature = 32'd0;
            frame_complete = 1'b0;

            build_reference(case_id);
            test_active = 1'b1;

            @(negedge clk);
            start = 1'b1;

            @(negedge clk);
            start = 1'b0;

            wait (frame_complete);
            wait (!busy);

            repeat (4) @(negedge clk);

            if (done_count != case_id + 1)
                $fatal(
                    1,
                    "FAIL: completion count expected=%0d actual=%0d",
                    case_id + 1,
                    done_count
                );

            test_active = 1'b0;
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

        for (init_index = 17;
             init_index < 33;
             init_index = init_index + 1)
            taps[init_index] = taps[32 - init_index];

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        run_frame(0);
        run_frame(1);

        if (passed_frames != 2)
            $fatal(1, "FAIL: incomplete frame tests");

        $display("");
        $display(
            "OVERALL PASS: complete TX through RRC, 1013 samples per frame, restart and backpressure"
        );

        $finish;
    end

    initial begin
        #1000000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule