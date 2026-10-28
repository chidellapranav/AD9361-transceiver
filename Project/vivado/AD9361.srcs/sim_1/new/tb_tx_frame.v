`timescale 1ns / 1ps

module tb_tx_frame;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg start  = 1'b0;

    wire coding_busy;
    wire coding_done;

    wire [1:0] coded_data;
    wire       coded_valid;
    wire       coded_last;
    wire       coded_ready;

    wire [1:0] frame_data;
    wire       frame_valid;
    wire       frame_last;
    reg        frame_ready = 1'b0;

    wire frame_busy;
    wire frame_done;
    wire overflow_error;

    tx_coded_top #(
        .PAYLOAD_BYTES(16)
    ) coding (
        .clk            (clk),
        .resetn         (resetn),
        .start          (start),

        .busy           (coding_busy),
        .packet_done    (coding_done),

        .m_axis_tdata   (coded_data),
        .m_axis_tvalid  (coded_valid),
        .m_axis_tlast   (coded_last),
        .m_axis_tready  (coded_ready)
    );

    frame_assembler #(
        .MAX_CODED_PAIRS(2048)
    ) framing (
        .clk                  (clk),
        .resetn               (resetn),

        .payload_length_bytes (16'd16),

        .s_axis_tdata         (coded_data),
        .s_axis_tvalid        (coded_valid),
        .s_axis_tlast         (coded_last),
        .s_axis_tready        (coded_ready),

        .m_axis_tdata         (frame_data),
        .m_axis_tvalid        (frame_valid),
        .m_axis_tlast         (frame_last),
        .m_axis_tready        (frame_ready),

        .busy                 (frame_busy),
        .packet_done          (frame_done),
        .overflow_error       (overflow_error)
    );

    // 32 preamble symbols = 64 bits.
    localparam [63:0] EXPECTED_PREAMBLE =
        64'h1E1E1E1E1E1E1E1E;

    localparam [31:0] EXPECTED_SYNC =
        32'h1ACFFC1D;

    localparam [63:0] EXPECTED_HEADER_0 =
        64'h1100001000A6C77B;

    localparam [63:0] EXPECTED_HEADER_1 =
        64'h1101001000A66D2A;

    localparam [331:0] EXPECTED_BODY =
        332'hD94C76B7F6A583058F0ADDFE169A38B8DBECADD1FC09040E990E808C106AD2AF668D912E89BE944DFAB;

    // Total: 64 + 32 + 64 + 332 = 492 bits.
    // 492 bits / 2 = 246 symbols.
    wire [63:0] expected_header;
    wire [491:0] expected_frame;

    integer packets = 0;

    assign expected_header =
        (packets == 0)
        ? EXPECTED_HEADER_0
        : EXPECTED_HEADER_1;

    assign expected_frame = {
        EXPECTED_PREAMBLE,
        EXPECTED_SYNC,
        expected_header,
        EXPECTED_BODY
    };

    reg [491:0] actual_frame = 492'd0;
    reg [1:0] expected_pair;

    reg [1:0] captured_symbols [0:245];

    integer symbol_count = 0;
    integer input_count  = 0;
    integer done_count   = 0;
    integer ready_cycle  = 0;
    integer j;

    reg       was_stalled = 1'b0;
    reg [3:0] held_output;

    // Apply downstream backpressure.
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle = 0;
            frame_ready = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;
            frame_ready = ((ready_cycle % 7) >= 3);
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin

            if (overflow_error)
                $fatal(1, "FAIL: unexpected packet-buffer overflow");

            // Stable output through stalls and release edge.
            if (was_stalled &&
                ({frame_valid, frame_last, frame_data}
                    !== held_output))
                $fatal(1, "FAIL: frame output changed during stall");

            was_stalled = frame_valid && !frame_ready;

            held_output =
                {frame_valid, frame_last, frame_data};

            if (frame_done)
                done_count = done_count + 1;

            // Count coded pairs accepted by the assembler.
            if (coded_valid && coded_ready) begin
                if (input_count >= 166)
                    $fatal(1, "FAIL: extra coded input pair");

                if (coded_last !== (input_count == 165))
                    $fatal(1, "FAIL: coded input TLAST");

                input_count = input_count + 1;
            end

            // Check every accepted frame symbol.
            if (frame_valid && frame_ready) begin

                if (packets >= 2)
                    $fatal(1, "FAIL: unexpected extra frame");

                if (symbol_count >= 246)
                    $fatal(1, "FAIL: extra frame symbol");

                // No frame output may start before full capture.
                if (input_count != 166)
                    $fatal(1, "FAIL: frame started before packet buffered");

                expected_pair =
                    expected_frame >> (2 * (245 - symbol_count));

                if (frame_data !== expected_pair)
                    $fatal(
                        1,
                        "FAIL: frame %0d symbol %0d expected=%02b actual=%02b",
                        packets + 1,
                        symbol_count,
                        expected_pair,
                        frame_data
                    );

                if (frame_last !== (symbol_count == 245))
                    $fatal(
                        1,
                        "FAIL: frame TLAST at symbol %0d",
                        symbol_count
                    );

                captured_symbols[symbol_count] = frame_data;

                actual_frame = {
                    actual_frame[489:0],
                    frame_data
                };

                symbol_count = symbol_count + 1;

                if (symbol_count == 246) begin
                    if (actual_frame !== expected_frame)
                        $fatal(1, "FAIL: full frame mismatch");

                    $display("");
                    $display("========================================");
                    $display("FRAME %0d", packets + 1);

                    $display(
                        "PREAMBLE : %016h",
                        actual_frame[491:428]
                    );

                    $display(
                        "SYNC WORD: %08h",
                        actual_frame[427:396]
                    );

                    $display(
                        "HEADER   : %016h",
                        actual_frame[395:332]
                    );

                    $display(
                        "CODED BODY: %083h",
                        actual_frame[331:0]
                    );

                    $display("ALL FRAME SYMBOLS:");

                    for (j = 0; j < 246; j = j + 1) begin
                        $write("%02b ", captured_symbols[j]);

                        if ((j % 16) == 15)
                            $write("\n");
                    end

                    $display("");
                    $display(
                        "PASS: 32 preamble + 16 sync + 32 header + 166 body"
                    );

                    $display(
                        "PASS: all 246 symbols and final TLAST match"
                    );

                    $display("========================================");

                    symbol_count = 0;
                    input_count  = 0;
                    actual_frame = 492'd0;

                    packets = packets + 1;
                end
            end
        end
    end

    task launch_packet;
        begin
            wait (!coding_busy && !frame_busy);

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

        // Includes a second frame without resetting:
        // header sequence changes from 00 to 01.
        launch_packet;
        wait (packets == 2);

        repeat (4) @(negedge clk);

        if (done_count != 2)
            $fatal(
                1,
                "FAIL: expected 2 frame completions, received %0d",
                done_count
            );

        if (coding_busy || frame_busy)
            $fatal(1, "FAIL: chain remained busy");

        if ((input_count != 0) || (symbol_count != 0))
            $fatal(1, "FAIL: unexpected trailing transfers");

        $display("");
        $display(
            "OVERALL PASS: framing, header CRC, sequence, buffering and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule