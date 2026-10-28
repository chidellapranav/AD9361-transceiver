`timescale 1ns / 1ps

module tb_rrc_interpolator;

    reg clk = 1'b0;
    always #5 clk = ~clk;

    reg resetn = 1'b0;

    reg [31:0] input_data = 32'hE0002000;
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

    // Fixed expected samples calculated in Python.
    // Each entry is packed {Q, I}.
    reg [31:0] reference [0:32];

    integer sample_count = 0;
    integer packets      = 0;
    integer done_count   = 0;
    integer ready_cycle  = 0;

    reg was_stalled = 1'b0;
    reg [33:0] held_output;

    // Deliberate multi-cycle downstream stalls.
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
                $fatal(1, "FAIL: output pending while busy is low");

            if (output_valid && output_ready) begin

                if (packets >= 2)
                    $fatal(1, "FAIL: unexpected extra packet");

                if (sample_count >= 33)
                    $fatal(1, "FAIL: extra impulse-response sample");

                if (output_data !== reference[sample_count])
                    $fatal(
                        1,
                        "FAIL: sample=%0d expected=%08h actual=%08h",
                        sample_count,
                        reference[sample_count],
                        output_data
                    );

                if (output_last !== (sample_count == 32))
                    $fatal(
                        1,
                        "FAIL: TLAST incorrect at sample %0d",
                        sample_count
                    );

                $display(
                    "PACKET=%0d SAMPLE=%0d I=%0d Q=%0d PACKED=%08h LAST=%b PASS",
                    packets + 1,
                    sample_count,
                    output_i,
                    output_q,
                    output_data,
                    output_last
                );

                sample_count = sample_count + 1;

                if (sample_count == 33) begin
                    $display(
                        "PASS: packet %0d, all 33 impulse samples",
                        packets + 1
                    );

                    sample_count = 0;
                    packets = packets + 1;
                end
            end
        end
    end

    task send_impulse;
        begin
            wait (!busy);

            @(negedge clk);
            input_data  = 32'hE0002000;
            input_valid = 1'b1;
            input_last  = 1'b1;

            @(posedge clk);
            while (!input_ready)
                @(posedge clk);

            @(negedge clk);
            input_valid = 1'b0;
            input_last  = 1'b0;
        end
    endtask

    initial begin
        reference[ 0] = 32'hFFF00011;
        reference[ 1] = 32'hFF94006D;
        reference[ 2] = 32'hFFB2004E;
        reference[ 3] = 32'h004EFFB3;
        reference[ 4] = 32'h00CFFF31;
        reference[ 5] = 32'h0079FF88;
        reference[ 6] = 32'hFF3000D1;
        reference[ 7] = 32'hFDEC0214;
        reference[ 8] = 32'hFE2F01D1;
        reference[ 9] = 32'h00B4FF4D;
        reference[10] = 32'h044DFBB4;
        reference[11] = 32'h0600FA00;
        reference[12] = 32'h02B2FD4F;
        reference[13] = 32'hF96C0695;
        reference[14] = 32'hECAC1355;
        reference[15] = 32'hE18F1E71;
        reference[16] = 32'hDD2822D8;
        reference[17] = 32'hE18F1E71;
        reference[18] = 32'hECAC1355;
        reference[19] = 32'hF96C0695;
        reference[20] = 32'h02B2FD4F;
        reference[21] = 32'h0600FA00;
        reference[22] = 32'h044DFBB4;
        reference[23] = 32'h00B4FF4D;
        reference[24] = 32'hFE2F01D1;
        reference[25] = 32'hFDEC0214;
        reference[26] = 32'hFF3000D1;
        reference[27] = 32'h0079FF88;
        reference[28] = 32'h00CFFF31;
        reference[29] = 32'h004EFFB3;
        reference[30] = 32'hFFB2004E;
        reference[31] = 32'hFF94006D;
        reference[32] = 32'hFFF00011;

        repeat (4) @(negedge clk);
        resetn = 1'b1;

        send_impulse;
        wait (packets == 1);

        send_impulse;
        wait (packets == 2);

        repeat (4) @(negedge clk);

        if (done_count != 2)
            $fatal(
                1,
                "FAIL: expected 2 completion pulses, received %0d",
                done_count
            );

        if (busy)
            $fatal(1, "FAIL: filter remained busy");

        if (sample_count != 0)
            $fatal(1, "FAIL: unexpected trailing samples");

        $display("");
        $display(
            "OVERALL PASS: RRC impulse response, tail, restart and backpressure"
        );

        $finish;
    end

    initial begin
        #100000;
        $fatal(1, "FAIL: simulation timeout");
    end

endmodule