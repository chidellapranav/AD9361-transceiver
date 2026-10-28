// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:19 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_c_counter_binary_0_0/system_top_c_counter_binary_0_0_stub.v
// Design      : system_top_c_counter_binary_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_counter_binary_v12_0_15,Vivado 2022.2" *)
module system_top_c_counter_binary_0_0(CLK, Q)
/* synthesis syn_black_box black_box_pad_pin="CLK,Q[15:0]" */;
  input CLK;
  output [15:0]Q;
endmodule
