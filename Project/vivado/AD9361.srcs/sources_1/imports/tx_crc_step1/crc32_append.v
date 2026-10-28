`timescale 1ns/1ps
// CRC-32/ISO-HDLC: reflected polynomial EDB88320, init FFFFFFFF,
// xorout FFFFFFFF. Input byte bits processed LSB first.
// For ASCII "123456789": CRC CBF43926; appended bytes 26 39 F4 CB.
// Input TLAST marks final payload byte; output TLAST marks fourth CRC byte.
// Nonempty packets only. One-entry registered output, stable under stalls.
module crc32_append(
 input wire clk, input wire resetn,
 input wire [7:0] s_axis_tdata, input wire s_axis_tvalid,
 input wire s_axis_tlast, output wire s_axis_tready,
 output reg [7:0] m_axis_tdata, output wire m_axis_tvalid,
 output reg m_axis_tlast, input wire m_axis_tready,
 output reg packet_done
);
 reg out_valid;
 reg emitting_crc;
 reg [1:0] crc_index;
 reg [31:0] crc_state, crc_shift;
 wire slot_free = !out_valid || m_axis_tready;
 assign m_axis_tvalid=out_valid && resetn;
 assign s_axis_tready=resetn && !emitting_crc && slot_free;
 function [31:0] update_crc;
  input [31:0] state;
  input [7:0] data;
  reg [31:0] c;
  integer b;
  begin
   c=state ^ {24'd0,data};
   for(b=0;b<8;b=b+1)
    if(c[0]) c=(c>>1)^32'hEDB88320;
    else c=c>>1;
   update_crc=c;
  end
 endfunction
 always @(posedge clk) begin
  if(!resetn) begin
   out_valid<=0; m_axis_tdata<=0; m_axis_tlast<=0;
   emitting_crc<=0; crc_index<=0; crc_state<=32'hFFFFFFFF;
   crc_shift<=0; packet_done<=0;
  end else begin
   packet_done<=out_valid && m_axis_tready && m_axis_tlast;
   if(slot_free) begin
    out_valid<=0; m_axis_tlast<=0;
    if(emitting_crc) begin
     out_valid<=1; m_axis_tdata<=crc_shift[7:0];
     m_axis_tlast<=(crc_index==3);
     crc_shift<=crc_shift>>8;
     if(crc_index==3) begin emitting_crc<=0; crc_index<=0; end
     else crc_index<=crc_index+1;
    end else if(s_axis_tvalid) begin
     out_valid<=1; m_axis_tdata<=s_axis_tdata;
     if(s_axis_tlast) begin
      crc_shift<=~update_crc(crc_state,s_axis_tdata);
      crc_state<=32'hFFFFFFFF; emitting_crc<=1; crc_index<=0;
     end else crc_state<=update_crc(crc_state,s_axis_tdata);
    end
   end
  end
 end
endmodule
