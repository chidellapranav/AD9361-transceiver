`timescale 1ns / 1ps

module tb_qpsk_mapper;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;

    reg  [1:0] symbol_data  = 2'b00;
    reg        symbol_valid = 1'b0;
    reg        symbol_last  = 1'b0;
    wire       symbol_ready;

    wire [31:0] iq_data;
    wire        iq_valid;
    wire        iq_last;
    reg         iq_ready = 1'b0;

    wire signed [15:0] output_i;
    wire signed [15:0] output_q;

    assign output_i = iq_data[15:0];
    assign output_q = iq_data[31:16];

    qpsk_mapper #(
        .AMPLITUDE(8192)
    ) dut (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (symbol_data),
        .s_axis_tvalid  (symbol_valid),
        .s_axis_tlast   (symbol_last),
        .s_axis_tready  (symbol_ready),

        .m_axis_tdata   (iq_data),
        .m_axis_tvalid  (iq_valid),
        .m_axis_tlast   (iq_last),
        .m_axis_tready  (iq_ready)
    );

    reg [1:0] symbols [0:3];

    reg signed [15:0] expected_i [0:3];
    reg signed [15:0] expected_q [0:3];

    integer output_count = 0;
    integer packets = 0;
    integer ready_cycle = 0;

    reg was_stalled = 1'b0;
    reg [33:0] held_output;

    // Apply downstream backpressure.
    always @(negedge clk) begin
        if (!resetn) begin
            ready_cycle = 0;
            iq_ready = 1'b0;
        end
        else begin
            ready_cycle = ready_cycle + 1;
            iq_ready = ((ready_cycle % 7) >= 3);
        end
    end

    always @(posedge clk) begin
        if (!resetn) begin
            was_stalled = 1'b0;
        end
        else begin

            if (was_stalled &&
                ({iq_valid, iq_last, iq_data} !== held_output))
                $fatal(
                    1,
                    "FAIL: mapper output changed during stall"
                );

            was_stalled = iq_valid && !iq_ready;
            held_output = {iq_valid, iq_last, iq_data};

            if (iq_valid && iq_ready) begin

                if (packets >= 2)
                    $fatal(1, "FAIL: unexpected extra output");

                if ((output_i !== expected_i[output_count]) ||
                    (output_q !== expected_q[output_count]))
                    $fatal(
                        1,
                        "FAIL: symbol=%02b expected I=%0d Q=%0d, actual I=%0d Q=%0d",
                        symbols[output_count],
                        expected_i[output_count],
                        expected_q[output_count],
                        output_i,
                        output_q
                    );

                if (iq_last !== (output_count == 3))
                    $fatal(1, "FAIL: incorrect TLAST");

                $display(
                    "PACKET %0d | SYMBOL=%02b | I=%0d Q=%0d | PACKED=%08h | LAST=%b | PASS",
                    packets + 1,
                    symbols[output_count],
                    output_i,
                    output_q,
                    iq_data,
                    iq_last
                );

                if (output_count == 3) begin
                    output_count = 0;
                    packets = packets + 1;
                end
                else begin
                    output_count = output_count + 1;
                end
            end
        end
    end

    task send_packet;
        integer k;
        begin
            for (k = 0; k < 4; k = k + 1) begin
                @(negedge clk);

                symbol_data  = symbols[k];
                symbol_valid = 1'b1;
                symbol_last  = (k == 3);

                @(posedge clk);
                while (!symbol_ready)
                    @(posedge clk);
            end

            @(negedge clk);
            symbol_valid = 1'b0;
            symbol_last  = 1'b0;
        end
    endtask

    initial begin
        symbols[0] = 2'b00;
        symbols[1] = 2'b01;
        symbols[2] = 2'b11;
        symbols[3] = 2'b10;

        expected_i[0] =  16'sd8192;
        expected_q[0] =  16'sd8192;

        expected_i[1] =  16'sd8192;
        expected_q[1] = -16'sd8192;

        expected_i[2] = -16'sd8192;
        expected_q[2] = -16'sd8192;

        expected_i[3] = -16'sd8192;
        expected_q[3] =  16'sd8192;

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        send_packet;
        wait (packets == 1);

        send_packet;
        wait (packets == 2);

        repeat (4) @(negedge clk);

        $display("");
        $display(
            "OVERALL PASS: QPSK constellation, packing, TLAST and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule