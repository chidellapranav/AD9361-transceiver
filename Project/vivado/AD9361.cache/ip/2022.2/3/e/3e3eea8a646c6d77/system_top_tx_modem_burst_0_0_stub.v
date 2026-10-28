// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:46:34 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_tx_modem_burst_0_0_stub.v
// Design      : system_top_tx_modem_burst_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "tx_modem_burst,Vivado 2022.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(clk, resetn, enable, tx_i, tx_q, tx_valid, 
  burst_active, burst_last, error)
/* synthesis syn_black_box black_box_pad_pin="clk,resetn,enable,tx_i[15:0],tx_q[15:0],tx_valid,burst_active,burst_last,error" */;
  input clk;
  input resetn;
  input enable;
  output [15:0]tx_i;
  output [15:0]tx_q;
  output tx_valid;
  output burst_active;
  output burst_last;
  output error;
endmodule
