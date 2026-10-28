`timescale 1ns / 1ps

module tb_tx_coded;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg start  = 1'b0;

    wire busy;
    wire packet_done;

    wire [1:0] coded_pair;
    wire       coded_valid;
    wire       coded_last;
    reg        coded_ready = 1'b0;

    tx_coded_top #(
        .PAYLOAD_BYTES(16)
    ) dut (
        .clk            (clk),
        .resetn         (resetn),
        .start          (start),

        .busy           (busy),
        .packet_done    (packet_done),

        .m_axis_tdata   (coded_pair),
        .m_axis_tvalid  (coded_valid),
        .m_axis_tlast   (coded_last),
        .m_axis_tready  (coded_ready)
    );

    // First transmitted byte occupies the highest eight bits.
    localparam [159:0] EXPECTED_CRC_STREAM =
        160'h000102030405060708090A0B0C0D0E0F88E2CECE;

    localparam [159:0] EXPECTED_SCRAMBLED =
        160'h7FB9A54A2437BC31909CF91DA622CB81B73E1DEA;

    // First transmitted pair occupies bits [331:330].
    // Pair ordering: {generator171, generator133}.
    localparam [331:0] EXPECTED_CODED =
        332'hD94C76B7F6A583058F0ADDFE169A38B8DBECADD1FC09040E990E808C106AD2AF668D912E89BE944DFAB;

    reg [7:0] crc_capture       [0:19];
    reg [7:0] scrambled_capture [0:19];
    reg [1:0] coded_capture     [0:165];

    reg [7:0] expected_byte;
    reg [1:0] expected_pair;
    reg [331:0] actual_coded = 332'd0;

    integer crc_count       = 0;
    integer scrambled_count = 0;
    integer coded_count     = 0;

    integer packets         = 0;
    integer done_count      = 0;
    integer ready_cycle     = 0;
    integer j;

    // Stability-check storage.
    reg       crc_stalled = 1'b0;
    reg       scr_stalled = 1'b0;
    reg       fec_stalled = 1'b0;

    reg [9:0] held_crc;
    reg [9:0] held_scr;
    reg [3:0] held_fec;

    // --------------------------------------------------------
    // Periodic multi-cycle downstream stalls
    // --------------------------------------------------------
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

    // --------------------------------------------------------
    // Stream monitors
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            crc_stalled = 1'b0;
            scr_stalled = 1'b0;
            fec_stalled = 1'b0;
        end
        else begin

            // ---------- Backpressure stability ----------
            if (crc_stalled &&
                ({dut.crc_valid, dut.crc_last, dut.crc_data}
                    !== held_crc))
                $fatal(1, "FAIL: CRC stream changed during stall");

            if (scr_stalled &&
                ({dut.scrambled_valid,
                  dut.scrambled_last,
                  dut.scrambled_data} !== held_scr))
                $fatal(
                    1,
                    "FAIL: scrambled stream changed during stall"
                );

            if (fec_stalled &&
                ({coded_valid, coded_last, coded_pair}
                    !== held_fec))
                $fatal(1, "FAIL: FEC stream changed during stall");

            crc_stalled =
                dut.crc_valid && !dut.crc_ready;

            scr_stalled =
                dut.scrambled_valid && !dut.scrambled_ready;

            fec_stalled =
                coded_valid && !coded_ready;

            held_crc =
                {dut.crc_valid, dut.crc_last, dut.crc_data};

            held_scr =
                {dut.scrambled_valid,
                 dut.scrambled_last,
                 dut.scrambled_data};

            held_fec =
                {coded_valid, coded_last, coded_pair};

            // ---------- Completion pulse ----------
            if (packet_done) begin
                if (!busy)
                    $fatal(
                        1,
                        "FAIL: busy cleared before completion was reported"
                    );

                done_count = done_count + 1;
            end

            // ---------- CRC stream ----------
            if (dut.crc_valid && dut.crc_ready) begin
                if (crc_count >= 20)
                    $fatal(1, "FAIL: extra CRC-stream byte");

                expected_byte =
                    EXPECTED_CRC_STREAM >> (8 * (19 - crc_count));

                if (dut.crc_data !== expected_byte)
                    $fatal(
                        1,
                        "FAIL: CRC-stream byte %0d expected=%02h actual=%02h",
                        crc_count,
                        expected_byte,
                        dut.crc_data
                    );

                if (dut.crc_last !== (crc_count == 19))
                    $fatal(1, "FAIL: CRC-stream TLAST");

                crc_capture[crc_count] = dut.crc_data;
                crc_count = crc_count + 1;
            end

            // ---------- Scrambled stream ----------
            if (dut.scrambled_valid && dut.scrambled_ready) begin
                if (scrambled_count >= 20)
                    $fatal(1, "FAIL: extra scrambled byte");

                expected_byte =
                    EXPECTED_SCRAMBLED >>
                    (8 * (19 - scrambled_count));

                if (dut.scrambled_data !== expected_byte)
                    $fatal(
                        1,
                        "FAIL: scrambled byte %0d expected=%02h actual=%02h",
                        scrambled_count,
                        expected_byte,
                        dut.scrambled_data
                    );

                if (dut.scrambled_last !==
                    (scrambled_count == 19))
                    $fatal(1, "FAIL: scrambled TLAST");

                scrambled_capture[scrambled_count] =
                    dut.scrambled_data;

                scrambled_count = scrambled_count + 1;
            end

            // ---------- FEC stream ----------
            if (coded_valid && coded_ready) begin
                if (!busy)
                    $fatal(1, "FAIL: coded output while not busy");

                if (coded_count >= 166)
                    $fatal(1, "FAIL: extra coded pair");

                expected_pair =
                    EXPECTED_CODED >> (2 * (165 - coded_count));

                if (coded_pair !== expected_pair)
                    $fatal(
                        1,
                        "FAIL: coded pair %0d expected=%02b actual=%02b",
                        coded_count,
                        expected_pair,
                        coded_pair
                    );

                if (coded_last !== (coded_count == 165))
                    $fatal(
                        1,
                        "FAIL: coded TLAST at pair %0d",
                        coded_count
                    );

                coded_capture[coded_count] = coded_pair;

                actual_coded = {
                    actual_coded[329:0],
                    coded_pair
                };

                coded_count = coded_count + 1;

                if (coded_count == 166) begin
                    if ((crc_count != 20) ||
                        (scrambled_count != 20))
                        $fatal(1, "FAIL: intermediate length mismatch");

                    if (actual_coded !== EXPECTED_CODED)
                        $fatal(1, "FAIL: complete FEC vector mismatch");

                    $display("");
                    $display("========================================");
                    $display("PACKET %0d", packets + 1);

                    $write("PAYLOAD + CRC: ");
                    for (j = 0; j < 20; j = j + 1)
                        $write("%02h ", crc_capture[j]);

                    $write("\nSCRAMBLED    : ");
                    for (j = 0; j < 20; j = j + 1)
                        $write("%02h ", scrambled_capture[j]);

                    $write("\nFEC DATA PAIRS (160):\n");
                    for (j = 0; j < 160; j = j + 1) begin
                        $write("%02b ", coded_capture[j]);

                        if ((j % 16) == 15)
                            $write("\n");
                    end

                    $write("FEC TAIL PAIRS (6): ");
                    for (j = 160; j < 166; j = j + 1)
                        $write("%02b ", coded_capture[j]);

                    $display("");
                    $display(
                        "EXPECTED CODED HEX: %083h",
                        EXPECTED_CODED
                    );

                    $display(
                        "ACTUAL CODED HEX  : %083h",
                        actual_coded
                    );

                    $display(
                        "PASS: CRC, scrambler, 166 FEC pairs and TLAST"
                    );

                    $display("========================================");

                    crc_count       = 0;
                    scrambled_count = 0;
                    coded_count     = 0;
                    actual_coded    = 332'd0;

                    packets = packets + 1;
                end
            end
        end
    end

    task launch_packet;
        begin
            wait (busy == 1'b0);
            @(negedge clk);
            start = 1'b1;
            @(negedge clk);
            start = 1'b0;
        end
    endtask

    initial begin
        repeat (4) @(negedge clk);
        resetn = 1'b1;

        launch_packet;
        wait (packets == 1);
        wait (busy == 1'b0);

        @(negedge clk);
        if (dut.fec.state !== 6'd0)
            $fatal(1, "FAIL: first packet did not terminate");

        launch_packet;
        wait (packets == 2);
        wait (busy == 1'b0);

        repeat (3) @(negedge clk);

        if (dut.fec.state !== 6'd0)
            $fatal(1, "FAIL: second packet did not terminate");

        if (done_count != 2)
            $fatal(
                1,
                "FAIL: expected 2 completion pulses, received %0d",
                done_count
            );

        if ((crc_count != 0) ||
            (scrambled_count != 0) ||
            (coded_count != 0))
            $fatal(1, "FAIL: unexpected trailing transfers");

        $display("");
        $display(
            "OVERALL PASS: integrated TX coding chain, restart and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule