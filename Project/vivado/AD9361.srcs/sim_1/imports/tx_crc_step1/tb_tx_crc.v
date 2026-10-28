`timescale 1ns / 1ps

module tb_tx_scrambler;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg start  = 1'b0;

    // --------------------------------------------------------
    // Before scrambling: payload + CRC
    // --------------------------------------------------------
    wire [7:0] before_data;
    wire       before_valid;
    wire       before_last;
    wire       before_ready;
    wire       source_busy;
    wire       source_done;

    // --------------------------------------------------------
    // Scrambled stream
    // --------------------------------------------------------
    wire [7:0] scrambled_data;
    wire       scrambled_valid;
    wire       scrambled_last;
    wire       scrambled_ready;

    // --------------------------------------------------------
    // Recovered stream
    // --------------------------------------------------------
    wire [7:0] recovered_data;
    wire       recovered_valid;
    wire       recovered_last;
    reg        recovered_ready = 1'b0;

    tx_payload_crc_top #(
        .PAYLOAD_BYTES(16)
    ) source (
        .clk            (clk),
        .resetn         (resetn),
        .start          (start),
        .busy           (source_busy),
        .packet_done    (source_done),

        .m_axis_tdata   (before_data),
        .m_axis_tvalid  (before_valid),
        .m_axis_tlast   (before_last),
        .m_axis_tready  (before_ready)
    );

    packet_scrambler scrambler (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (before_data),
        .s_axis_tvalid  (before_valid),
        .s_axis_tlast   (before_last),
        .s_axis_tready  (before_ready),

        .m_axis_tdata   (scrambled_data),
        .m_axis_tvalid  (scrambled_valid),
        .m_axis_tlast   (scrambled_last),
        .m_axis_tready  (scrambled_ready)
    );

    // Same seed and operations recover the original stream.
    packet_scrambler descrambler (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (scrambled_data),
        .s_axis_tvalid  (scrambled_valid),
        .s_axis_tlast   (scrambled_last),
        .s_axis_tready  (scrambled_ready),

        .m_axis_tdata   (recovered_data),
        .m_axis_tvalid  (recovered_valid),
        .m_axis_tlast   (recovered_last),
        .m_axis_tready  (recovered_ready)
    );

    // --------------------------------------------------------
    // Reference data and captured actual transfers
    // --------------------------------------------------------
    reg [7:0] expected_plain     [0:19];
    reg [7:0] expected_scrambled [0:19];

    reg [7:0] captured_before    [0:19];
    reg [7:0] captured_scrambled [0:19];
    reg [7:0] captured_recovered [0:19];

    integer before_count    = 0;
    integer scrambled_count = 0;
    integer recovered_count = 0;
    integer packets         = 0;

    integer ready_cycle = 0;
    integer i;
    integer j;

    // Saved output values for stall checks:
    // {VALID, LAST, DATA}
    reg [9:0] held_before;
    reg [9:0] held_scrambled;
    reg [9:0] held_recovered;

    reg stalled_before    = 1'b0;
    reg stalled_scrambled = 1'b0;
    reg stalled_recovered = 1'b0;

    // --------------------------------------------------------
    // Deliberate downstream backpressure
    // --------------------------------------------------------
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle    = 0;
            recovered_ready = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;
            recovered_ready = ((ready_cycle % 7) >= 3);
        end
    end

    // --------------------------------------------------------
    // Monitor and verify all three streams
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            stalled_before    = 1'b0;
            stalled_scrambled = 1'b0;
            stalled_recovered = 1'b0;
        end
        else begin

            // Stability checks include the edge on which
            // READY returns high.
            if (stalled_before &&
                ({before_valid, before_last, before_data}
                    !== held_before))
                $fatal(1, "FAIL: before stream changed during stall");

            if (stalled_scrambled &&
                ({scrambled_valid, scrambled_last, scrambled_data}
                    !== held_scrambled))
                $fatal(1, "FAIL: scrambled stream changed during stall");

            if (stalled_recovered &&
                ({recovered_valid, recovered_last, recovered_data}
                    !== held_recovered))
                $fatal(1, "FAIL: recovered stream changed during stall");

            stalled_before =
                before_valid && !before_ready;

            stalled_scrambled =
                scrambled_valid && !scrambled_ready;

            stalled_recovered =
                recovered_valid && !recovered_ready;

            held_before =
                {before_valid, before_last, before_data};

            held_scrambled =
                {scrambled_valid, scrambled_last, scrambled_data};

            held_recovered =
                {recovered_valid, recovered_last, recovered_data};

            // ---------- Before scrambling ----------
            if (before_valid && before_ready) begin
                if (before_count >= 20)
                    $fatal(1, "FAIL: extra input byte");

                captured_before[before_count] = before_data;

                if (before_data !== expected_plain[before_count])
                    $fatal(
                        1,
                        "FAIL: input byte %0d expected=%02h actual=%02h",
                        before_count,
                        expected_plain[before_count],
                        before_data
                    );

                if (before_last !== (before_count == 19))
                    $fatal(1, "FAIL: input TLAST");

                before_count = before_count + 1;
            end

            // ---------- After scrambling ----------
            if (scrambled_valid && scrambled_ready) begin
                if (scrambled_count >= 20)
                    $fatal(1, "FAIL: extra scrambled byte");

                captured_scrambled[scrambled_count] =
                    scrambled_data;

                if (scrambled_data !==
                    expected_scrambled[scrambled_count])
                    $fatal(
                        1,
                        "FAIL: scrambled byte %0d expected=%02h actual=%02h",
                        scrambled_count,
                        expected_scrambled[scrambled_count],
                        scrambled_data
                    );

                if (scrambled_last !== (scrambled_count == 19))
                    $fatal(1, "FAIL: scrambled TLAST");

                scrambled_count = scrambled_count + 1;
            end

            // ---------- After descrambling ----------
            if (recovered_valid && recovered_ready) begin
                if (recovered_count >= 20)
                    $fatal(1, "FAIL: extra recovered byte");

                captured_recovered[recovered_count] =
                    recovered_data;

                if (recovered_data !==
                    expected_plain[recovered_count])
                    $fatal(
                        1,
                        "FAIL: recovered byte %0d expected=%02h actual=%02h",
                        recovered_count,
                        expected_plain[recovered_count],
                        recovered_data
                    );

                if (recovered_last !== (recovered_count == 19))
                    $fatal(1, "FAIL: recovered TLAST");

                recovered_count = recovered_count + 1;

                if (recovered_count == 20) begin
                    if ((before_count != 20) ||
                        (scrambled_count != 20))
                        $fatal(1, "FAIL: stream length mismatch");

                    $display("");
                    $display("PACKET %0d", packets + 1);

                    $write("BEFORE SCRAMBLING : ");
                    for (j = 0; j < 20; j = j + 1)
                        $write("%02h ", captured_before[j]);

                    $write("\nAFTER SCRAMBLING  : ");
                    for (j = 0; j < 20; j = j + 1)
                        $write("%02h ", captured_scrambled[j]);

                    $write("\nAFTER DESCRAMBLING: ");
                    for (j = 0; j < 20; j = j + 1)
                        $write("%02h ", captured_recovered[j]);

                    $write("\nRECOVERED CRC BYTES: ");
                    for (j = 16; j < 20; j = j + 1)
                        $write("%02h ", captured_recovered[j]);

                    $display("");
                    $display(
                        "PASS: fixed reference, recovery and TLAST"
                    );

                    before_count    = 0;
                    scrambled_count = 0;
                    recovered_count = 0;
                    packets = packets + 1;
                end
            end
        end
    end

    task launch_packet;
        begin
            wait (source_busy == 1'b0);
            @(negedge clk);
            start = 1'b1;
            @(negedge clk);
            start = 1'b0;
        end
    endtask

    initial begin
        for (i = 0; i < 16; i = i + 1)
            expected_plain[i] = i;

        expected_plain[16] = 8'h88;
        expected_plain[17] = 8'hE2;
        expected_plain[18] = 8'hCE;
        expected_plain[19] = 8'hCE;

        // Fixed reference generated independently in Python.
        expected_scrambled[ 0] = 8'h7F;
        expected_scrambled[ 1] = 8'hB9;
        expected_scrambled[ 2] = 8'hA5;
        expected_scrambled[ 3] = 8'h4A;
        expected_scrambled[ 4] = 8'h24;
        expected_scrambled[ 5] = 8'h37;
        expected_scrambled[ 6] = 8'hBC;
        expected_scrambled[ 7] = 8'h31;
        expected_scrambled[ 8] = 8'h90;
        expected_scrambled[ 9] = 8'h9C;
        expected_scrambled[10] = 8'hF9;
        expected_scrambled[11] = 8'h1D;
        expected_scrambled[12] = 8'hA6;
        expected_scrambled[13] = 8'h22;
        expected_scrambled[14] = 8'hCB;
        expected_scrambled[15] = 8'h81;
        expected_scrambled[16] = 8'hB7;
        expected_scrambled[17] = 8'h3E;
        expected_scrambled[18] = 8'h1D;
        expected_scrambled[19] = 8'hEA;

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        launch_packet;
        wait (packets == 1);

        // Second identical packet verifies seed restart.
        launch_packet;
        wait (packets == 2);

        repeat (4) @(negedge clk);

        $display("");
        $display(
            "OVERALL PASS: two packets, seed restart and backpressure"
        );
        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule