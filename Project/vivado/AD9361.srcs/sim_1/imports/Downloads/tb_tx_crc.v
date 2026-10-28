//`timescale 1ns/1ps
//module tb_tx_crc;
// reg clk=0; always #5 clk=~clk;
// reg resetn=0;
// reg [7:0] din=0;
// reg vin=0,lin=0,ready=0;
// wire rin,valid,last,done;
// wire [7:0] data;
// // Set to 1 for a line at every accepted input/output transfer.
// parameter PRINT_EACH_TRANSFER=0;
// integer cycle=0,n=0,p=0,i;
// integer in_n=0,in_packets=0,k;
// integer top_in_n=0,top_in_packets=0;
// reg [7:0] captured_in[0:17];
// reg [7:0] captured_out[0:25];
// reg [7:0] captured_top_in[0:31];
// reg [7:0] captured_top_out[0:39];
// reg top_stalled=0;
// reg [7:0] top_held;
// reg top_held_last;
// reg stalled=0;
// reg [7:0] held;
// reg held_last;
// reg [7:0] expected[0:12];
// crc32_append dut(.clk(clk),.resetn(resetn),.s_axis_tdata(din),
// .s_axis_tvalid(vin),.s_axis_tlast(lin),.s_axis_tready(rin),
// .m_axis_tdata(data),.m_axis_tvalid(valid),.m_axis_tlast(last),
// .m_axis_tready(ready),.packet_done(done));
// // Independent integration check for counter payload 00..0F.
// reg start=0;
// wire busy,top_done,tv,tl;
// wire [7:0] td;
// integer tn=0,tp=0;
// reg [7:0] te[0:19];
// tx_payload_crc_top top(.clk(clk),.resetn(resetn),.start(start),
// .busy(busy),.packet_done(top_done),.m_axis_tdata(td),
// .m_axis_tvalid(tv),.m_axis_tlast(tl),.m_axis_tready(ready));
// always @(negedge clk) begin
//  cycle=cycle+1;
//  ready=((cycle%7)!=0 && (cycle%7)!=1 && (cycle%7)!=2);
// end
// // Only accepted transfers are recorded: VALID && READY at rising edge.
// always @(posedge clk) if(resetn) begin
//  if(vin && rin) begin
//   if(in_packets>=2 || in_n>=9) $fatal(1,"FAIL: extra DUT input");
//   if(din !== expected[in_n]) $fatal(1,"FAIL: unexpected DUT payload byte");
//   captured_in[in_packets*9+in_n]=din;
//   if(PRINT_EACH_TRANSFER)
//    $display("[%0t] DUT BEFORE byte=%0d data=%02h valid=%b ready=%b last=%b",$time,in_n,din,vin,rin,lin);
//   if(lin !== (in_n==8)) $fatal(1,"FAIL: input TLAST");
//   if(lin) begin in_packets=in_packets+1;in_n=0;end
//   else in_n=in_n+1;
//  end
//  if(top.valid && top.ready) begin
//   if(top_in_packets>=2 || top_in_n>=16) $fatal(1,"FAIL: extra wrapper input");
//   if(top.data !== te[top_in_n]) $fatal(1,"FAIL: unexpected counter payload byte");
//   captured_top_in[top_in_packets*16+top_in_n]=top.data;
//   if(PRINT_EACH_TRANSFER)
//    $display("[%0t] TOP BEFORE byte=%0d data=%02h last=%b",$time,top_in_n,top.data,top.last);
//   if(top.last !== (top_in_n==15)) $fatal(1,"FAIL: wrapper input TLAST");
//   if(top.last) begin top_in_packets=top_in_packets+1;top_in_n=0;end
//   else top_in_n=top_in_n+1;
//  end
//  if(top_stalled && (!tv || td!==top_held || tl!==top_held_last))
//   $fatal(1,"FAIL: wrapper output changed while stalled");
//  top_stalled=tv && !ready;top_held=td;top_held_last=tl;
//  if(stalled && (!valid || data!==held || last!==held_last))
//   $fatal(1,"FAIL: CRC output changed while stalled");
//  stalled=valid && !ready; held=data; held_last=last;
//  if(valid && ready) begin
//   if(p>=2) $fatal(1,"FAIL: extra DUT output");
//   captured_out[p*13+n]=data;
//   if(PRINT_EACH_TRANSFER)
//    $display("[%0t] DUT AFTER byte=%0d data=%02h valid=%b ready=%b last=%b",$time,n,data,valid,ready,last);
//   if(data!==expected[n] || last!==(n==12))
//    $fatal(1,"FAIL: DUT packet %0d byte %0d expected=%02h actual=%02h expected_last=%b actual_last=%b",p+1,n,expected[n],data,(n==12),last);
//   if(n==12) begin
//    if(in_packets<p+1) $fatal(1,"FAIL: incomplete input packet");
//    $display("\nDUT packet %0d: ASCII 123456789",p+1);
//    $write("  BEFORE CRC : ");
//    for(k=0;k<9;k=k+1) $write("%02h ",captured_in[p*9+k]);
//    $write("\n  AFTER CRC  : ");
//    for(k=0;k<13;k=k+1) $write("%02h ",captured_out[p*13+k]);
//    $display("\n  Appended CRC bytes: %02h %02h %02h %02h",captured_out[p*13+9],captured_out[p*13+10],captured_out[p*13+11],captured_out[p*13+12]);
//    $display("  Expected CRC value: CBF43926 (LSB byte first)");
//    $display("  PASS: payload preserved, CRC matched, TLAST correct");
//    n=0;p=p+1;
//   end else n=n+1;
//  end
//  if(tv && ready) begin
//   if(tp>=2) $fatal(1,"FAIL: extra wrapper output");
//   captured_top_out[tp*20+tn]=td;
//   if(PRINT_EACH_TRANSFER)
//    $display("[%0t] TOP AFTER byte=%0d data=%02h last=%b",$time,tn,td,tl);
//   if(td!==te[tn] || tl!==(tn==19))
//    $fatal(1,"FAIL: TOP packet %0d byte %0d expected=%02h actual=%02h expected_last=%b actual_last=%b",tp+1,tn,te[tn],td,(tn==19),tl);
//   if(tn==19) begin
//    if(top_in_packets<tp+1) $fatal(1,"FAIL: incomplete wrapper input");
//    $display("\nTOP packet %0d: counter payload",tp+1);
//    $write("  BEFORE CRC : ");
//    for(k=0;k<16;k=k+1) $write("%02h ",captured_top_in[tp*16+k]);
//    $write("\n  AFTER CRC  : ");
//    for(k=0;k<20;k=k+1) $write("%02h ",captured_top_out[tp*20+k]);
//    $display("\n  Expected CRC value: CECEE288 (wire bytes 88 E2 CE CE)");
//    $display("  PASS: payload preserved, CRC matched, TLAST correct");
//    tn=0;tp=tp+1;
//   end else tn=tn+1;
//  end
// end
// task send_check_packet;
//  integer j;
//  begin
//   for(j=0;j<9;j=j+1) begin
//    @(negedge clk); din=8'h31+j;vin=1;lin=(j==8);
//    @(posedge clk); while(!rin) @(posedge clk);
//   end
//   @(negedge clk);vin=0;lin=0;
//  end
// endtask
// initial begin
//  for(i=0;i<9;i=i+1) expected[i]=8'h31+i;
//  expected[9]=8'h26;expected[10]=8'h39;expected[11]=8'hF4;expected[12]=8'hCB;
//  for(i=0;i<16;i=i+1) te[i]=i;
//  te[16]=8'h88;te[17]=8'hE2;te[18]=8'hCE;te[19]=8'hCE;
//  repeat(4) @(negedge clk); resetn=1;
//  @(negedge clk);start=1;
//  @(negedge clk);start=0;
//  send_check_packet;
//  send_check_packet;
//  wait(p==2 && tp==1 && !busy);
//  @(negedge clk);start=1;
//  @(negedge clk);start=0;
//  wait(tp==2 && !busy);
//  $display("\nOVERALL PASS: 4 packets; known CRC, repeated packets, counter payload, backpressure");
//  $finish;
// end
// initial begin #100000; $fatal(1,"FAIL: simulation timeout"); end
//endmodule
