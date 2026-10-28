`timescale 1ns / 1ps

module phasecounter (
    input  wire               clk,
    output reg  signed [15:0] Q = 16'sd0
);

    // Hardcode your frequency step here
    localparam signed [15:0] INCREMENT = 16'sd128;

    // PI and 2*PI constants in 2Q13 Radians format for the continuous wrap
    localparam signed [15:0] PI_VAL     = 16'sd25736;
    localparam signed [15:0] NEG_PI_VAL = -16'sd25736;
    localparam signed [16:0] TWO_PI_VAL = 17'sd51472; 

    reg signed [16:0] next_phase;

    always @(*) begin
        // Calculate the next phase using 17 bits to prevent overflow
        next_phase = Q + INCREMENT;
    end

    always @(posedge clk) begin
        if (next_phase >= PI_VAL) begin
            // Wrap smoothly by subtracting a full 2*PI circle
            Q <= next_phase - TWO_PI_VAL;
        end else if (next_phase < NEG_PI_VAL) begin
            // Wrap smoothly by adding a full 2*PI circle
            Q <= next_phase + TWO_PI_VAL;
        end else begin
            // Stay within the continuous circle
            Q <= next_phase[15:0];
        end
    end

endmodule