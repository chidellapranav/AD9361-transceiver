`timescale 1ns / 1ps

module tb_tx_modem_burst;

    parameter PRINT_EACH_SAMPLE = 1;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg enable = 1'b0;

    wire signed [15:0] tx_i;
    wire signed [15:0] tx_q;
    wire tx_valid;

    wire burst_active;
    wire burst_last;
    wire error;

    // Repack only for testbench comparisons.
    wire [31:0] actual_sample;
    assign actual_sample = {tx_q, tx_i};

    reg [31:0] captured_samples [0:2047];

    integer capture_count = 0;
    integer sample_count  = 0;
    integer bursts        = 0;

    reg [31:0] signature = 32'd0;
    reg [31:0] expected_signature;

    reg previous_active = 1'b0;
    reg previous_last   = 1'b0;
    reg capture_complete = 1'b0;

    tx_modem_burst #(
        .PAYLOAD_BYTES (16),
        .BUFFER_SAMPLES(2048),
        .GAP_CYCLES    (32)
    ) dut (
        .clk          (clk),
        .resetn       (resetn),
        .enable       (enable),

        .tx_i         (tx_i),
        .tx_q         (tx_q),
        .tx_valid     (tx_valid),

        .burst_active (burst_active),
        .burst_last   (burst_last),
        .error        (error)
    );

    always @(posedge clk) begin
        if (!resetn) begin
            previous_active = 1'b0;
            previous_last   = 1'b0;
        end
        else begin
            if (error)
                $fatal(1, "FAIL: modem or buffer error");

            if (tx_valid !== 1'b1)
                $fatal(1, "FAIL: sample valid missing");

            // Capture the actual generated modem packet
            // before buffer playback.
            if (dut.modem_valid && dut.modem_ready) begin
                if (capture_complete)
                    $fatal(1, "FAIL: capture restarted before playback ended");

                if (capture_count >= 2048)
                    $fatal(1, "FAIL: capture overflow");

                if (dut.modem_last !== (capture_count == 1012))
                    $fatal(1, "FAIL: generated modem TLAST");

                captured_samples[capture_count] = dut.modem_data;
                capture_count = capture_count + 1;

                if (dut.modem_last)
                    capture_complete = 1'b1;
            end

            // Playback must not pause inside a burst.
            if (previous_active &&
                !previous_last &&
                !burst_active)
                $fatal(1, "FAIL: gap inside burst");

            if (!burst_active) begin
                if ((tx_i !== 16'd0) || (tx_q !== 16'd0))
                    $fatal(1, "FAIL: nonzero I/Q between bursts");

                if (burst_last)
                    $fatal(1, "FAIL: LAST outside burst");
            end
            else begin
                if (bursts >= 2)
                    $fatal(1, "FAIL: unexpected extra burst");

                if (!capture_complete || capture_count != 1013)
                    $fatal(1, "FAIL: playback began before full capture");

                if (sample_count >= 1013)
                    $fatal(1, "FAIL: extra playback sample");

                // Per-sample comparison checks storage,
                // ordering and internal I/Q separation.
                if (actual_sample !== captured_samples[sample_count])
                    $fatal(
                        1,
                        "FAIL: sample=%0d expected=%08h actual=%08h",
                        sample_count,
                        captured_samples[sample_count],
                        actual_sample
                    );

                if (burst_last !== (sample_count == 1012))
                    $fatal(
                        1,
                        "FAIL: LAST at sample %0d",
                        sample_count
                    );

                signature =
                    signature + actual_sample * (sample_count + 1);

                if (PRINT_EACH_SAMPLE)
                    $display(
                        "BURST=%0d SAMPLE=%0d I=%0d Q=%0d VALID=%b LAST=%b PASS",
                        bursts + 1,
                        sample_count,
                        tx_i,
                        tx_q,
                        tx_valid,
                        burst_last
                    );

                sample_count = sample_count + 1;

                if (burst_last) begin
                    expected_signature =
                        (bursts == 0)
                        ? 32'hF13AF905
                        : 32'hF3A0F905;

                    if (sample_count != 1013)
                        $fatal(1, "FAIL: playback length");

                    if (signature !== expected_signature)
                        $fatal(
                            1,
                            "FAIL: expected signature=%08h actual=%08h",
                            expected_signature,
                            signature
                        );

                    $display("");
                    $display(
                        "BURST %0d PASS: 1013 consecutive I/Q samples",
                        bursts + 1
                    );

                    $display(
                        "EXPECTED SIGNATURE: %08h",
                        expected_signature
                    );

                    $display(
                        "ACTUAL SIGNATURE  : %08h",
                        signature
                    );

                    bursts = bursts + 1;

                    sample_count = 0;
                    capture_count = 0;
                    capture_complete = 1'b0;
                    signature = 32'd0;
                end
            end

            previous_active = burst_active;
            previous_last   = burst_last;
        end
    end

    initial begin
        repeat (4) @(negedge clk);
        resetn = 1'b1;
        enable = 1'b1;

        wait (bursts == 2);

        @(negedge clk);
        enable = 1'b0;

        repeat (10) @(negedge clk);

        $display("");
        $display(
            "OVERALL PASS: direct I/Q outputs, buffered playback and idle zeros"
        );

        $finish;
    end

    initial begin
        #1000000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule