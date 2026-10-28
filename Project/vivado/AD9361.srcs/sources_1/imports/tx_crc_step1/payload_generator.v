`timescale 1ns/1ps
// Test payload: bytes 00,01,... modulo 256. Positive PAYLOAD_BYTES only.
// Pulse start for one clk when busy=0. Synchronous active-low reset.
module payload_generator #(parameter integer PAYLOAD_BYTES=16)(
 input wire clk, input wire resetn, input wire start,
 output wire busy, output reg done,
 output wire [7:0] m_axis_tdata, output wire m_axis_tvalid,
 output wire m_axis_tlast, input wire m_axis_tready
);
 reg active;
 reg [31:0] index;
 assign busy=active;
 assign m_axis_tvalid=active && resetn;
 assign m_axis_tdata=index[7:0];
 assign m_axis_tlast=active && (index==PAYLOAD_BYTES-1);
 always @(posedge clk) begin
  if(!resetn) begin active<=0; index<=0; done<=0; end
  else begin
   done<=0;
   if(!active) begin
    if(start) begin active<=1; index<=0; end
   end else if(m_axis_tready) begin
    if(index==PAYLOAD_BYTES-1) begin active<=0; done<=1; end
    else index<=index+1;
   end
  end
 end
endmodule
