//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Wed Oct 28 11:31:56 2026
//Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target system_top_wrapper.bd
//Design      : system_top_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module system_top_wrapper
   (DDR_0_addr,
    DDR_0_ba,
    DDR_0_cas_n,
    DDR_0_ck_n,
    DDR_0_ck_p,
    DDR_0_cke,
    DDR_0_cs_n,
    DDR_0_dm,
    DDR_0_dq,
    DDR_0_dqs_n,
    DDR_0_dqs_p,
    DDR_0_odt,
    DDR_0_ras_n,
    DDR_0_reset_n,
    DDR_0_we_n,
    FIXED_IO_0_ddr_vrn,
    FIXED_IO_0_ddr_vrp,
    FIXED_IO_0_mio,
    FIXED_IO_0_ps_clk,
    FIXED_IO_0_ps_porb,
    FIXED_IO_0_ps_srstb,
    SPI0_MISO_I_0,
    SPI0_MOSI_O_0,
    SPI0_SCLK_O_0,
    SPI0_SS_O_0,
    enable_0,
    gpio_clksel_0,
    gpio_ctl_0,
    gpio_en_agc_0,
    gpio_resetb_0,
    gpio_status_0,
    gpio_sync_0,
    rx_clk_in_n_0,
    rx_clk_in_p_0,
    rx_data_in_n_0,
    rx_data_in_p_0,
    rx_frame_in_n_0,
    rx_frame_in_p_0,
    tx_clk_out_n_0,
    tx_clk_out_p_0,
    tx_data_out_n_0,
    tx_data_out_p_0,
    tx_frame_out_n_0,
    tx_frame_out_p_0,
    txnrx_0);
  inout [14:0]DDR_0_addr;
  inout [2:0]DDR_0_ba;
  inout DDR_0_cas_n;
  inout DDR_0_ck_n;
  inout DDR_0_ck_p;
  inout DDR_0_cke;
  inout DDR_0_cs_n;
  inout [3:0]DDR_0_dm;
  inout [31:0]DDR_0_dq;
  inout [3:0]DDR_0_dqs_n;
  inout [3:0]DDR_0_dqs_p;
  inout DDR_0_odt;
  inout DDR_0_ras_n;
  inout DDR_0_reset_n;
  inout DDR_0_we_n;
  inout FIXED_IO_0_ddr_vrn;
  inout FIXED_IO_0_ddr_vrp;
  inout [53:0]FIXED_IO_0_mio;
  inout FIXED_IO_0_ps_clk;
  inout FIXED_IO_0_ps_porb;
  inout FIXED_IO_0_ps_srstb;
  input SPI0_MISO_I_0;
  output SPI0_MOSI_O_0;
  output SPI0_SCLK_O_0;
  output SPI0_SS_O_0;
  output enable_0;
  output gpio_clksel_0;
  output [3:0]gpio_ctl_0;
  output gpio_en_agc_0;
  output gpio_resetb_0;
  input [7:0]gpio_status_0;
  output gpio_sync_0;
  input rx_clk_in_n_0;
  input rx_clk_in_p_0;
  input [5:0]rx_data_in_n_0;
  input [5:0]rx_data_in_p_0;
  input rx_frame_in_n_0;
  input rx_frame_in_p_0;
  output tx_clk_out_n_0;
  output tx_clk_out_p_0;
  output [5:0]tx_data_out_n_0;
  output [5:0]tx_data_out_p_0;
  output tx_frame_out_n_0;
  output tx_frame_out_p_0;
  output txnrx_0;

  wire [14:0]DDR_0_addr;
  wire [2:0]DDR_0_ba;
  wire DDR_0_cas_n;
  wire DDR_0_ck_n;
  wire DDR_0_ck_p;
  wire DDR_0_cke;
  wire DDR_0_cs_n;
  wire [3:0]DDR_0_dm;
  wire [31:0]DDR_0_dq;
  wire [3:0]DDR_0_dqs_n;
  wire [3:0]DDR_0_dqs_p;
  wire DDR_0_odt;
  wire DDR_0_ras_n;
  wire DDR_0_reset_n;
  wire DDR_0_we_n;
  wire FIXED_IO_0_ddr_vrn;
  wire FIXED_IO_0_ddr_vrp;
  wire [53:0]FIXED_IO_0_mio;
  wire FIXED_IO_0_ps_clk;
  wire FIXED_IO_0_ps_porb;
  wire FIXED_IO_0_ps_srstb;
  wire SPI0_MISO_I_0;
  wire SPI0_MOSI_O_0;
  wire SPI0_SCLK_O_0;
  wire SPI0_SS_O_0;
  wire enable_0;
  wire gpio_clksel_0;
  wire [3:0]gpio_ctl_0;
  wire gpio_en_agc_0;
  wire gpio_resetb_0;
  wire [7:0]gpio_status_0;
  wire gpio_sync_0;
  wire rx_clk_in_n_0;
  wire rx_clk_in_p_0;
  wire [5:0]rx_data_in_n_0;
  wire [5:0]rx_data_in_p_0;
  wire rx_frame_in_n_0;
  wire rx_frame_in_p_0;
  wire tx_clk_out_n_0;
  wire tx_clk_out_p_0;
  wire [5:0]tx_data_out_n_0;
  wire [5:0]tx_data_out_p_0;
  wire tx_frame_out_n_0;
  wire tx_frame_out_p_0;
  wire txnrx_0;

  system_top system_top_i
       (.DDR_0_addr(DDR_0_addr),
        .DDR_0_ba(DDR_0_ba),
        .DDR_0_cas_n(DDR_0_cas_n),
        .DDR_0_ck_n(DDR_0_ck_n),
        .DDR_0_ck_p(DDR_0_ck_p),
        .DDR_0_cke(DDR_0_cke),
        .DDR_0_cs_n(DDR_0_cs_n),
        .DDR_0_dm(DDR_0_dm),
        .DDR_0_dq(DDR_0_dq),
        .DDR_0_dqs_n(DDR_0_dqs_n),
        .DDR_0_dqs_p(DDR_0_dqs_p),
        .DDR_0_odt(DDR_0_odt),
        .DDR_0_ras_n(DDR_0_ras_n),
        .DDR_0_reset_n(DDR_0_reset_n),
        .DDR_0_we_n(DDR_0_we_n),
        .FIXED_IO_0_ddr_vrn(FIXED_IO_0_ddr_vrn),
        .FIXED_IO_0_ddr_vrp(FIXED_IO_0_ddr_vrp),
        .FIXED_IO_0_mio(FIXED_IO_0_mio),
        .FIXED_IO_0_ps_clk(FIXED_IO_0_ps_clk),
        .FIXED_IO_0_ps_porb(FIXED_IO_0_ps_porb),
        .FIXED_IO_0_ps_srstb(FIXED_IO_0_ps_srstb),
        .SPI0_MISO_I_0(SPI0_MISO_I_0),
        .SPI0_MOSI_O_0(SPI0_MOSI_O_0),
        .SPI0_SCLK_O_0(SPI0_SCLK_O_0),
        .SPI0_SS_O_0(SPI0_SS_O_0),
        .enable_0(enable_0),
        .gpio_clksel_0(gpio_clksel_0),
        .gpio_ctl_0(gpio_ctl_0),
        .gpio_en_agc_0(gpio_en_agc_0),
        .gpio_resetb_0(gpio_resetb_0),
        .gpio_status_0(gpio_status_0),
        .gpio_sync_0(gpio_sync_0),
        .rx_clk_in_n_0(rx_clk_in_n_0),
        .rx_clk_in_p_0(rx_clk_in_p_0),
        .rx_data_in_n_0(rx_data_in_n_0),
        .rx_data_in_p_0(rx_data_in_p_0),
        .rx_frame_in_n_0(rx_frame_in_n_0),
        .rx_frame_in_p_0(rx_frame_in_p_0),
        .tx_clk_out_n_0(tx_clk_out_n_0),
        .tx_clk_out_p_0(tx_clk_out_p_0),
        .tx_data_out_n_0(tx_data_out_n_0),
        .tx_data_out_p_0(tx_data_out_p_0),
        .tx_frame_out_n_0(tx_frame_out_n_0),
        .tx_frame_out_p_0(tx_frame_out_p_0),
        .txnrx_0(txnrx_0));
endmodule
