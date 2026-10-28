`timescale 1ns / 1ps

module tb_tx_qpsk;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;
    reg start  = 1'b0;

    wire busy;
    wire packet_done;
    wire overflow_error;

    wire [31:0] iq_data;
    wire        iq_valid;
    wire        iq_last;
    reg         iq_ready = 1'b0;

    wire signed [15:0] output_i;
    wire signed [15:0] output_q;

    assign output_i = iq_data[15:0];
    assign output_q = iq_data[31:16];

    tx_qpsk_top #(
        .PAYLOAD_BYTES  (16),
        .MAX_CODED_PAIRS(2048),
        .AMPLITUDE     (8192)
    ) dut (
        .clk            (clk),
        .resetn         (resetn),
        .start          (start),

        .busy           (busy),
        .packet_done    (packet_done),
        .overflow_error (overflow_error),

        .m_axis_tdata   (iq_data),
        .m_axis_tvalid  (iq_valid),
        .m_axis_tlast   (iq_last),
        .m_axis_tready  (iq_ready)
    );

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

    integer packets     = 0;
    integer symbol_count = 0;
    integer done_count  = 0;
    integer ready_cycle = 0;

    wire [63:0] expected_header;
    wire [491:0] expected_frame;

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

    reg [1:0] expected_symbol;
    reg [1:0] recovered_symbol;

    reg signed [15:0] expected_i;
    reg signed [15:0] expected_q;

    reg [491:0] reconstructed_frame = 492'd0;

    reg        was_stalled = 1'b0;
    reg [33:0] held_output;

    // Force a three-cycle stall on each frame's final symbol.
    integer final_stall_cycles = 0;

    // --------------------------------------------------------
    // Downstream ready generation
    // --------------------------------------------------------
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle        = 0;
            final_stall_cycles = 0;
            iq_ready           = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;

            if ((symbol_count == 245) &&
                (final_stall_cycles < 3)) begin

                iq_ready = 1'b0;
                final_stall_cycles = final_stall_cycles + 1;
            end
            else begin
                iq_ready = ((ready_cycle % 7) >= 3);
            end

            if (symbol_count != 245)
                final_stall_cycles = 0;
        end
    end

    // --------------------------------------------------------
    // Monitor the final I/Q output
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin

            if (overflow_error)
                $fatal(1, "FAIL: unexpected buffer overflow");

            if (was_stalled &&
                ({iq_valid, iq_last, iq_data} !== held_output))
                $fatal(1, "FAIL: I/Q output changed during stall");

            was_stalled = iq_valid && !iq_ready;
            held_output = {iq_valid, iq_last, iq_data};

            if (packet_done)
                done_count = done_count + 1;

            // The wrapper must remain busy while an output
            // symbol is pending, including a stalled last symbol.
            if (iq_valid && !busy)
                $fatal(1, "FAIL: output pending while busy is low");

            if (iq_valid && iq_ready) begin
                if (packets >= 2)
                    $fatal(1, "FAIL: unexpected extra frame");

                if (symbol_count >= 246)
                    $fatal(1, "FAIL: unexpected extra symbol");

                expected_symbol =
                    expected_frame >>
                    (2 * (245 - symbol_count));

                // Independent explicit constellation table.
                case (expected_symbol)
                    2'b00: begin
                        expected_i =  16'sd8192;
                        expected_q =  16'sd8192;
                    end

                    2'b01: begin
                        expected_i =  16'sd8192;
                        expected_q = -16'sd8192;
                    end

                    2'b11: begin
                        expected_i = -16'sd8192;
                        expected_q = -16'sd8192;
                    end

                    2'b10: begin
                        expected_i = -16'sd8192;
                        expected_q =  16'sd8192;
                    end
                endcase

                if ((output_i !== expected_i) ||
                    (output_q !== expected_q))
                    $fatal(
                        1,
                        "FAIL: frame=%0d symbol=%0d expected I=%0d Q=%0d actual I=%0d Q=%0d",
                        packets + 1,
                        symbol_count,
                        expected_i,
                        expected_q,
                        output_i,
                        output_q
                    );

                if (iq_last !== (symbol_count == 245))
                    $fatal(
                        1,
                        "FAIL: TLAST at symbol %0d",
                        symbol_count
                    );

                // Mapping uses negative I for symbol bit 1,
                // and negative Q for symbol bit 0.
                recovered_symbol = {
                    output_i[15],
                    output_q[15]
                };

                reconstructed_frame = {
                    reconstructed_frame[489:0],
                    recovered_symbol
                };

                $display(
                    "FRAME=%0d INDEX=%0d SYMBOL=%02b I=%0d Q=%0d PACKED=%08h LAST=%b PASS",
                    packets + 1,
                    symbol_count,
                    expected_symbol,
                    output_i,
                    output_q,
                    iq_data,
                    iq_last
                );

                symbol_count = symbol_count + 1;

                if (symbol_count == 246) begin

                    if (reconstructed_frame !== expected_frame)
                        $fatal(
                            1,
                            "FAIL: reconstructed frame mismatch"
                        );

                    $display("");
                    $display("========================================");
                    $display("FRAME %0d COMPLETE", packets + 1);

                    $display(
                        "RECOVERED PREAMBLE: %016h",
                        reconstructed_frame[491:428]
                    );

                    $display(
                        "RECOVERED SYNC    : %08h",
                        reconstructed_frame[427:396]
                    );

                    $display(
                        "RECOVERED HEADER  : %016h",
                        reconstructed_frame[395:332]
                    );

                    $display(
                        "RECOVERED BODY    : %083h",
                        reconstructed_frame[331:0]
                    );

                    $display(
                        "PASS: all 246 I/Q symbols and final TLAST"
                    );

                    $display("========================================");

                    symbol_count        = 0;
                    reconstructed_frame = 492'd0;
                    packets             = packets + 1;
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

        launch_packet;
        wait (packets == 2);
        wait (busy == 1'b0);

        repeat (4) @(negedge clk);

        if (done_count != 2)
            $fatal(
                1,
                "FAIL: expected 2 completion pulses, received %0d",
                done_count
            );

        if (symbol_count != 0)
            $fatal(1, "FAIL: unexpected trailing symbols");

        $display("");
        $display(
            "OVERALL PASS: complete TX-to-QPSK chain, frame contents, completion and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule