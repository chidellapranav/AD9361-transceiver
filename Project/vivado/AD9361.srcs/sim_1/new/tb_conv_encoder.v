`timescale 1ns / 1ps

module tb_conv_encoder;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;

    reg  [7:0] input_data  = 8'h00;
    reg        input_valid = 1'b0;
    reg        input_last  = 1'b0;
    wire       input_ready;

    wire [1:0] coded_pair;
    wire       coded_valid;
    wire       coded_last;
    reg        coded_ready = 1'b0;

    wire packet_done;

    conv_encoder dut (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (input_data),
        .s_axis_tvalid  (input_valid),
        .s_axis_tlast   (input_last),
        .s_axis_tready  (input_ready),

        .m_axis_tdata   (coded_pair),
        .m_axis_tvalid  (coded_valid),
        .m_axis_tlast   (coded_last),
        .m_axis_tready  (coded_ready),

        .packet_done    (packet_done)
    );

    // First transmitted pair occupies bits [43:42].
    // Each pair is ordered {generator171, generator133}.
    localparam [43:0] EXPECTED = 44'hE1D5B6E96B0;

    reg [7:0] expected_input [0:1];
    reg [7:0] captured_input [0:1];
    reg [1:0] captured_pairs [0:21];

    reg [43:0] actual_bits = 44'd0;
    reg [1:0] expected_pair;

    integer input_count = 0;
    integer pair_count  = 0;
    integer packets     = 0;
    integer ready_cycle = 0;
    integer j;

    reg       was_stalled = 1'b0;
    reg [3:0] held_output;

    // Deliberately apply multi-cycle backpressure.
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle = 0;
            coded_ready = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;
            coded_ready = ((ready_cycle % 7) >= 3);
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin

            // Check stability through stalled cycles.
            if (was_stalled &&
                ({coded_valid, coded_last, coded_pair}
                    !== held_output))
                $fatal(
                    1,
                    "FAIL: coded output changed during stall"
                );

            was_stalled = coded_valid && !coded_ready;

            held_output =
                {coded_valid, coded_last, coded_pair};

            // Capture accepted input bytes.
            if (input_valid && input_ready) begin
                if (input_count >= 2)
                    $fatal(1, "FAIL: extra input byte");

                captured_input[input_count] = input_data;

                if (input_data !== expected_input[input_count])
                    $fatal(1, "FAIL: unexpected input data");

                if (input_last !== (input_count == 1))
                    $fatal(1, "FAIL: input TLAST");

                input_count = input_count + 1;
            end

            // Capture accepted coded pairs.
            if (coded_valid && coded_ready) begin
                if (pair_count >= 22)
                    $fatal(1, "FAIL: extra coded pair");

                expected_pair =
                    EXPECTED >> (2 * (21 - pair_count));

                if (coded_pair !== expected_pair)
                    $fatal(
                        1,
                        "FAIL: pair %0d expected=%02b actual=%02b",
                        pair_count,
                        expected_pair,
                        coded_pair
                    );

                if (coded_last !== (pair_count == 21))
                    $fatal(
                        1,
                        "FAIL: TLAST incorrect at pair %0d",
                        pair_count
                    );

                captured_pairs[pair_count] = coded_pair;

                actual_bits = {
                    actual_bits[41:0],
                    coded_pair
                };

                pair_count = pair_count + 1;

                if (pair_count == 22) begin
                    if (input_count != 2)
                        $fatal(1, "FAIL: input length mismatch");

                    if (actual_bits !== EXPECTED)
                        $fatal(1, "FAIL: complete vector mismatch");

                    $display("");
                    $display("PACKET %0d", packets + 1);

                    $display(
                        "INPUT BYTES: %02h %02h",
                        captured_input[0],
                        captured_input[1]
                    );

                    $display(
                        "INPUT BIT ORDER: each byte bit 0 first"
                    );

                    $write("PAYLOAD CODED PAIRS: ");
                    for (j = 0; j < 16; j = j + 1)
                        $write("%02b ", captured_pairs[j]);

                    $write("\nTAIL CODED PAIRS   : ");
                    for (j = 16; j < 22; j = j + 1)
                        $write("%02b ", captured_pairs[j]);

                    $display("");
                    $display(
                        "EXPECTED CODED BITS: %044b",
                        EXPECTED
                    );

                    $display(
                        "ACTUAL CODED BITS  : %044b",
                        actual_bits
                    );

                    $display(
                        "PASS: 22 pairs, fixed reference and TLAST"
                    );

                    input_count = 0;
                    pair_count  = 0;
                    actual_bits = 44'd0;
                    packets     = packets + 1;
                end
            end
        end
    end

    task send_packet;
        integer k;
        begin
            for (k = 0; k < 2; k = k + 1) begin
                @(negedge clk);

                input_data  = expected_input[k];
                input_valid = 1'b1;
                input_last  = (k == 1);

                @(posedge clk);
                while (!input_ready)
                    @(posedge clk);
            end

            @(negedge clk);
            input_valid = 1'b0;
            input_last  = 1'b0;
        end
    endtask

    initial begin
        expected_input[0] = 8'hA5;
        expected_input[1] = 8'h3C;

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        send_packet;
        wait (packets == 1);

        // Inspect state after sequential updates have completed.
        @(negedge clk);
        if (dut.state !== 6'd0)
            $fatal(1, "FAIL: encoder did not terminate at zero");

        if (packet_done !== 1'b1)
            $fatal(1, "FAIL: packet_done missing");

        // Send the same packet again without resetting the DUT.
        send_packet;
        wait (packets == 2);

        @(negedge clk);
        if (dut.state !== 6'd0)
            $fatal(1, "FAIL: second packet termination");

        if (packet_done !== 1'b1)
            $fatal(1, "FAIL: second packet_done missing");

        repeat (4) @(negedge clk);

        $display("");
        $display(
            "OVERALL PASS: reference, restart, termination and backpressure"
        );
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule