`timescale 1ns / 1ps

module qpsk_mapper #(
    // Positive integer, range 1 through 32767.
    parameter integer AMPLITUDE = 8192
)(
    input wire clk,
    input wire resetn,

    input  wire [1:0] s_axis_tdata,
    input  wire       s_axis_tvalid,
    input  wire       s_axis_tlast,
    output wire       s_axis_tready,

    // Packed as {Q, I}; each component is signed 16-bit.
    output reg  [31:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output reg         m_axis_tlast,
    input  wire        m_axis_tready
);

    localparam signed [15:0] POS_A = AMPLITUDE;
    localparam signed [15:0] NEG_A = -AMPLITUDE;

    reg out_valid;

    wire slot_free;

    wire signed [15:0] mapped_i;
    wire signed [15:0] mapped_q;

    assign mapped_i = s_axis_tdata[1] ? NEG_A : POS_A;
    assign mapped_q = s_axis_tdata[0] ? NEG_A : POS_A;

    assign slot_free =
        !out_valid || m_axis_tready;

    assign s_axis_tready =
        resetn && slot_free;

    assign m_axis_tvalid =
        resetn && out_valid;

    always @(posedge clk) begin
        if (!resetn) begin
            out_valid    <= 1'b0;
            m_axis_tdata <= 32'd0;
            m_axis_tlast <= 1'b0;
        end
        else if (slot_free) begin
            out_valid    <= s_axis_tvalid;
            m_axis_tlast <= 1'b0;

            if (s_axis_tvalid) begin
                m_axis_tdata <= {mapped_q, mapped_i};
                m_axis_tlast <= s_axis_tlast;
            end
        end
    end

endmodule