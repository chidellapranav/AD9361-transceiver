// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:19 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_ad9361_io_manager_0_0/system_top_ad9361_io_manager_0_0_stub.v
// Design      : system_top_ad9361_io_manager_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ad9361_io_manager,Vivado 2022.2" *)
module system_top_ad9361_io_manager_0_0(ps_gpio_o, ps_gpio_i, ps_gpio_t, gpio_resetb, 
  gpio_sync, gpio_en_agc, gpio_ctl, gpio_status, gpio_clksel, up_enable, up_txnrx)
/* synthesis syn_black_box black_box_pad_pin="ps_gpio_o[63:0],ps_gpio_i[63:0],ps_gpio_t[63:0],gpio_resetb,gpio_sync,gpio_en_agc,gpio_ctl[3:0],gpio_status[7:0],gpio_clksel,up_enable,up_txnrx" */;
  input [63:0]ps_gpio_o;
  output [63:0]ps_gpio_i;
  input [63:0]ps_gpio_t;
  output gpio_resetb;
  output gpio_sync;
  output gpio_en_agc;
  output [3:0]gpio_ctl;
  input [7:0]gpio_status;
  output gpio_clksel;
  output up_enable;
  output up_txnrx;
endmodule
