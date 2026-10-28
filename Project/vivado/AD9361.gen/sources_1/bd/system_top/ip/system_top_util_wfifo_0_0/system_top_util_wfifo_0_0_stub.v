// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:45:58 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_util_wfifo_0_0/system_top_util_wfifo_0_0_stub.v
// Design      : system_top_util_wfifo_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "util_wfifo,Vivado 2022.2" *)
module system_top_util_wfifo_0_0(din_rst, din_clk, din_enable_0, din_valid_0, 
  din_data_0, din_enable_1, din_valid_1, din_data_1, din_enable_2, din_valid_2, din_data_2, 
  din_enable_3, din_valid_3, din_data_3, din_ovf, dout_rstn, dout_clk, dout_enable_0, 
  dout_valid_0, dout_data_0, dout_enable_1, dout_valid_1, dout_data_1, dout_enable_2, 
  dout_valid_2, dout_data_2, dout_enable_3, dout_valid_3, dout_data_3, dout_ovf)
/* synthesis syn_black_box black_box_pad_pin="din_rst,din_clk,din_enable_0,din_valid_0,din_data_0[15:0],din_enable_1,din_valid_1,din_data_1[15:0],din_enable_2,din_valid_2,din_data_2[15:0],din_enable_3,din_valid_3,din_data_3[15:0],din_ovf,dout_rstn,dout_clk,dout_enable_0,dout_valid_0,dout_data_0[15:0],dout_enable_1,dout_valid_1,dout_data_1[15:0],dout_enable_2,dout_valid_2,dout_data_2[15:0],dout_enable_3,dout_valid_3,dout_data_3[15:0],dout_ovf" */;
  input din_rst;
  input din_clk;
  input din_enable_0;
  input din_valid_0;
  input [15:0]din_data_0;
  input din_enable_1;
  input din_valid_1;
  input [15:0]din_data_1;
  input din_enable_2;
  input din_valid_2;
  input [15:0]din_data_2;
  input din_enable_3;
  input din_valid_3;
  input [15:0]din_data_3;
  output din_ovf;
  input dout_rstn;
  input dout_clk;
  output dout_enable_0;
  output dout_valid_0;
  output [15:0]dout_data_0;
  output dout_enable_1;
  output dout_valid_1;
  output [15:0]dout_data_1;
  output dout_enable_2;
  output dout_valid_2;
  output [15:0]dout_data_2;
  output dout_enable_3;
  output dout_valid_3;
  output [15:0]dout_data_3;
  input dout_ovf;
endmodule
