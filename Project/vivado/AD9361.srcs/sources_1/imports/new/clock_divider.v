`timescale 1ns / 1ps

module clock_divider (
    input wire clk_in,
    input wire d_r1,
    input wire a_r1,
    output reg clk_out
);

    reg [1:0] counter = 0;
    wire and_condition;

    // The internal logical AND evaluation
    assign and_condition = d_r1 & a_r1;

    // Initialize registers for FPGA power-up state
    initial begin
        clk_out = 0;
        counter = 0;
    end

    always @(posedge clk_in) begin
        if (and_condition == 1'b1) begin
            // DIVIDE BY 2: Toggle the output on every single clk_in cycle
            clk_out <= ~clk_out;
            counter <= 0; // Keep counter zeroed safely during div-by-2 mode
        end else begin
            // DIVIDE BY 4: Toggle the output every two clk_in cycles
            if (counter >= 2'd1) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule