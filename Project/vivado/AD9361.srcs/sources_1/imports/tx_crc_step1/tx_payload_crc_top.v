`timescale 1ns/1ps
module tx_payload_crc_top #(parameter integer PAYLOAD_BYTES=16)(
 input wire clk, input wire resetn, input wire start,
 output wire busy, output wire packet_done,
 output wire [7:0] m_axis_tdata, output wire m_axis_tvalid,
 output wire m_axis_tlast, input wire m_axis_tready
);
 reg active;
 wire [7:0] data;
 wire valid,last,ready,source_busy,source_done;
 wire accept_start=start && !active;
 assign busy=active;
 always @(posedge clk) begin
  if(!resetn) active<=0;
  else if(accept_start) active<=1;
  else if(packet_done) active<=0;
 end
 payload_generator #(.PAYLOAD_BYTES(PAYLOAD_BYTES)) source(
 .clk(clk),.resetn(resetn),.start(accept_start),.busy(source_busy),.done(source_done),
 .m_axis_tdata(data),.m_axis_tvalid(valid),.m_axis_tlast(last),.m_axis_tready(ready));
 crc32_append crc(.clk(clk),.resetn(resetn),
 .s_axis_tdata(data),.s_axis_tvalid(valid),.s_axis_tlast(last),.s_axis_tready(ready),
 .m_axis_tdata(m_axis_tdata),.m_axis_tvalid(m_axis_tvalid),
 .m_axis_tlast(m_axis_tlast),.m_axis_tready(m_axis_tready),.packet_done(packet_done));
endmodule
