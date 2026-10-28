`timescale 1ns / 1ps

module tlast_generator #(
    parameter PACKET_LENGTH = 8192 // Reduced to 8 to quickly observe the rollover
)(
    input clk,
    input resetn,

    input [15:0] iq_ch0_i,
    input [15:0] iq_ch0_q,
    input [15:0] iq_ch1_i,
    input [15:0] iq_ch1_q,
    input        rx_valid,

    output [63:0] m_axis_tdata,
    output        m_axis_tvalid,
    output        m_axis_tlast,
    input         m_axis_tready,

    // Moved from internal 'reg' to 'output reg' strictly for testbench observation
   output reg [31:0] sample_counter 
);

    assign m_axis_tdata = {iq_ch1_q, iq_ch1_i, iq_ch0_q, iq_ch0_i};
    assign m_axis_tvalid = rx_valid;
    
    // TLAST asserts when counter reaches (PACKET_LENGTH - 1)
    assign m_axis_tlast = (sample_counter == (PACKET_LENGTH - 1)) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (!resetn) begin
            sample_counter <= 32'd0;
        end else begin
            // Counter only increments during a successful AXI handshake
            if (m_axis_tvalid && m_axis_tready) begin
                if (sample_counter == (PACKET_LENGTH - 1)) begin
                    sample_counter <= 32'd0; 
                end else begin
                    sample_counter <= sample_counter + 1;
                end
            end
        end
    end

endmodule