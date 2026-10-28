// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:47 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_cordic_0_0_stub.v
// Design      : system_top_cordic_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "cordic_v6_0_18,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(aclk, s_axis_phase_tvalid, 
  s_axis_phase_tdata, s_axis_cartesian_tvalid, s_axis_cartesian_tdata, 
  m_axis_dout_tvalid, m_axis_dout_tdata)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_phase_tvalid,s_axis_phase_tdata[15:0],s_axis_cartesian_tvalid,s_axis_cartesian_tdata[31:0],m_axis_dout_tvalid,m_axis_dout_tdata[31:0]" */;
  input aclk;
  input s_axis_phase_tvalid;
  input [15:0]s_axis_phase_tdata;
  input s_axis_cartesian_tvalid;
  input [31:0]s_axis_cartesian_tdata;
  output m_axis_dout_tvalid;
  output [31:0]m_axis_dout_tdata;
endmodule
