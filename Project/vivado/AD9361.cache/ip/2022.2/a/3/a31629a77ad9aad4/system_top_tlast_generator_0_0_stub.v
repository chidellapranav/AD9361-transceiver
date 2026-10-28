// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:46:04 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_tlast_generator_0_0_stub.v
// Design      : system_top_tlast_generator_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "tlast_generator,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, resetn, iq_ch0_i, iq_ch0_q, iq_ch1_i, 
  iq_ch1_q, rx_valid, m_axis_tdata, m_axis_tvalid, m_axis_tlast, m_axis_tready, sample_counter)
/* synthesis syn_black_box black_box_pad_pin="clk,resetn,iq_ch0_i[15:0],iq_ch0_q[15:0],iq_ch1_i[15:0],iq_ch1_q[15:0],rx_valid,m_axis_tdata[63:0],m_axis_tvalid,m_axis_tlast,m_axis_tready,sample_counter[31:0]" */;
  input clk;
  input resetn;
  input [15:0]iq_ch0_i;
  input [15:0]iq_ch0_q;
  input [15:0]iq_ch1_i;
  input [15:0]iq_ch1_q;
  input rx_valid;
  output [63:0]m_axis_tdata;
  output m_axis_tvalid;
  output m_axis_tlast;
  input m_axis_tready;
  output [31:0]sample_counter;
endmodule
