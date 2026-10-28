//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
//Date        : Wed Oct 28 11:31:56 2026
//Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
//Command     : generate_target system_top.bd
//Design      : system_top
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module IP_AnalogDevices_imp_18BZYJW
   (adc_r1_mode,
    clk,
    dac_r1_mode,
    delay_clk,
    din_data_0,
    din_data_1,
    din_data_2,
    din_data_3,
    din_valid_in_1,
    din_valid_in_3,
    dout_clk,
    dout_data_0,
    dout_data_1,
    dout_data_2,
    dout_data_3,
    dout_data_4,
    dout_data_5,
    dout_rstn,
    dout_valid_0,
    enable_0,
    rx_clk_in_n_0,
    rx_clk_in_p_0,
    rx_data_in_n_0,
    rx_data_in_p_0,
    rx_frame_in_n_0,
    rx_frame_in_p_0,
    s_axi_aclk,
    s_axi_araddr,
    s_axi_aresetn,
    s_axi_arprot,
    s_axi_arready,
    s_axi_arvalid,
    s_axi_awaddr,
    s_axi_awprot,
    s_axi_awready,
    s_axi_awvalid,
    s_axi_bready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_rdata,
    s_axi_rready,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_wdata,
    s_axi_wready,
    s_axi_wstrb,
    s_axi_wvalid,
    tx_clk_out_n_0,
    tx_clk_out_p_0,
    tx_data_out_n_0,
    tx_data_out_p_0,
    tx_frame_out_n_0,
    tx_frame_out_p_0,
    txnrx_0,
    up_enable,
    up_txnrx);
  output adc_r1_mode;
  output clk;
  output dac_r1_mode;
  input delay_clk;
  input [15:0]din_data_0;
  input [15:0]din_data_1;
  input [15:0]din_data_2;
  input [15:0]din_data_3;
  input din_valid_in_1;
  input din_valid_in_3;
  input dout_clk;
  output [15:0]dout_data_0;
  output [15:0]dout_data_1;
  output [15:0]dout_data_2;
  output [15:0]dout_data_3;
  output [15:0]dout_data_4;
  output [15:0]dout_data_5;
  input dout_rstn;
  output dout_valid_0;
  output enable_0;
  input rx_clk_in_n_0;
  input rx_clk_in_p_0;
  input [5:0]rx_data_in_n_0;
  input [5:0]rx_data_in_p_0;
  input rx_frame_in_n_0;
  input rx_frame_in_p_0;
  input s_axi_aclk;
  input [15:0]s_axi_araddr;
  input s_axi_aresetn;
  input [2:0]s_axi_arprot;
  output s_axi_arready;
  input s_axi_arvalid;
  input [15:0]s_axi_awaddr;
  input [2:0]s_axi_awprot;
  output s_axi_awready;
  input s_axi_awvalid;
  input s_axi_bready;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  output [31:0]s_axi_rdata;
  input s_axi_rready;
  output [1:0]s_axi_rresp;
  output s_axi_rvalid;
  input [31:0]s_axi_wdata;
  output s_axi_wready;
  input [3:0]s_axi_wstrb;
  input s_axi_wvalid;
  output tx_clk_out_n_0;
  output tx_clk_out_p_0;
  output [5:0]tx_data_out_n_0;
  output [5:0]tx_data_out_p_0;
  output tx_frame_out_n_0;
  output tx_frame_out_p_0;
  output txnrx_0;
  input up_enable;
  input up_txnrx;

  wire Net;
  wire ad9361_io_manager_0_up_enable;
  wire ad9361_io_manager_0_up_txnrx;
  wire [15:0]axi_ad9361_0_adc_data_i0;
  wire [15:0]axi_ad9361_0_adc_data_i1;
  wire [15:0]axi_ad9361_0_adc_data_q0;
  wire [15:0]axi_ad9361_0_adc_data_q1;
  wire axi_ad9361_0_adc_enable_i0;
  wire axi_ad9361_0_adc_enable_i1;
  wire axi_ad9361_0_adc_enable_q0;
  wire axi_ad9361_0_adc_enable_q1;
  wire axi_ad9361_0_adc_r1_mode;
  wire axi_ad9361_0_adc_valid_i0;
  wire axi_ad9361_0_adc_valid_i1;
  wire axi_ad9361_0_adc_valid_q0;
  wire axi_ad9361_0_adc_valid_q1;
  wire axi_ad9361_0_dac_enable_i0;
  wire axi_ad9361_0_dac_enable_i1;
  wire axi_ad9361_0_dac_enable_q0;
  wire axi_ad9361_0_dac_enable_q1;
  wire axi_ad9361_0_dac_r1_mode;
  wire axi_ad9361_0_dac_valid_i0;
  wire axi_ad9361_0_dac_valid_i1;
  wire axi_ad9361_0_dac_valid_q0;
  wire axi_ad9361_0_dac_valid_q1;
  wire axi_ad9361_0_enable;
  wire axi_ad9361_0_l_clk;
  wire axi_ad9361_0_rst;
  wire axi_ad9361_0_tx_clk_out_n;
  wire axi_ad9361_0_tx_clk_out_p;
  wire [5:0]axi_ad9361_0_tx_data_out_n;
  wire [5:0]axi_ad9361_0_tx_data_out_p;
  wire axi_ad9361_0_tx_frame_out_n;
  wire axi_ad9361_0_tx_frame_out_p;
  wire axi_ad9361_0_txnrx;
  wire [15:0]axi_smc_M01_AXI_ARADDR;
  wire [2:0]axi_smc_M01_AXI_ARPROT;
  wire axi_smc_M01_AXI_ARREADY;
  wire axi_smc_M01_AXI_ARVALID;
  wire [15:0]axi_smc_M01_AXI_AWADDR;
  wire [2:0]axi_smc_M01_AXI_AWPROT;
  wire axi_smc_M01_AXI_AWREADY;
  wire axi_smc_M01_AXI_AWVALID;
  wire axi_smc_M01_AXI_BREADY;
  wire [1:0]axi_smc_M01_AXI_BRESP;
  wire axi_smc_M01_AXI_BVALID;
  wire [31:0]axi_smc_M01_AXI_RDATA;
  wire axi_smc_M01_AXI_RREADY;
  wire [1:0]axi_smc_M01_AXI_RRESP;
  wire axi_smc_M01_AXI_RVALID;
  wire [31:0]axi_smc_M01_AXI_WDATA;
  wire axi_smc_M01_AXI_WREADY;
  wire [3:0]axi_smc_M01_AXI_WSTRB;
  wire axi_smc_M01_AXI_WVALID;
  wire cordic_0_m_axis_dout_tvalid;
  wire cordic_1_m_axis_dout_tvalid;
  wire microblaze_0_Clk;
  wire proc_sys_reset_0_peripheral_aresetn;
  wire ps_7_FCLK_CLK1;
  wire rst_ps_7_50M_peripheral_aresetn;
  wire rx_clk_in_n_0_1;
  wire rx_clk_in_p_0_1;
  wire [5:0]rx_data_in_n_0_1;
  wire [5:0]rx_data_in_p_0_1;
  wire rx_frame_in_n_0_1;
  wire rx_frame_in_p_0_1;
  wire [15:0]util_rfifo_0_dout_data_0;
  wire [15:0]util_rfifo_0_dout_data_1;
  wire [15:0]util_rfifo_0_dout_data_2;
  wire [15:0]util_rfifo_0_dout_data_3;
  wire util_rfifo_0_dout_unf;
  wire [15:0]util_wfifo_0_dout_data_0;
  wire [15:0]util_wfifo_0_dout_data_1;
  wire [15:0]util_wfifo_0_dout_data_2;
  wire [15:0]util_wfifo_0_dout_data_3;
  wire util_wfifo_0_dout_valid_0;
  wire [15:0]xlslice_0_Dout;
  wire [15:0]xlslice_1_Dout;
  wire [15:0]xlslice_2_Dout;
  wire [15:0]xlslice_3_Dout;

  assign Net = dout_clk;
  assign ad9361_io_manager_0_up_enable = up_enable;
  assign ad9361_io_manager_0_up_txnrx = up_txnrx;
  assign adc_r1_mode = axi_ad9361_0_adc_r1_mode;
  assign axi_smc_M01_AXI_ARADDR = s_axi_araddr[15:0];
  assign axi_smc_M01_AXI_ARPROT = s_axi_arprot[2:0];
  assign axi_smc_M01_AXI_ARVALID = s_axi_arvalid;
  assign axi_smc_M01_AXI_AWADDR = s_axi_awaddr[15:0];
  assign axi_smc_M01_AXI_AWPROT = s_axi_awprot[2:0];
  assign axi_smc_M01_AXI_AWVALID = s_axi_awvalid;
  assign axi_smc_M01_AXI_BREADY = s_axi_bready;
  assign axi_smc_M01_AXI_RREADY = s_axi_rready;
  assign axi_smc_M01_AXI_WDATA = s_axi_wdata[31:0];
  assign axi_smc_M01_AXI_WSTRB = s_axi_wstrb[3:0];
  assign axi_smc_M01_AXI_WVALID = s_axi_wvalid;
  assign clk = axi_ad9361_0_l_clk;
  assign cordic_0_m_axis_dout_tvalid = din_valid_in_1;
  assign cordic_1_m_axis_dout_tvalid = din_valid_in_3;
  assign dac_r1_mode = axi_ad9361_0_dac_r1_mode;
  assign dout_data_0[15:0] = util_wfifo_0_dout_data_0;
  assign dout_data_1[15:0] = util_wfifo_0_dout_data_1;
  assign dout_data_2[15:0] = util_wfifo_0_dout_data_2;
  assign dout_data_3[15:0] = util_wfifo_0_dout_data_3;
  assign dout_data_4[15:0] = util_rfifo_0_dout_data_0;
  assign dout_data_5[15:0] = util_rfifo_0_dout_data_1;
  assign dout_valid_0 = util_wfifo_0_dout_valid_0;
  assign enable_0 = axi_ad9361_0_enable;
  assign microblaze_0_Clk = s_axi_aclk;
  assign proc_sys_reset_0_peripheral_aresetn = dout_rstn;
  assign ps_7_FCLK_CLK1 = delay_clk;
  assign rst_ps_7_50M_peripheral_aresetn = s_axi_aresetn;
  assign rx_clk_in_n_0_1 = rx_clk_in_n_0;
  assign rx_clk_in_p_0_1 = rx_clk_in_p_0;
  assign rx_data_in_n_0_1 = rx_data_in_n_0[5:0];
  assign rx_data_in_p_0_1 = rx_data_in_p_0[5:0];
  assign rx_frame_in_n_0_1 = rx_frame_in_n_0;
  assign rx_frame_in_p_0_1 = rx_frame_in_p_0;
  assign s_axi_arready = axi_smc_M01_AXI_ARREADY;
  assign s_axi_awready = axi_smc_M01_AXI_AWREADY;
  assign s_axi_bresp[1:0] = axi_smc_M01_AXI_BRESP;
  assign s_axi_bvalid = axi_smc_M01_AXI_BVALID;
  assign s_axi_rdata[31:0] = axi_smc_M01_AXI_RDATA;
  assign s_axi_rresp[1:0] = axi_smc_M01_AXI_RRESP;
  assign s_axi_rvalid = axi_smc_M01_AXI_RVALID;
  assign s_axi_wready = axi_smc_M01_AXI_WREADY;
  assign tx_clk_out_n_0 = axi_ad9361_0_tx_clk_out_n;
  assign tx_clk_out_p_0 = axi_ad9361_0_tx_clk_out_p;
  assign tx_data_out_n_0[5:0] = axi_ad9361_0_tx_data_out_n;
  assign tx_data_out_p_0[5:0] = axi_ad9361_0_tx_data_out_p;
  assign tx_frame_out_n_0 = axi_ad9361_0_tx_frame_out_n;
  assign tx_frame_out_p_0 = axi_ad9361_0_tx_frame_out_p;
  assign txnrx_0 = axi_ad9361_0_txnrx;
  assign xlslice_0_Dout = din_data_0[15:0];
  assign xlslice_1_Dout = din_data_1[15:0];
  assign xlslice_2_Dout = din_data_3[15:0];
  assign xlslice_3_Dout = din_data_2[15:0];
  system_top_axi_ad9361_0_0 axi_ad9361_0
       (.adc_data_i0(axi_ad9361_0_adc_data_i0),
        .adc_data_i1(axi_ad9361_0_adc_data_i1),
        .adc_data_q0(axi_ad9361_0_adc_data_q0),
        .adc_data_q1(axi_ad9361_0_adc_data_q1),
        .adc_dovf(1'b0),
        .adc_enable_i0(axi_ad9361_0_adc_enable_i0),
        .adc_enable_i1(axi_ad9361_0_adc_enable_i1),
        .adc_enable_q0(axi_ad9361_0_adc_enable_q0),
        .adc_enable_q1(axi_ad9361_0_adc_enable_q1),
        .adc_r1_mode(axi_ad9361_0_adc_r1_mode),
        .adc_valid_i0(axi_ad9361_0_adc_valid_i0),
        .adc_valid_i1(axi_ad9361_0_adc_valid_i1),
        .adc_valid_q0(axi_ad9361_0_adc_valid_q0),
        .adc_valid_q1(axi_ad9361_0_adc_valid_q1),
        .clk(axi_ad9361_0_l_clk),
        .dac_data_i0(util_rfifo_0_dout_data_0),
        .dac_data_i1(util_rfifo_0_dout_data_2),
        .dac_data_q0(util_rfifo_0_dout_data_1),
        .dac_data_q1(util_rfifo_0_dout_data_3),
        .dac_dunf(util_rfifo_0_dout_unf),
        .dac_enable_i0(axi_ad9361_0_dac_enable_i0),
        .dac_enable_i1(axi_ad9361_0_dac_enable_i1),
        .dac_enable_q0(axi_ad9361_0_dac_enable_q0),
        .dac_enable_q1(axi_ad9361_0_dac_enable_q1),
        .dac_r1_mode(axi_ad9361_0_dac_r1_mode),
        .dac_sync_in(1'b0),
        .dac_valid_i0(axi_ad9361_0_dac_valid_i0),
        .dac_valid_i1(axi_ad9361_0_dac_valid_i1),
        .dac_valid_q0(axi_ad9361_0_dac_valid_q0),
        .dac_valid_q1(axi_ad9361_0_dac_valid_q1),
        .delay_clk(ps_7_FCLK_CLK1),
        .enable(axi_ad9361_0_enable),
        .gps_pps(1'b0),
        .l_clk(axi_ad9361_0_l_clk),
        .rst(axi_ad9361_0_rst),
        .rx_clk_in_n(rx_clk_in_n_0_1),
        .rx_clk_in_p(rx_clk_in_p_0_1),
        .rx_data_in_n(rx_data_in_n_0_1),
        .rx_data_in_p(rx_data_in_p_0_1),
        .rx_frame_in_n(rx_frame_in_n_0_1),
        .rx_frame_in_p(rx_frame_in_p_0_1),
        .s_axi_aclk(microblaze_0_Clk),
        .s_axi_araddr(axi_smc_M01_AXI_ARADDR),
        .s_axi_aresetn(rst_ps_7_50M_peripheral_aresetn),
        .s_axi_arprot(axi_smc_M01_AXI_ARPROT),
        .s_axi_arready(axi_smc_M01_AXI_ARREADY),
        .s_axi_arvalid(axi_smc_M01_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M01_AXI_AWADDR),
        .s_axi_awprot(axi_smc_M01_AXI_AWPROT),
        .s_axi_awready(axi_smc_M01_AXI_AWREADY),
        .s_axi_awvalid(axi_smc_M01_AXI_AWVALID),
        .s_axi_bready(axi_smc_M01_AXI_BREADY),
        .s_axi_bresp(axi_smc_M01_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M01_AXI_BVALID),
        .s_axi_rdata(axi_smc_M01_AXI_RDATA),
        .s_axi_rready(axi_smc_M01_AXI_RREADY),
        .s_axi_rresp(axi_smc_M01_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M01_AXI_RVALID),
        .s_axi_wdata(axi_smc_M01_AXI_WDATA),
        .s_axi_wready(axi_smc_M01_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M01_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M01_AXI_WVALID),
        .tdd_sync(1'b0),
        .tx_clk_out_n(axi_ad9361_0_tx_clk_out_n),
        .tx_clk_out_p(axi_ad9361_0_tx_clk_out_p),
        .tx_data_out_n(axi_ad9361_0_tx_data_out_n),
        .tx_data_out_p(axi_ad9361_0_tx_data_out_p),
        .tx_frame_out_n(axi_ad9361_0_tx_frame_out_n),
        .tx_frame_out_p(axi_ad9361_0_tx_frame_out_p),
        .txnrx(axi_ad9361_0_txnrx),
        .up_adc_gpio_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .up_dac_gpio_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .up_enable(ad9361_io_manager_0_up_enable),
        .up_txnrx(ad9361_io_manager_0_up_txnrx));
  system_top_util_rfifo_0_0 util_rfifo_0
       (.din_clk(Net),
        .din_data_0(xlslice_0_Dout),
        .din_data_1(xlslice_1_Dout),
        .din_data_2(xlslice_3_Dout),
        .din_data_3(xlslice_2_Dout),
        .din_rstn(proc_sys_reset_0_peripheral_aresetn),
        .din_unf(1'b0),
        .din_valid_in_0(cordic_0_m_axis_dout_tvalid),
        .din_valid_in_1(cordic_0_m_axis_dout_tvalid),
        .din_valid_in_2(cordic_1_m_axis_dout_tvalid),
        .din_valid_in_3(cordic_1_m_axis_dout_tvalid),
        .dout_clk(axi_ad9361_0_l_clk),
        .dout_data_0(util_rfifo_0_dout_data_0),
        .dout_data_1(util_rfifo_0_dout_data_1),
        .dout_data_2(util_rfifo_0_dout_data_2),
        .dout_data_3(util_rfifo_0_dout_data_3),
        .dout_enable_0(axi_ad9361_0_dac_enable_i0),
        .dout_enable_1(axi_ad9361_0_dac_enable_q0),
        .dout_enable_2(axi_ad9361_0_dac_enable_i1),
        .dout_enable_3(axi_ad9361_0_dac_enable_q1),
        .dout_rst(axi_ad9361_0_rst),
        .dout_unf(util_rfifo_0_dout_unf),
        .dout_valid_0(axi_ad9361_0_dac_valid_i0),
        .dout_valid_1(axi_ad9361_0_dac_valid_q0),
        .dout_valid_2(axi_ad9361_0_dac_valid_i1),
        .dout_valid_3(axi_ad9361_0_dac_valid_q1));
  system_top_util_wfifo_0_0 util_wfifo_0
       (.din_clk(axi_ad9361_0_l_clk),
        .din_data_0(axi_ad9361_0_adc_data_i0),
        .din_data_1(axi_ad9361_0_adc_data_q0),
        .din_data_2(axi_ad9361_0_adc_data_i1),
        .din_data_3(axi_ad9361_0_adc_data_q1),
        .din_enable_0(axi_ad9361_0_adc_enable_i0),
        .din_enable_1(axi_ad9361_0_adc_enable_q0),
        .din_enable_2(axi_ad9361_0_adc_enable_i1),
        .din_enable_3(axi_ad9361_0_adc_enable_q1),
        .din_rst(axi_ad9361_0_rst),
        .din_valid_0(axi_ad9361_0_adc_valid_i0),
        .din_valid_1(axi_ad9361_0_adc_valid_q0),
        .din_valid_2(axi_ad9361_0_adc_valid_i1),
        .din_valid_3(axi_ad9361_0_adc_valid_q1),
        .dout_clk(Net),
        .dout_data_0(util_wfifo_0_dout_data_0),
        .dout_data_1(util_wfifo_0_dout_data_1),
        .dout_data_2(util_wfifo_0_dout_data_2),
        .dout_data_3(util_wfifo_0_dout_data_3),
        .dout_ovf(1'b0),
        .dout_rstn(proc_sys_reset_0_peripheral_aresetn),
        .dout_valid_0(util_wfifo_0_dout_valid_0));
endmodule

module IP_PS_imp_CQ0787
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
    FCLK_CLK0,
    FCLK_CLK1,
    FCLK_RESET0_N,
    FIXED_IO_0_ddr_vrn,
    FIXED_IO_0_ddr_vrp,
    FIXED_IO_0_mio,
    FIXED_IO_0_ps_clk,
    FIXED_IO_0_ps_porb,
    FIXED_IO_0_ps_srstb,
    GPIO_0_tri_i,
    GPIO_0_tri_o,
    GPIO_0_tri_t,
    In0,
    M_AXI_GP0_araddr,
    M_AXI_GP0_arburst,
    M_AXI_GP0_arcache,
    M_AXI_GP0_arid,
    M_AXI_GP0_arlen,
    M_AXI_GP0_arlock,
    M_AXI_GP0_arprot,
    M_AXI_GP0_arqos,
    M_AXI_GP0_arready,
    M_AXI_GP0_arsize,
    M_AXI_GP0_arvalid,
    M_AXI_GP0_awaddr,
    M_AXI_GP0_awburst,
    M_AXI_GP0_awcache,
    M_AXI_GP0_awid,
    M_AXI_GP0_awlen,
    M_AXI_GP0_awlock,
    M_AXI_GP0_awprot,
    M_AXI_GP0_awqos,
    M_AXI_GP0_awready,
    M_AXI_GP0_awsize,
    M_AXI_GP0_awvalid,
    M_AXI_GP0_bid,
    M_AXI_GP0_bready,
    M_AXI_GP0_bresp,
    M_AXI_GP0_bvalid,
    M_AXI_GP0_rdata,
    M_AXI_GP0_rid,
    M_AXI_GP0_rlast,
    M_AXI_GP0_rready,
    M_AXI_GP0_rresp,
    M_AXI_GP0_rvalid,
    M_AXI_GP0_wdata,
    M_AXI_GP0_wid,
    M_AXI_GP0_wlast,
    M_AXI_GP0_wready,
    M_AXI_GP0_wstrb,
    M_AXI_GP0_wvalid,
    SPI0_MISO_I_0,
    SPI0_MOSI_O_0,
    SPI0_SCLK_O_0,
    SPI0_SS_O_0,
    S_AXI_HP0_ACLK,
    S_AXI_HP0_awaddr,
    S_AXI_HP0_awburst,
    S_AXI_HP0_awcache,
    S_AXI_HP0_awlen,
    S_AXI_HP0_awlock,
    S_AXI_HP0_awprot,
    S_AXI_HP0_awqos,
    S_AXI_HP0_awready,
    S_AXI_HP0_awsize,
    S_AXI_HP0_awvalid,
    S_AXI_HP0_bready,
    S_AXI_HP0_bresp,
    S_AXI_HP0_bvalid,
    S_AXI_HP0_wdata,
    S_AXI_HP0_wlast,
    S_AXI_HP0_wready,
    S_AXI_HP0_wstrb,
    S_AXI_HP0_wvalid);
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
  output FCLK_CLK0;
  output FCLK_CLK1;
  output FCLK_RESET0_N;
  inout FIXED_IO_0_ddr_vrn;
  inout FIXED_IO_0_ddr_vrp;
  inout [53:0]FIXED_IO_0_mio;
  inout FIXED_IO_0_ps_clk;
  inout FIXED_IO_0_ps_porb;
  inout FIXED_IO_0_ps_srstb;
  input [63:0]GPIO_0_tri_i;
  output [63:0]GPIO_0_tri_o;
  output [63:0]GPIO_0_tri_t;
  input [0:0]In0;
  output [31:0]M_AXI_GP0_araddr;
  output [1:0]M_AXI_GP0_arburst;
  output [3:0]M_AXI_GP0_arcache;
  output [11:0]M_AXI_GP0_arid;
  output [3:0]M_AXI_GP0_arlen;
  output [1:0]M_AXI_GP0_arlock;
  output [2:0]M_AXI_GP0_arprot;
  output [3:0]M_AXI_GP0_arqos;
  input M_AXI_GP0_arready;
  output [2:0]M_AXI_GP0_arsize;
  output M_AXI_GP0_arvalid;
  output [31:0]M_AXI_GP0_awaddr;
  output [1:0]M_AXI_GP0_awburst;
  output [3:0]M_AXI_GP0_awcache;
  output [11:0]M_AXI_GP0_awid;
  output [3:0]M_AXI_GP0_awlen;
  output [1:0]M_AXI_GP0_awlock;
  output [2:0]M_AXI_GP0_awprot;
  output [3:0]M_AXI_GP0_awqos;
  input M_AXI_GP0_awready;
  output [2:0]M_AXI_GP0_awsize;
  output M_AXI_GP0_awvalid;
  input [11:0]M_AXI_GP0_bid;
  output M_AXI_GP0_bready;
  input [1:0]M_AXI_GP0_bresp;
  input M_AXI_GP0_bvalid;
  input [31:0]M_AXI_GP0_rdata;
  input [11:0]M_AXI_GP0_rid;
  input M_AXI_GP0_rlast;
  output M_AXI_GP0_rready;
  input [1:0]M_AXI_GP0_rresp;
  input M_AXI_GP0_rvalid;
  output [31:0]M_AXI_GP0_wdata;
  output [11:0]M_AXI_GP0_wid;
  output M_AXI_GP0_wlast;
  input M_AXI_GP0_wready;
  output [3:0]M_AXI_GP0_wstrb;
  output M_AXI_GP0_wvalid;
  input SPI0_MISO_I_0;
  output SPI0_MOSI_O_0;
  output SPI0_SCLK_O_0;
  output SPI0_SS_O_0;
  input S_AXI_HP0_ACLK;
  input [31:0]S_AXI_HP0_awaddr;
  input [1:0]S_AXI_HP0_awburst;
  input [3:0]S_AXI_HP0_awcache;
  input [3:0]S_AXI_HP0_awlen;
  input [1:0]S_AXI_HP0_awlock;
  input [2:0]S_AXI_HP0_awprot;
  input [3:0]S_AXI_HP0_awqos;
  output S_AXI_HP0_awready;
  input [2:0]S_AXI_HP0_awsize;
  input S_AXI_HP0_awvalid;
  input S_AXI_HP0_bready;
  output [1:0]S_AXI_HP0_bresp;
  output S_AXI_HP0_bvalid;
  input [63:0]S_AXI_HP0_wdata;
  input S_AXI_HP0_wlast;
  output S_AXI_HP0_wready;
  input [7:0]S_AXI_HP0_wstrb;
  input S_AXI_HP0_wvalid;

  wire SPI0_MISO_I_0_1;
  wire [0:0]axi_dma_0_s2mm_introut;
  wire microblaze_0_Clk;
  wire [14:0]ps_7_DDR_ADDR;
  wire [2:0]ps_7_DDR_BA;
  wire ps_7_DDR_CAS_N;
  wire ps_7_DDR_CKE;
  wire ps_7_DDR_CK_N;
  wire ps_7_DDR_CK_P;
  wire ps_7_DDR_CS_N;
  wire [3:0]ps_7_DDR_DM;
  wire [31:0]ps_7_DDR_DQ;
  wire [3:0]ps_7_DDR_DQS_N;
  wire [3:0]ps_7_DDR_DQS_P;
  wire ps_7_DDR_ODT;
  wire ps_7_DDR_RAS_N;
  wire ps_7_DDR_RESET_N;
  wire ps_7_DDR_WE_N;
  wire ps_7_FCLK_CLK1;
  wire ps_7_FCLK_RESET0_N;
  wire ps_7_FIXED_IO_DDR_VRN;
  wire ps_7_FIXED_IO_DDR_VRP;
  wire [53:0]ps_7_FIXED_IO_MIO;
  wire ps_7_FIXED_IO_PS_CLK;
  wire ps_7_FIXED_IO_PS_PORB;
  wire ps_7_FIXED_IO_PS_SRSTB;
  wire [63:0]ps_7_GPIO_0_TRI_I;
  wire [63:0]ps_7_GPIO_0_TRI_O;
  wire [63:0]ps_7_GPIO_0_TRI_T;
  wire [31:0]ps_7_M_AXI_GP0_ARADDR;
  wire [1:0]ps_7_M_AXI_GP0_ARBURST;
  wire [3:0]ps_7_M_AXI_GP0_ARCACHE;
  wire [11:0]ps_7_M_AXI_GP0_ARID;
  wire [3:0]ps_7_M_AXI_GP0_ARLEN;
  wire [1:0]ps_7_M_AXI_GP0_ARLOCK;
  wire [2:0]ps_7_M_AXI_GP0_ARPROT;
  wire [3:0]ps_7_M_AXI_GP0_ARQOS;
  wire ps_7_M_AXI_GP0_ARREADY;
  wire [2:0]ps_7_M_AXI_GP0_ARSIZE;
  wire ps_7_M_AXI_GP0_ARVALID;
  wire [31:0]ps_7_M_AXI_GP0_AWADDR;
  wire [1:0]ps_7_M_AXI_GP0_AWBURST;
  wire [3:0]ps_7_M_AXI_GP0_AWCACHE;
  wire [11:0]ps_7_M_AXI_GP0_AWID;
  wire [3:0]ps_7_M_AXI_GP0_AWLEN;
  wire [1:0]ps_7_M_AXI_GP0_AWLOCK;
  wire [2:0]ps_7_M_AXI_GP0_AWPROT;
  wire [3:0]ps_7_M_AXI_GP0_AWQOS;
  wire ps_7_M_AXI_GP0_AWREADY;
  wire [2:0]ps_7_M_AXI_GP0_AWSIZE;
  wire ps_7_M_AXI_GP0_AWVALID;
  wire [11:0]ps_7_M_AXI_GP0_BID;
  wire ps_7_M_AXI_GP0_BREADY;
  wire [1:0]ps_7_M_AXI_GP0_BRESP;
  wire ps_7_M_AXI_GP0_BVALID;
  wire [31:0]ps_7_M_AXI_GP0_RDATA;
  wire [11:0]ps_7_M_AXI_GP0_RID;
  wire ps_7_M_AXI_GP0_RLAST;
  wire ps_7_M_AXI_GP0_RREADY;
  wire [1:0]ps_7_M_AXI_GP0_RRESP;
  wire ps_7_M_AXI_GP0_RVALID;
  wire [31:0]ps_7_M_AXI_GP0_WDATA;
  wire [11:0]ps_7_M_AXI_GP0_WID;
  wire ps_7_M_AXI_GP0_WLAST;
  wire ps_7_M_AXI_GP0_WREADY;
  wire [3:0]ps_7_M_AXI_GP0_WSTRB;
  wire ps_7_M_AXI_GP0_WVALID;
  wire ps_7_SPI0_MOSI_O;
  wire ps_7_SPI0_SCLK_O;
  wire ps_7_SPI0_SS_O;
  wire [31:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [3:0]smartconnect_0_M00_AXI_AWLEN;
  wire [1:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [3:0]smartconnect_0_M00_AXI_AWQOS;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [15:0]xlconcat_1_dout;
  wire [0:0]xlconstant_0_dout;
  wire [0:0]xlconstant_1_dout;

  assign FCLK_CLK0 = microblaze_0_Clk;
  assign FCLK_CLK1 = ps_7_FCLK_CLK1;
  assign FCLK_RESET0_N = ps_7_FCLK_RESET0_N;
  assign GPIO_0_tri_o[63:0] = ps_7_GPIO_0_TRI_O;
  assign GPIO_0_tri_t[63:0] = ps_7_GPIO_0_TRI_T;
  assign M_AXI_GP0_araddr[31:0] = ps_7_M_AXI_GP0_ARADDR;
  assign M_AXI_GP0_arburst[1:0] = ps_7_M_AXI_GP0_ARBURST;
  assign M_AXI_GP0_arcache[3:0] = ps_7_M_AXI_GP0_ARCACHE;
  assign M_AXI_GP0_arid[11:0] = ps_7_M_AXI_GP0_ARID;
  assign M_AXI_GP0_arlen[3:0] = ps_7_M_AXI_GP0_ARLEN;
  assign M_AXI_GP0_arlock[1:0] = ps_7_M_AXI_GP0_ARLOCK;
  assign M_AXI_GP0_arprot[2:0] = ps_7_M_AXI_GP0_ARPROT;
  assign M_AXI_GP0_arqos[3:0] = ps_7_M_AXI_GP0_ARQOS;
  assign M_AXI_GP0_arsize[2:0] = ps_7_M_AXI_GP0_ARSIZE;
  assign M_AXI_GP0_arvalid = ps_7_M_AXI_GP0_ARVALID;
  assign M_AXI_GP0_awaddr[31:0] = ps_7_M_AXI_GP0_AWADDR;
  assign M_AXI_GP0_awburst[1:0] = ps_7_M_AXI_GP0_AWBURST;
  assign M_AXI_GP0_awcache[3:0] = ps_7_M_AXI_GP0_AWCACHE;
  assign M_AXI_GP0_awid[11:0] = ps_7_M_AXI_GP0_AWID;
  assign M_AXI_GP0_awlen[3:0] = ps_7_M_AXI_GP0_AWLEN;
  assign M_AXI_GP0_awlock[1:0] = ps_7_M_AXI_GP0_AWLOCK;
  assign M_AXI_GP0_awprot[2:0] = ps_7_M_AXI_GP0_AWPROT;
  assign M_AXI_GP0_awqos[3:0] = ps_7_M_AXI_GP0_AWQOS;
  assign M_AXI_GP0_awsize[2:0] = ps_7_M_AXI_GP0_AWSIZE;
  assign M_AXI_GP0_awvalid = ps_7_M_AXI_GP0_AWVALID;
  assign M_AXI_GP0_bready = ps_7_M_AXI_GP0_BREADY;
  assign M_AXI_GP0_rready = ps_7_M_AXI_GP0_RREADY;
  assign M_AXI_GP0_wdata[31:0] = ps_7_M_AXI_GP0_WDATA;
  assign M_AXI_GP0_wid[11:0] = ps_7_M_AXI_GP0_WID;
  assign M_AXI_GP0_wlast = ps_7_M_AXI_GP0_WLAST;
  assign M_AXI_GP0_wstrb[3:0] = ps_7_M_AXI_GP0_WSTRB;
  assign M_AXI_GP0_wvalid = ps_7_M_AXI_GP0_WVALID;
  assign SPI0_MISO_I_0_1 = SPI0_MISO_I_0;
  assign SPI0_MOSI_O_0 = ps_7_SPI0_MOSI_O;
  assign SPI0_SCLK_O_0 = ps_7_SPI0_SCLK_O;
  assign SPI0_SS_O_0 = ps_7_SPI0_SS_O;
  assign S_AXI_HP0_awready = smartconnect_0_M00_AXI_AWREADY;
  assign S_AXI_HP0_bresp[1:0] = smartconnect_0_M00_AXI_BRESP;
  assign S_AXI_HP0_bvalid = smartconnect_0_M00_AXI_BVALID;
  assign S_AXI_HP0_wready = smartconnect_0_M00_AXI_WREADY;
  assign axi_dma_0_s2mm_introut = In0[0];
  assign ps_7_GPIO_0_TRI_I = GPIO_0_tri_i[63:0];
  assign ps_7_M_AXI_GP0_ARREADY = M_AXI_GP0_arready;
  assign ps_7_M_AXI_GP0_AWREADY = M_AXI_GP0_awready;
  assign ps_7_M_AXI_GP0_BID = M_AXI_GP0_bid[11:0];
  assign ps_7_M_AXI_GP0_BRESP = M_AXI_GP0_bresp[1:0];
  assign ps_7_M_AXI_GP0_BVALID = M_AXI_GP0_bvalid;
  assign ps_7_M_AXI_GP0_RDATA = M_AXI_GP0_rdata[31:0];
  assign ps_7_M_AXI_GP0_RID = M_AXI_GP0_rid[11:0];
  assign ps_7_M_AXI_GP0_RLAST = M_AXI_GP0_rlast;
  assign ps_7_M_AXI_GP0_RRESP = M_AXI_GP0_rresp[1:0];
  assign ps_7_M_AXI_GP0_RVALID = M_AXI_GP0_rvalid;
  assign ps_7_M_AXI_GP0_WREADY = M_AXI_GP0_wready;
  assign smartconnect_0_M00_AXI_AWADDR = S_AXI_HP0_awaddr[31:0];
  assign smartconnect_0_M00_AXI_AWBURST = S_AXI_HP0_awburst[1:0];
  assign smartconnect_0_M00_AXI_AWCACHE = S_AXI_HP0_awcache[3:0];
  assign smartconnect_0_M00_AXI_AWLEN = S_AXI_HP0_awlen[3:0];
  assign smartconnect_0_M00_AXI_AWLOCK = S_AXI_HP0_awlock[1:0];
  assign smartconnect_0_M00_AXI_AWPROT = S_AXI_HP0_awprot[2:0];
  assign smartconnect_0_M00_AXI_AWQOS = S_AXI_HP0_awqos[3:0];
  assign smartconnect_0_M00_AXI_AWSIZE = S_AXI_HP0_awsize[2:0];
  assign smartconnect_0_M00_AXI_AWVALID = S_AXI_HP0_awvalid;
  assign smartconnect_0_M00_AXI_BREADY = S_AXI_HP0_bready;
  assign smartconnect_0_M00_AXI_WDATA = S_AXI_HP0_wdata[63:0];
  assign smartconnect_0_M00_AXI_WLAST = S_AXI_HP0_wlast;
  assign smartconnect_0_M00_AXI_WSTRB = S_AXI_HP0_wstrb[7:0];
  assign smartconnect_0_M00_AXI_WVALID = S_AXI_HP0_wvalid;
  system_top_ps_7_0 ps_7
       (.DDR_Addr(DDR_0_addr[14:0]),
        .DDR_BankAddr(DDR_0_ba[2:0]),
        .DDR_CAS_n(DDR_0_cas_n),
        .DDR_CKE(DDR_0_cke),
        .DDR_CS_n(DDR_0_cs_n),
        .DDR_Clk(DDR_0_ck_p),
        .DDR_Clk_n(DDR_0_ck_n),
        .DDR_DM(DDR_0_dm[3:0]),
        .DDR_DQ(DDR_0_dq[31:0]),
        .DDR_DQS(DDR_0_dqs_p[3:0]),
        .DDR_DQS_n(DDR_0_dqs_n[3:0]),
        .DDR_DRSTB(DDR_0_reset_n),
        .DDR_ODT(DDR_0_odt),
        .DDR_RAS_n(DDR_0_ras_n),
        .DDR_VRN(FIXED_IO_0_ddr_vrn),
        .DDR_VRP(FIXED_IO_0_ddr_vrp),
        .DDR_WEB(DDR_0_we_n),
        .FCLK_CLK0(microblaze_0_Clk),
        .FCLK_CLK1(ps_7_FCLK_CLK1),
        .FCLK_RESET0_N(ps_7_FCLK_RESET0_N),
        .GPIO_I(ps_7_GPIO_0_TRI_I),
        .GPIO_O(ps_7_GPIO_0_TRI_O),
        .GPIO_T(ps_7_GPIO_0_TRI_T),
        .IRQ_F2P(xlconcat_1_dout),
        .MIO(FIXED_IO_0_mio[53:0]),
        .M_AXI_GP0_ACLK(microblaze_0_Clk),
        .M_AXI_GP0_ARADDR(ps_7_M_AXI_GP0_ARADDR),
        .M_AXI_GP0_ARBURST(ps_7_M_AXI_GP0_ARBURST),
        .M_AXI_GP0_ARCACHE(ps_7_M_AXI_GP0_ARCACHE),
        .M_AXI_GP0_ARID(ps_7_M_AXI_GP0_ARID),
        .M_AXI_GP0_ARLEN(ps_7_M_AXI_GP0_ARLEN),
        .M_AXI_GP0_ARLOCK(ps_7_M_AXI_GP0_ARLOCK),
        .M_AXI_GP0_ARPROT(ps_7_M_AXI_GP0_ARPROT),
        .M_AXI_GP0_ARQOS(ps_7_M_AXI_GP0_ARQOS),
        .M_AXI_GP0_ARREADY(ps_7_M_AXI_GP0_ARREADY),
        .M_AXI_GP0_ARSIZE(ps_7_M_AXI_GP0_ARSIZE),
        .M_AXI_GP0_ARVALID(ps_7_M_AXI_GP0_ARVALID),
        .M_AXI_GP0_AWADDR(ps_7_M_AXI_GP0_AWADDR),
        .M_AXI_GP0_AWBURST(ps_7_M_AXI_GP0_AWBURST),
        .M_AXI_GP0_AWCACHE(ps_7_M_AXI_GP0_AWCACHE),
        .M_AXI_GP0_AWID(ps_7_M_AXI_GP0_AWID),
        .M_AXI_GP0_AWLEN(ps_7_M_AXI_GP0_AWLEN),
        .M_AXI_GP0_AWLOCK(ps_7_M_AXI_GP0_AWLOCK),
        .M_AXI_GP0_AWPROT(ps_7_M_AXI_GP0_AWPROT),
        .M_AXI_GP0_AWQOS(ps_7_M_AXI_GP0_AWQOS),
        .M_AXI_GP0_AWREADY(ps_7_M_AXI_GP0_AWREADY),
        .M_AXI_GP0_AWSIZE(ps_7_M_AXI_GP0_AWSIZE),
        .M_AXI_GP0_AWVALID(ps_7_M_AXI_GP0_AWVALID),
        .M_AXI_GP0_BID(ps_7_M_AXI_GP0_BID),
        .M_AXI_GP0_BREADY(ps_7_M_AXI_GP0_BREADY),
        .M_AXI_GP0_BRESP(ps_7_M_AXI_GP0_BRESP),
        .M_AXI_GP0_BVALID(ps_7_M_AXI_GP0_BVALID),
        .M_AXI_GP0_RDATA(ps_7_M_AXI_GP0_RDATA),
        .M_AXI_GP0_RID(ps_7_M_AXI_GP0_RID),
        .M_AXI_GP0_RLAST(ps_7_M_AXI_GP0_RLAST),
        .M_AXI_GP0_RREADY(ps_7_M_AXI_GP0_RREADY),
        .M_AXI_GP0_RRESP(ps_7_M_AXI_GP0_RRESP),
        .M_AXI_GP0_RVALID(ps_7_M_AXI_GP0_RVALID),
        .M_AXI_GP0_WDATA(ps_7_M_AXI_GP0_WDATA),
        .M_AXI_GP0_WID(ps_7_M_AXI_GP0_WID),
        .M_AXI_GP0_WLAST(ps_7_M_AXI_GP0_WLAST),
        .M_AXI_GP0_WREADY(ps_7_M_AXI_GP0_WREADY),
        .M_AXI_GP0_WSTRB(ps_7_M_AXI_GP0_WSTRB),
        .M_AXI_GP0_WVALID(ps_7_M_AXI_GP0_WVALID),
        .PS_CLK(FIXED_IO_0_ps_clk),
        .PS_PORB(FIXED_IO_0_ps_porb),
        .PS_SRSTB(FIXED_IO_0_ps_srstb),
        .SPI0_MISO_I(SPI0_MISO_I_0_1),
        .SPI0_MOSI_I(1'b0),
        .SPI0_MOSI_O(ps_7_SPI0_MOSI_O),
        .SPI0_SCLK_I(1'b0),
        .SPI0_SCLK_O(ps_7_SPI0_SCLK_O),
        .SPI0_SS_I(xlconstant_0_dout),
        .SPI0_SS_O(ps_7_SPI0_SS_O),
        .S_AXI_HP0_ACLK(microblaze_0_Clk),
        .S_AXI_HP0_ARADDR({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARBURST({1'b0,1'b1}),
        .S_AXI_HP0_ARCACHE({1'b0,1'b0,1'b1,1'b1}),
        .S_AXI_HP0_ARID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARLEN({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARLOCK({1'b0,1'b0}),
        .S_AXI_HP0_ARPROT({1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARQOS({1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_ARSIZE({1'b0,1'b1,1'b1}),
        .S_AXI_HP0_ARVALID(1'b0),
        .S_AXI_HP0_AWADDR(smartconnect_0_M00_AXI_AWADDR),
        .S_AXI_HP0_AWBURST(smartconnect_0_M00_AXI_AWBURST),
        .S_AXI_HP0_AWCACHE(smartconnect_0_M00_AXI_AWCACHE),
        .S_AXI_HP0_AWID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_AWLEN(smartconnect_0_M00_AXI_AWLEN),
        .S_AXI_HP0_AWLOCK(smartconnect_0_M00_AXI_AWLOCK),
        .S_AXI_HP0_AWPROT(smartconnect_0_M00_AXI_AWPROT),
        .S_AXI_HP0_AWQOS(smartconnect_0_M00_AXI_AWQOS),
        .S_AXI_HP0_AWREADY(smartconnect_0_M00_AXI_AWREADY),
        .S_AXI_HP0_AWSIZE(smartconnect_0_M00_AXI_AWSIZE),
        .S_AXI_HP0_AWVALID(smartconnect_0_M00_AXI_AWVALID),
        .S_AXI_HP0_BREADY(smartconnect_0_M00_AXI_BREADY),
        .S_AXI_HP0_BRESP(smartconnect_0_M00_AXI_BRESP),
        .S_AXI_HP0_BVALID(smartconnect_0_M00_AXI_BVALID),
        .S_AXI_HP0_RDISSUECAP1_EN(1'b0),
        .S_AXI_HP0_RREADY(1'b0),
        .S_AXI_HP0_WDATA(smartconnect_0_M00_AXI_WDATA),
        .S_AXI_HP0_WID({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .S_AXI_HP0_WLAST(smartconnect_0_M00_AXI_WLAST),
        .S_AXI_HP0_WREADY(smartconnect_0_M00_AXI_WREADY),
        .S_AXI_HP0_WRISSUECAP1_EN(1'b0),
        .S_AXI_HP0_WSTRB(smartconnect_0_M00_AXI_WSTRB),
        .S_AXI_HP0_WVALID(smartconnect_0_M00_AXI_WVALID));
  system_top_xlconcat_1_0 xlconcat_1
       (.In0(axi_dma_0_s2mm_introut),
        .In1(xlconstant_1_dout),
        .In10(xlconstant_1_dout),
        .In11(xlconstant_1_dout),
        .In12(xlconstant_1_dout),
        .In13(xlconstant_1_dout),
        .In14(xlconstant_1_dout),
        .In15(xlconstant_1_dout),
        .In2(xlconstant_1_dout),
        .In3(xlconstant_1_dout),
        .In4(xlconstant_1_dout),
        .In5(xlconstant_1_dout),
        .In6(xlconstant_1_dout),
        .In7(xlconstant_1_dout),
        .In8(xlconstant_1_dout),
        .In9(xlconstant_1_dout),
        .dout(xlconcat_1_dout));
  system_top_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  system_top_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
endmodule

module Rx_TestBench_imp_YJJKUH
   (M_AXI_S2MM_awaddr,
    M_AXI_S2MM_awburst,
    M_AXI_S2MM_awcache,
    M_AXI_S2MM_awlen,
    M_AXI_S2MM_awprot,
    M_AXI_S2MM_awready,
    M_AXI_S2MM_awsize,
    M_AXI_S2MM_awvalid,
    M_AXI_S2MM_bready,
    M_AXI_S2MM_bresp,
    M_AXI_S2MM_bvalid,
    M_AXI_S2MM_wdata,
    M_AXI_S2MM_wlast,
    M_AXI_S2MM_wready,
    M_AXI_S2MM_wstrb,
    M_AXI_S2MM_wvalid,
    S_AXI_LITE_araddr,
    S_AXI_LITE_arready,
    S_AXI_LITE_arvalid,
    S_AXI_LITE_awaddr,
    S_AXI_LITE_awready,
    S_AXI_LITE_awvalid,
    S_AXI_LITE_bready,
    S_AXI_LITE_bresp,
    S_AXI_LITE_bvalid,
    S_AXI_LITE_rdata,
    S_AXI_LITE_rready,
    S_AXI_LITE_rresp,
    S_AXI_LITE_rvalid,
    S_AXI_LITE_wdata,
    S_AXI_LITE_wready,
    S_AXI_LITE_wvalid,
    axi_resetn,
    iq_ch0_i,
    iq_ch0_q,
    iq_ch1_i,
    iq_ch1_q,
    resetn,
    rx_valid,
    s2mm_introut,
    s_axi_lite_aclk,
    s_axis_aclk,
    s_axis_aresetn);
  output [31:0]M_AXI_S2MM_awaddr;
  output [1:0]M_AXI_S2MM_awburst;
  output [3:0]M_AXI_S2MM_awcache;
  output [7:0]M_AXI_S2MM_awlen;
  output [2:0]M_AXI_S2MM_awprot;
  input M_AXI_S2MM_awready;
  output [2:0]M_AXI_S2MM_awsize;
  output M_AXI_S2MM_awvalid;
  output M_AXI_S2MM_bready;
  input [1:0]M_AXI_S2MM_bresp;
  input M_AXI_S2MM_bvalid;
  output [63:0]M_AXI_S2MM_wdata;
  output M_AXI_S2MM_wlast;
  input M_AXI_S2MM_wready;
  output [7:0]M_AXI_S2MM_wstrb;
  output M_AXI_S2MM_wvalid;
  input [9:0]S_AXI_LITE_araddr;
  output S_AXI_LITE_arready;
  input S_AXI_LITE_arvalid;
  input [9:0]S_AXI_LITE_awaddr;
  output S_AXI_LITE_awready;
  input S_AXI_LITE_awvalid;
  input S_AXI_LITE_bready;
  output [1:0]S_AXI_LITE_bresp;
  output S_AXI_LITE_bvalid;
  output [31:0]S_AXI_LITE_rdata;
  input S_AXI_LITE_rready;
  output [1:0]S_AXI_LITE_rresp;
  output S_AXI_LITE_rvalid;
  input [31:0]S_AXI_LITE_wdata;
  output S_AXI_LITE_wready;
  input S_AXI_LITE_wvalid;
  input axi_resetn;
  input [15:0]iq_ch0_i;
  input [15:0]iq_ch0_q;
  input [15:0]iq_ch1_i;
  input [15:0]iq_ch1_q;
  input resetn;
  input rx_valid;
  output s2mm_introut;
  input s_axi_lite_aclk;
  input s_axis_aclk;
  input s_axis_aresetn;

  wire F_clk0;
  wire Net;
  wire [31:0]axi_dma_0_M_AXI_S2MM_AWADDR;
  wire [1:0]axi_dma_0_M_AXI_S2MM_AWBURST;
  wire [3:0]axi_dma_0_M_AXI_S2MM_AWCACHE;
  wire [7:0]axi_dma_0_M_AXI_S2MM_AWLEN;
  wire [2:0]axi_dma_0_M_AXI_S2MM_AWPROT;
  wire axi_dma_0_M_AXI_S2MM_AWREADY;
  wire [2:0]axi_dma_0_M_AXI_S2MM_AWSIZE;
  wire axi_dma_0_M_AXI_S2MM_AWVALID;
  wire axi_dma_0_M_AXI_S2MM_BREADY;
  wire [1:0]axi_dma_0_M_AXI_S2MM_BRESP;
  wire axi_dma_0_M_AXI_S2MM_BVALID;
  wire [63:0]axi_dma_0_M_AXI_S2MM_WDATA;
  wire axi_dma_0_M_AXI_S2MM_WLAST;
  wire axi_dma_0_M_AXI_S2MM_WREADY;
  wire [7:0]axi_dma_0_M_AXI_S2MM_WSTRB;
  wire axi_dma_0_M_AXI_S2MM_WVALID;
  wire axi_dma_0_s2mm_introut;
  wire [9:0]axi_smc_M00_AXI_ARADDR;
  wire axi_smc_M00_AXI_ARREADY;
  wire axi_smc_M00_AXI_ARVALID;
  wire [9:0]axi_smc_M00_AXI_AWADDR;
  wire axi_smc_M00_AXI_AWREADY;
  wire axi_smc_M00_AXI_AWVALID;
  wire axi_smc_M00_AXI_BREADY;
  wire [1:0]axi_smc_M00_AXI_BRESP;
  wire axi_smc_M00_AXI_BVALID;
  wire [31:0]axi_smc_M00_AXI_RDATA;
  wire axi_smc_M00_AXI_RREADY;
  wire [1:0]axi_smc_M00_AXI_RRESP;
  wire axi_smc_M00_AXI_RVALID;
  wire [31:0]axi_smc_M00_AXI_WDATA;
  wire axi_smc_M00_AXI_WREADY;
  wire axi_smc_M00_AXI_WVALID;
  wire [63:0]axis_data_fifo_0_M_AXIS_TDATA;
  wire axis_data_fifo_0_M_AXIS_TLAST;
  wire axis_data_fifo_0_M_AXIS_TREADY;
  wire axis_data_fifo_0_M_AXIS_TVALID;
  wire [63:0]custom_pack_0_m_axis_TDATA;
  wire custom_pack_0_m_axis_TLAST;
  wire custom_pack_0_m_axis_TREADY;
  wire custom_pack_0_m_axis_TVALID;
  wire proc_sys_reset_0_interconnect_aresetn;
  wire proc_sys_reset_0_peripheral_aresetn;
  wire rst_ps_7_50M_peripheral_aresetn;
  wire [15:0]util_wfifo_0_dout_data_0;
  wire [15:0]util_wfifo_0_dout_data_1;
  wire [15:0]util_wfifo_0_dout_data_2;
  wire [15:0]util_wfifo_0_dout_data_3;
  wire util_wfifo_0_dout_valid_0;

  assign F_clk0 = s_axi_lite_aclk;
  assign M_AXI_S2MM_awaddr[31:0] = axi_dma_0_M_AXI_S2MM_AWADDR;
  assign M_AXI_S2MM_awburst[1:0] = axi_dma_0_M_AXI_S2MM_AWBURST;
  assign M_AXI_S2MM_awcache[3:0] = axi_dma_0_M_AXI_S2MM_AWCACHE;
  assign M_AXI_S2MM_awlen[7:0] = axi_dma_0_M_AXI_S2MM_AWLEN;
  assign M_AXI_S2MM_awprot[2:0] = axi_dma_0_M_AXI_S2MM_AWPROT;
  assign M_AXI_S2MM_awsize[2:0] = axi_dma_0_M_AXI_S2MM_AWSIZE;
  assign M_AXI_S2MM_awvalid = axi_dma_0_M_AXI_S2MM_AWVALID;
  assign M_AXI_S2MM_bready = axi_dma_0_M_AXI_S2MM_BREADY;
  assign M_AXI_S2MM_wdata[63:0] = axi_dma_0_M_AXI_S2MM_WDATA;
  assign M_AXI_S2MM_wlast = axi_dma_0_M_AXI_S2MM_WLAST;
  assign M_AXI_S2MM_wstrb[7:0] = axi_dma_0_M_AXI_S2MM_WSTRB;
  assign M_AXI_S2MM_wvalid = axi_dma_0_M_AXI_S2MM_WVALID;
  assign Net = s_axis_aclk;
  assign S_AXI_LITE_arready = axi_smc_M00_AXI_ARREADY;
  assign S_AXI_LITE_awready = axi_smc_M00_AXI_AWREADY;
  assign S_AXI_LITE_bresp[1:0] = axi_smc_M00_AXI_BRESP;
  assign S_AXI_LITE_bvalid = axi_smc_M00_AXI_BVALID;
  assign S_AXI_LITE_rdata[31:0] = axi_smc_M00_AXI_RDATA;
  assign S_AXI_LITE_rresp[1:0] = axi_smc_M00_AXI_RRESP;
  assign S_AXI_LITE_rvalid = axi_smc_M00_AXI_RVALID;
  assign S_AXI_LITE_wready = axi_smc_M00_AXI_WREADY;
  assign axi_dma_0_M_AXI_S2MM_AWREADY = M_AXI_S2MM_awready;
  assign axi_dma_0_M_AXI_S2MM_BRESP = M_AXI_S2MM_bresp[1:0];
  assign axi_dma_0_M_AXI_S2MM_BVALID = M_AXI_S2MM_bvalid;
  assign axi_dma_0_M_AXI_S2MM_WREADY = M_AXI_S2MM_wready;
  assign axi_smc_M00_AXI_ARADDR = S_AXI_LITE_araddr[9:0];
  assign axi_smc_M00_AXI_ARVALID = S_AXI_LITE_arvalid;
  assign axi_smc_M00_AXI_AWADDR = S_AXI_LITE_awaddr[9:0];
  assign axi_smc_M00_AXI_AWVALID = S_AXI_LITE_awvalid;
  assign axi_smc_M00_AXI_BREADY = S_AXI_LITE_bready;
  assign axi_smc_M00_AXI_RREADY = S_AXI_LITE_rready;
  assign axi_smc_M00_AXI_WDATA = S_AXI_LITE_wdata[31:0];
  assign axi_smc_M00_AXI_WVALID = S_AXI_LITE_wvalid;
  assign proc_sys_reset_0_interconnect_aresetn = s_axis_aresetn;
  assign proc_sys_reset_0_peripheral_aresetn = resetn;
  assign rst_ps_7_50M_peripheral_aresetn = axi_resetn;
  assign s2mm_introut = axi_dma_0_s2mm_introut;
  assign util_wfifo_0_dout_data_0 = iq_ch0_i[15:0];
  assign util_wfifo_0_dout_data_1 = iq_ch0_q[15:0];
  assign util_wfifo_0_dout_data_2 = iq_ch1_i[15:0];
  assign util_wfifo_0_dout_data_3 = iq_ch1_q[15:0];
  assign util_wfifo_0_dout_valid_0 = rx_valid;
  system_top_axi_dma_0_0 axi_dma_0
       (.axi_resetn(rst_ps_7_50M_peripheral_aresetn),
        .m_axi_s2mm_aclk(F_clk0),
        .m_axi_s2mm_awaddr(axi_dma_0_M_AXI_S2MM_AWADDR),
        .m_axi_s2mm_awburst(axi_dma_0_M_AXI_S2MM_AWBURST),
        .m_axi_s2mm_awcache(axi_dma_0_M_AXI_S2MM_AWCACHE),
        .m_axi_s2mm_awlen(axi_dma_0_M_AXI_S2MM_AWLEN),
        .m_axi_s2mm_awprot(axi_dma_0_M_AXI_S2MM_AWPROT),
        .m_axi_s2mm_awready(axi_dma_0_M_AXI_S2MM_AWREADY),
        .m_axi_s2mm_awsize(axi_dma_0_M_AXI_S2MM_AWSIZE),
        .m_axi_s2mm_awvalid(axi_dma_0_M_AXI_S2MM_AWVALID),
        .m_axi_s2mm_bready(axi_dma_0_M_AXI_S2MM_BREADY),
        .m_axi_s2mm_bresp(axi_dma_0_M_AXI_S2MM_BRESP),
        .m_axi_s2mm_bvalid(axi_dma_0_M_AXI_S2MM_BVALID),
        .m_axi_s2mm_wdata(axi_dma_0_M_AXI_S2MM_WDATA),
        .m_axi_s2mm_wlast(axi_dma_0_M_AXI_S2MM_WLAST),
        .m_axi_s2mm_wready(axi_dma_0_M_AXI_S2MM_WREADY),
        .m_axi_s2mm_wstrb(axi_dma_0_M_AXI_S2MM_WSTRB),
        .m_axi_s2mm_wvalid(axi_dma_0_M_AXI_S2MM_WVALID),
        .s2mm_introut(axi_dma_0_s2mm_introut),
        .s_axi_lite_aclk(F_clk0),
        .s_axi_lite_araddr(axi_smc_M00_AXI_ARADDR),
        .s_axi_lite_arready(axi_smc_M00_AXI_ARREADY),
        .s_axi_lite_arvalid(axi_smc_M00_AXI_ARVALID),
        .s_axi_lite_awaddr(axi_smc_M00_AXI_AWADDR),
        .s_axi_lite_awready(axi_smc_M00_AXI_AWREADY),
        .s_axi_lite_awvalid(axi_smc_M00_AXI_AWVALID),
        .s_axi_lite_bready(axi_smc_M00_AXI_BREADY),
        .s_axi_lite_bresp(axi_smc_M00_AXI_BRESP),
        .s_axi_lite_bvalid(axi_smc_M00_AXI_BVALID),
        .s_axi_lite_rdata(axi_smc_M00_AXI_RDATA),
        .s_axi_lite_rready(axi_smc_M00_AXI_RREADY),
        .s_axi_lite_rresp(axi_smc_M00_AXI_RRESP),
        .s_axi_lite_rvalid(axi_smc_M00_AXI_RVALID),
        .s_axi_lite_wdata(axi_smc_M00_AXI_WDATA),
        .s_axi_lite_wready(axi_smc_M00_AXI_WREADY),
        .s_axi_lite_wvalid(axi_smc_M00_AXI_WVALID),
        .s_axis_s2mm_tdata(axis_data_fifo_0_M_AXIS_TDATA),
        .s_axis_s2mm_tkeep({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .s_axis_s2mm_tlast(axis_data_fifo_0_M_AXIS_TLAST),
        .s_axis_s2mm_tready(axis_data_fifo_0_M_AXIS_TREADY),
        .s_axis_s2mm_tvalid(axis_data_fifo_0_M_AXIS_TVALID));
  system_top_axis_data_fifo_0_0 axis_data_fifo_0
       (.m_axis_aclk(F_clk0),
        .m_axis_tdata(axis_data_fifo_0_M_AXIS_TDATA),
        .m_axis_tlast(axis_data_fifo_0_M_AXIS_TLAST),
        .m_axis_tready(axis_data_fifo_0_M_AXIS_TREADY),
        .m_axis_tvalid(axis_data_fifo_0_M_AXIS_TVALID),
        .s_axis_aclk(Net),
        .s_axis_aresetn(proc_sys_reset_0_interconnect_aresetn),
        .s_axis_tdata(custom_pack_0_m_axis_TDATA),
        .s_axis_tlast(custom_pack_0_m_axis_TLAST),
        .s_axis_tready(custom_pack_0_m_axis_TREADY),
        .s_axis_tvalid(custom_pack_0_m_axis_TVALID));
  system_top_tlast_generator_0_0 tlast_generator_0
       (.clk(Net),
        .iq_ch0_i(util_wfifo_0_dout_data_0),
        .iq_ch0_q(util_wfifo_0_dout_data_1),
        .iq_ch1_i(util_wfifo_0_dout_data_2),
        .iq_ch1_q(util_wfifo_0_dout_data_3),
        .m_axis_tdata(custom_pack_0_m_axis_TDATA),
        .m_axis_tlast(custom_pack_0_m_axis_TLAST),
        .m_axis_tready(custom_pack_0_m_axis_TREADY),
        .m_axis_tvalid(custom_pack_0_m_axis_TVALID),
        .resetn(proc_sys_reset_0_peripheral_aresetn),
        .rx_valid(util_wfifo_0_dout_valid_0));
endmodule

module Tx_TestBench_imp_41GIBT
   (Dout,
    Dout1,
    Dout2,
    Dout3,
    aclk,
    m_axis_dout_tdata,
    m_axis_dout_tvalid,
    m_axis_dout_tvalid1);
  output [15:0]Dout;
  output [15:0]Dout1;
  output [15:0]Dout2;
  output [15:0]Dout3;
  input aclk;
  output [31:0]m_axis_dout_tdata;
  output m_axis_dout_tvalid;
  output m_axis_dout_tvalid1;

  wire Net;
  wire [15:0]c_counter_binary_0_Q;
  wire [31:0]cordic_0_m_axis_dout_tdata;
  wire cordic_0_m_axis_dout_tvalid;
  wire [0:0]xlconstant_0_dout;
  wire [31:0]xlconstant_1_dout;
  wire [15:0]xlslice_0_Dout;
  wire [15:0]xlslice_1_Dout;

  assign Dout[15:0] = xlslice_0_Dout;
  assign Dout1[15:0] = xlslice_1_Dout;
  assign Dout2[15:0] = xlslice_0_Dout;
  assign Dout3[15:0] = xlslice_1_Dout;
  assign Net = aclk;
  assign m_axis_dout_tdata[31:0] = cordic_0_m_axis_dout_tdata;
  assign m_axis_dout_tvalid = cordic_0_m_axis_dout_tvalid;
  assign m_axis_dout_tvalid1 = cordic_0_m_axis_dout_tvalid;
  system_top_c_counter_binary_0_0 c_counter_binary_0
       (.CLK(Net),
        .Q(c_counter_binary_0_Q));
  system_top_cordic_0_0 cordic_0
       (.aclk(Net),
        .m_axis_dout_tdata(cordic_0_m_axis_dout_tdata),
        .m_axis_dout_tvalid(cordic_0_m_axis_dout_tvalid),
        .s_axis_cartesian_tdata(xlconstant_1_dout),
        .s_axis_cartesian_tvalid(xlconstant_0_dout),
        .s_axis_phase_tdata(c_counter_binary_0_Q),
        .s_axis_phase_tvalid(xlconstant_0_dout));
  system_top_xlconstant_0_1 xlconstant_0
       (.dout(xlconstant_0_dout));
  system_top_xlconstant_1_1 xlconstant_1
       (.dout(xlconstant_1_dout));
  system_top_xlslice_0_0 xlslice_0
       (.Din(cordic_0_m_axis_dout_tdata),
        .Dout(xlslice_0_Dout));
  system_top_xlslice_1_0 xlslice_1
       (.Din(cordic_0_m_axis_dout_tdata),
        .Dout(xlslice_1_Dout));
endmodule

(* CORE_GENERATION_INFO = "system_top,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=system_top,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=26,numReposBlks=22,numNonXlnxBlks=3,numHierBlks=4,maxHierDepth=1,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "system_top.hwdef" *) 
module system_top
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
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 ADDR" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DDR_0, AXI_ARBITRATION_SCHEME TDM, BURST_LENGTH 8, CAN_DEBUG false, CAS_LATENCY 11, CAS_WRITE_LATENCY 11, CS_ENABLED true, DATA_MASK_ENABLED true, DATA_WIDTH 8, MEMORY_TYPE COMPONENTS, MEM_ADDR_MAP ROW_COLUMN_BANK, SLOT Single, TIMEPERIOD_PS 1250" *) inout [14:0]DDR_0_addr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 BA" *) inout [2:0]DDR_0_ba;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CAS_N" *) inout DDR_0_cas_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CK_N" *) inout DDR_0_ck_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CK_P" *) inout DDR_0_ck_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CKE" *) inout DDR_0_cke;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 CS_N" *) inout DDR_0_cs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DM" *) inout [3:0]DDR_0_dm;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQ" *) inout [31:0]DDR_0_dq;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQS_N" *) inout [3:0]DDR_0_dqs_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 DQS_P" *) inout [3:0]DDR_0_dqs_p;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 ODT" *) inout DDR_0_odt;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 RAS_N" *) inout DDR_0_ras_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 RESET_N" *) inout DDR_0_reset_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:ddrx:1.0 DDR_0 WE_N" *) inout DDR_0_we_n;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 DDR_VRN" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME FIXED_IO_0, CAN_DEBUG false" *) inout FIXED_IO_0_ddr_vrn;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 DDR_VRP" *) inout FIXED_IO_0_ddr_vrp;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 MIO" *) inout [53:0]FIXED_IO_0_mio;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_CLK" *) inout FIXED_IO_0_ps_clk;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_PORB" *) inout FIXED_IO_0_ps_porb;
  (* X_INTERFACE_INFO = "xilinx.com:display_processing_system7:fixedio:1.0 FIXED_IO_0 PS_SRSTB" *) inout FIXED_IO_0_ps_srstb;
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

  wire F_clk0;
  wire IP_AnalogDevices_adc_r1_mode;
  wire IP_AnalogDevices_dac_r1_mode;
  wire Net;
  wire SPI0_MISO_I_0_1;
  wire ad9361_io_manager_0_gpio_clksel;
  wire [3:0]ad9361_io_manager_0_gpio_ctl;
  wire ad9361_io_manager_0_gpio_en_agc;
  wire ad9361_io_manager_0_gpio_resetb;
  wire ad9361_io_manager_0_gpio_sync;
  wire ad9361_io_manager_0_up_enable;
  wire ad9361_io_manager_0_up_txnrx;
  wire axi_ad9361_0_enable;
  wire axi_ad9361_0_l_clk;
  wire axi_ad9361_0_tx_clk_out_n;
  wire axi_ad9361_0_tx_clk_out_p;
  wire [5:0]axi_ad9361_0_tx_data_out_n;
  wire [5:0]axi_ad9361_0_tx_data_out_p;
  wire axi_ad9361_0_tx_frame_out_n;
  wire axi_ad9361_0_tx_frame_out_p;
  wire axi_ad9361_0_txnrx;
  wire [31:0]axi_dma_0_M_AXI_S2MM_AWADDR;
  wire [1:0]axi_dma_0_M_AXI_S2MM_AWBURST;
  wire [3:0]axi_dma_0_M_AXI_S2MM_AWCACHE;
  wire [7:0]axi_dma_0_M_AXI_S2MM_AWLEN;
  wire [2:0]axi_dma_0_M_AXI_S2MM_AWPROT;
  wire axi_dma_0_M_AXI_S2MM_AWREADY;
  wire [2:0]axi_dma_0_M_AXI_S2MM_AWSIZE;
  wire axi_dma_0_M_AXI_S2MM_AWVALID;
  wire axi_dma_0_M_AXI_S2MM_BREADY;
  wire [1:0]axi_dma_0_M_AXI_S2MM_BRESP;
  wire axi_dma_0_M_AXI_S2MM_BVALID;
  wire [63:0]axi_dma_0_M_AXI_S2MM_WDATA;
  wire axi_dma_0_M_AXI_S2MM_WLAST;
  wire axi_dma_0_M_AXI_S2MM_WREADY;
  wire [7:0]axi_dma_0_M_AXI_S2MM_WSTRB;
  wire axi_dma_0_M_AXI_S2MM_WVALID;
  wire axi_dma_0_s2mm_introut;
  wire [9:0]axi_smc_M00_AXI_ARADDR;
  wire axi_smc_M00_AXI_ARREADY;
  wire axi_smc_M00_AXI_ARVALID;
  wire [9:0]axi_smc_M00_AXI_AWADDR;
  wire axi_smc_M00_AXI_AWREADY;
  wire axi_smc_M00_AXI_AWVALID;
  wire axi_smc_M00_AXI_BREADY;
  wire [1:0]axi_smc_M00_AXI_BRESP;
  wire axi_smc_M00_AXI_BVALID;
  wire [31:0]axi_smc_M00_AXI_RDATA;
  wire axi_smc_M00_AXI_RREADY;
  wire [1:0]axi_smc_M00_AXI_RRESP;
  wire axi_smc_M00_AXI_RVALID;
  wire [31:0]axi_smc_M00_AXI_WDATA;
  wire axi_smc_M00_AXI_WREADY;
  wire axi_smc_M00_AXI_WVALID;
  wire [15:0]axi_smc_M01_AXI_ARADDR;
  wire [2:0]axi_smc_M01_AXI_ARPROT;
  wire axi_smc_M01_AXI_ARREADY;
  wire axi_smc_M01_AXI_ARVALID;
  wire [15:0]axi_smc_M01_AXI_AWADDR;
  wire [2:0]axi_smc_M01_AXI_AWPROT;
  wire axi_smc_M01_AXI_AWREADY;
  wire axi_smc_M01_AXI_AWVALID;
  wire axi_smc_M01_AXI_BREADY;
  wire [1:0]axi_smc_M01_AXI_BRESP;
  wire axi_smc_M01_AXI_BVALID;
  wire [31:0]axi_smc_M01_AXI_RDATA;
  wire axi_smc_M01_AXI_RREADY;
  wire [1:0]axi_smc_M01_AXI_RRESP;
  wire axi_smc_M01_AXI_RVALID;
  wire [31:0]axi_smc_M01_AXI_WDATA;
  wire axi_smc_M01_AXI_WREADY;
  wire [3:0]axi_smc_M01_AXI_WSTRB;
  wire axi_smc_M01_AXI_WVALID;
  wire cordic_0_m_axis_dout_tvalid;
  wire cordic_1_m_axis_dout_tvalid;
  wire [7:0]gpio_status_0_1;
  wire [0:0]proc_sys_reset_0_interconnect_aresetn;
  wire [0:0]proc_sys_reset_0_peripheral_aresetn;
  wire [14:0]ps_7_DDR_ADDR;
  wire [2:0]ps_7_DDR_BA;
  wire ps_7_DDR_CAS_N;
  wire ps_7_DDR_CKE;
  wire ps_7_DDR_CK_N;
  wire ps_7_DDR_CK_P;
  wire ps_7_DDR_CS_N;
  wire [3:0]ps_7_DDR_DM;
  wire [31:0]ps_7_DDR_DQ;
  wire [3:0]ps_7_DDR_DQS_N;
  wire [3:0]ps_7_DDR_DQS_P;
  wire ps_7_DDR_ODT;
  wire ps_7_DDR_RAS_N;
  wire ps_7_DDR_RESET_N;
  wire ps_7_DDR_WE_N;
  wire ps_7_FCLK_CLK1;
  wire ps_7_FCLK_RESET0_N;
  wire ps_7_FIXED_IO_DDR_VRN;
  wire ps_7_FIXED_IO_DDR_VRP;
  wire [53:0]ps_7_FIXED_IO_MIO;
  wire ps_7_FIXED_IO_PS_CLK;
  wire ps_7_FIXED_IO_PS_PORB;
  wire ps_7_FIXED_IO_PS_SRSTB;
  wire [63:0]ps_7_GPIO_0_TRI_I;
  wire [63:0]ps_7_GPIO_0_TRI_O;
  wire [63:0]ps_7_GPIO_0_TRI_T;
  wire [31:0]ps_7_M_AXI_GP0_ARADDR;
  wire [1:0]ps_7_M_AXI_GP0_ARBURST;
  wire [3:0]ps_7_M_AXI_GP0_ARCACHE;
  wire [11:0]ps_7_M_AXI_GP0_ARID;
  wire [3:0]ps_7_M_AXI_GP0_ARLEN;
  wire [1:0]ps_7_M_AXI_GP0_ARLOCK;
  wire [2:0]ps_7_M_AXI_GP0_ARPROT;
  wire [3:0]ps_7_M_AXI_GP0_ARQOS;
  wire ps_7_M_AXI_GP0_ARREADY;
  wire [2:0]ps_7_M_AXI_GP0_ARSIZE;
  wire ps_7_M_AXI_GP0_ARVALID;
  wire [31:0]ps_7_M_AXI_GP0_AWADDR;
  wire [1:0]ps_7_M_AXI_GP0_AWBURST;
  wire [3:0]ps_7_M_AXI_GP0_AWCACHE;
  wire [11:0]ps_7_M_AXI_GP0_AWID;
  wire [3:0]ps_7_M_AXI_GP0_AWLEN;
  wire [1:0]ps_7_M_AXI_GP0_AWLOCK;
  wire [2:0]ps_7_M_AXI_GP0_AWPROT;
  wire [3:0]ps_7_M_AXI_GP0_AWQOS;
  wire ps_7_M_AXI_GP0_AWREADY;
  wire [2:0]ps_7_M_AXI_GP0_AWSIZE;
  wire ps_7_M_AXI_GP0_AWVALID;
  wire [11:0]ps_7_M_AXI_GP0_BID;
  wire ps_7_M_AXI_GP0_BREADY;
  wire [1:0]ps_7_M_AXI_GP0_BRESP;
  wire ps_7_M_AXI_GP0_BVALID;
  wire [31:0]ps_7_M_AXI_GP0_RDATA;
  wire [11:0]ps_7_M_AXI_GP0_RID;
  wire ps_7_M_AXI_GP0_RLAST;
  wire ps_7_M_AXI_GP0_RREADY;
  wire [1:0]ps_7_M_AXI_GP0_RRESP;
  wire ps_7_M_AXI_GP0_RVALID;
  wire [31:0]ps_7_M_AXI_GP0_WDATA;
  wire [11:0]ps_7_M_AXI_GP0_WID;
  wire ps_7_M_AXI_GP0_WLAST;
  wire ps_7_M_AXI_GP0_WREADY;
  wire [3:0]ps_7_M_AXI_GP0_WSTRB;
  wire ps_7_M_AXI_GP0_WVALID;
  wire ps_7_SPI0_MOSI_O;
  wire ps_7_SPI0_SCLK_O;
  wire ps_7_SPI0_SS_O;
  wire [0:0]rst_ps_7_50M_peripheral_aresetn;
  wire rx_clk_in_n_0_1;
  wire rx_clk_in_p_0_1;
  wire [5:0]rx_data_in_n_0_1;
  wire [5:0]rx_data_in_p_0_1;
  wire rx_frame_in_n_0_1;
  wire rx_frame_in_p_0_1;
  wire [31:0]smartconnect_0_M00_AXI_AWADDR;
  wire [1:0]smartconnect_0_M00_AXI_AWBURST;
  wire [3:0]smartconnect_0_M00_AXI_AWCACHE;
  wire [3:0]smartconnect_0_M00_AXI_AWLEN;
  wire [1:0]smartconnect_0_M00_AXI_AWLOCK;
  wire [2:0]smartconnect_0_M00_AXI_AWPROT;
  wire [3:0]smartconnect_0_M00_AXI_AWQOS;
  wire smartconnect_0_M00_AXI_AWREADY;
  wire [2:0]smartconnect_0_M00_AXI_AWSIZE;
  wire smartconnect_0_M00_AXI_AWVALID;
  wire smartconnect_0_M00_AXI_BREADY;
  wire [1:0]smartconnect_0_M00_AXI_BRESP;
  wire smartconnect_0_M00_AXI_BVALID;
  wire [63:0]smartconnect_0_M00_AXI_WDATA;
  wire smartconnect_0_M00_AXI_WLAST;
  wire smartconnect_0_M00_AXI_WREADY;
  wire [7:0]smartconnect_0_M00_AXI_WSTRB;
  wire smartconnect_0_M00_AXI_WVALID;
  wire [15:0]util_wfifo_0_dout_data_0;
  wire [15:0]util_wfifo_0_dout_data_1;
  wire [15:0]util_wfifo_0_dout_data_2;
  wire [15:0]util_wfifo_0_dout_data_3;
  wire util_wfifo_0_dout_valid_0;
  wire [15:0]xlslice_0_Dout;
  wire [15:0]xlslice_1_Dout;
  wire [15:0]xlslice_2_Dout;
  wire [15:0]xlslice_3_Dout;

  assign SPI0_MISO_I_0_1 = SPI0_MISO_I_0;
  assign SPI0_MOSI_O_0 = ps_7_SPI0_MOSI_O;
  assign SPI0_SCLK_O_0 = ps_7_SPI0_SCLK_O;
  assign SPI0_SS_O_0 = ps_7_SPI0_SS_O;
  assign enable_0 = axi_ad9361_0_enable;
  assign gpio_clksel_0 = ad9361_io_manager_0_gpio_clksel;
  assign gpio_ctl_0[3:0] = ad9361_io_manager_0_gpio_ctl;
  assign gpio_en_agc_0 = ad9361_io_manager_0_gpio_en_agc;
  assign gpio_resetb_0 = ad9361_io_manager_0_gpio_resetb;
  assign gpio_status_0_1 = gpio_status_0[7:0];
  assign gpio_sync_0 = ad9361_io_manager_0_gpio_sync;
  assign rx_clk_in_n_0_1 = rx_clk_in_n_0;
  assign rx_clk_in_p_0_1 = rx_clk_in_p_0;
  assign rx_data_in_n_0_1 = rx_data_in_n_0[5:0];
  assign rx_data_in_p_0_1 = rx_data_in_p_0[5:0];
  assign rx_frame_in_n_0_1 = rx_frame_in_n_0;
  assign rx_frame_in_p_0_1 = rx_frame_in_p_0;
  assign tx_clk_out_n_0 = axi_ad9361_0_tx_clk_out_n;
  assign tx_clk_out_p_0 = axi_ad9361_0_tx_clk_out_p;
  assign tx_data_out_n_0[5:0] = axi_ad9361_0_tx_data_out_n;
  assign tx_data_out_p_0[5:0] = axi_ad9361_0_tx_data_out_p;
  assign tx_frame_out_n_0 = axi_ad9361_0_tx_frame_out_n;
  assign tx_frame_out_p_0 = axi_ad9361_0_tx_frame_out_p;
  assign txnrx_0 = axi_ad9361_0_txnrx;
  IP_AnalogDevices_imp_18BZYJW IP_AnalogDevices
       (.adc_r1_mode(IP_AnalogDevices_adc_r1_mode),
        .clk(axi_ad9361_0_l_clk),
        .dac_r1_mode(IP_AnalogDevices_dac_r1_mode),
        .delay_clk(ps_7_FCLK_CLK1),
        .din_data_0(xlslice_0_Dout),
        .din_data_1(xlslice_1_Dout),
        .din_data_2(xlslice_3_Dout),
        .din_data_3(xlslice_2_Dout),
        .din_valid_in_1(cordic_0_m_axis_dout_tvalid),
        .din_valid_in_3(cordic_1_m_axis_dout_tvalid),
        .dout_clk(Net),
        .dout_data_0(util_wfifo_0_dout_data_0),
        .dout_data_1(util_wfifo_0_dout_data_1),
        .dout_data_2(util_wfifo_0_dout_data_2),
        .dout_data_3(util_wfifo_0_dout_data_3),
        .dout_rstn(proc_sys_reset_0_peripheral_aresetn),
        .dout_valid_0(util_wfifo_0_dout_valid_0),
        .enable_0(axi_ad9361_0_enable),
        .rx_clk_in_n_0(rx_clk_in_n_0_1),
        .rx_clk_in_p_0(rx_clk_in_p_0_1),
        .rx_data_in_n_0(rx_data_in_n_0_1),
        .rx_data_in_p_0(rx_data_in_p_0_1),
        .rx_frame_in_n_0(rx_frame_in_n_0_1),
        .rx_frame_in_p_0(rx_frame_in_p_0_1),
        .s_axi_aclk(F_clk0),
        .s_axi_araddr(axi_smc_M01_AXI_ARADDR),
        .s_axi_aresetn(rst_ps_7_50M_peripheral_aresetn),
        .s_axi_arprot(axi_smc_M01_AXI_ARPROT),
        .s_axi_arready(axi_smc_M01_AXI_ARREADY),
        .s_axi_arvalid(axi_smc_M01_AXI_ARVALID),
        .s_axi_awaddr(axi_smc_M01_AXI_AWADDR),
        .s_axi_awprot(axi_smc_M01_AXI_AWPROT),
        .s_axi_awready(axi_smc_M01_AXI_AWREADY),
        .s_axi_awvalid(axi_smc_M01_AXI_AWVALID),
        .s_axi_bready(axi_smc_M01_AXI_BREADY),
        .s_axi_bresp(axi_smc_M01_AXI_BRESP),
        .s_axi_bvalid(axi_smc_M01_AXI_BVALID),
        .s_axi_rdata(axi_smc_M01_AXI_RDATA),
        .s_axi_rready(axi_smc_M01_AXI_RREADY),
        .s_axi_rresp(axi_smc_M01_AXI_RRESP),
        .s_axi_rvalid(axi_smc_M01_AXI_RVALID),
        .s_axi_wdata(axi_smc_M01_AXI_WDATA),
        .s_axi_wready(axi_smc_M01_AXI_WREADY),
        .s_axi_wstrb(axi_smc_M01_AXI_WSTRB),
        .s_axi_wvalid(axi_smc_M01_AXI_WVALID),
        .tx_clk_out_n_0(axi_ad9361_0_tx_clk_out_n),
        .tx_clk_out_p_0(axi_ad9361_0_tx_clk_out_p),
        .tx_data_out_n_0(axi_ad9361_0_tx_data_out_n),
        .tx_data_out_p_0(axi_ad9361_0_tx_data_out_p),
        .tx_frame_out_n_0(axi_ad9361_0_tx_frame_out_n),
        .tx_frame_out_p_0(axi_ad9361_0_tx_frame_out_p),
        .txnrx_0(axi_ad9361_0_txnrx),
        .up_enable(ad9361_io_manager_0_up_enable),
        .up_txnrx(ad9361_io_manager_0_up_txnrx));
  IP_PS_imp_CQ0787 IP_PS
       (.DDR_0_addr(DDR_0_addr[14:0]),
        .DDR_0_ba(DDR_0_ba[2:0]),
        .DDR_0_cas_n(DDR_0_cas_n),
        .DDR_0_ck_n(DDR_0_ck_n),
        .DDR_0_ck_p(DDR_0_ck_p),
        .DDR_0_cke(DDR_0_cke),
        .DDR_0_cs_n(DDR_0_cs_n),
        .DDR_0_dm(DDR_0_dm[3:0]),
        .DDR_0_dq(DDR_0_dq[31:0]),
        .DDR_0_dqs_n(DDR_0_dqs_n[3:0]),
        .DDR_0_dqs_p(DDR_0_dqs_p[3:0]),
        .DDR_0_odt(DDR_0_odt),
        .DDR_0_ras_n(DDR_0_ras_n),
        .DDR_0_reset_n(DDR_0_reset_n),
        .DDR_0_we_n(DDR_0_we_n),
        .FCLK_CLK0(F_clk0),
        .FCLK_CLK1(ps_7_FCLK_CLK1),
        .FCLK_RESET0_N(ps_7_FCLK_RESET0_N),
        .FIXED_IO_0_ddr_vrn(FIXED_IO_0_ddr_vrn),
        .FIXED_IO_0_ddr_vrp(FIXED_IO_0_ddr_vrp),
        .FIXED_IO_0_mio(FIXED_IO_0_mio[53:0]),
        .FIXED_IO_0_ps_clk(FIXED_IO_0_ps_clk),
        .FIXED_IO_0_ps_porb(FIXED_IO_0_ps_porb),
        .FIXED_IO_0_ps_srstb(FIXED_IO_0_ps_srstb),
        .GPIO_0_tri_i(ps_7_GPIO_0_TRI_I),
        .GPIO_0_tri_o(ps_7_GPIO_0_TRI_O),
        .GPIO_0_tri_t(ps_7_GPIO_0_TRI_T),
        .In0(axi_dma_0_s2mm_introut),
        .M_AXI_GP0_araddr(ps_7_M_AXI_GP0_ARADDR),
        .M_AXI_GP0_arburst(ps_7_M_AXI_GP0_ARBURST),
        .M_AXI_GP0_arcache(ps_7_M_AXI_GP0_ARCACHE),
        .M_AXI_GP0_arid(ps_7_M_AXI_GP0_ARID),
        .M_AXI_GP0_arlen(ps_7_M_AXI_GP0_ARLEN),
        .M_AXI_GP0_arlock(ps_7_M_AXI_GP0_ARLOCK),
        .M_AXI_GP0_arprot(ps_7_M_AXI_GP0_ARPROT),
        .M_AXI_GP0_arqos(ps_7_M_AXI_GP0_ARQOS),
        .M_AXI_GP0_arready(ps_7_M_AXI_GP0_ARREADY),
        .M_AXI_GP0_arsize(ps_7_M_AXI_GP0_ARSIZE),
        .M_AXI_GP0_arvalid(ps_7_M_AXI_GP0_ARVALID),
        .M_AXI_GP0_awaddr(ps_7_M_AXI_GP0_AWADDR),
        .M_AXI_GP0_awburst(ps_7_M_AXI_GP0_AWBURST),
        .M_AXI_GP0_awcache(ps_7_M_AXI_GP0_AWCACHE),
        .M_AXI_GP0_awid(ps_7_M_AXI_GP0_AWID),
        .M_AXI_GP0_awlen(ps_7_M_AXI_GP0_AWLEN),
        .M_AXI_GP0_awlock(ps_7_M_AXI_GP0_AWLOCK),
        .M_AXI_GP0_awprot(ps_7_M_AXI_GP0_AWPROT),
        .M_AXI_GP0_awqos(ps_7_M_AXI_GP0_AWQOS),
        .M_AXI_GP0_awready(ps_7_M_AXI_GP0_AWREADY),
        .M_AXI_GP0_awsize(ps_7_M_AXI_GP0_AWSIZE),
        .M_AXI_GP0_awvalid(ps_7_M_AXI_GP0_AWVALID),
        .M_AXI_GP0_bid(ps_7_M_AXI_GP0_BID),
        .M_AXI_GP0_bready(ps_7_M_AXI_GP0_BREADY),
        .M_AXI_GP0_bresp(ps_7_M_AXI_GP0_BRESP),
        .M_AXI_GP0_bvalid(ps_7_M_AXI_GP0_BVALID),
        .M_AXI_GP0_rdata(ps_7_M_AXI_GP0_RDATA),
        .M_AXI_GP0_rid(ps_7_M_AXI_GP0_RID),
        .M_AXI_GP0_rlast(ps_7_M_AXI_GP0_RLAST),
        .M_AXI_GP0_rready(ps_7_M_AXI_GP0_RREADY),
        .M_AXI_GP0_rresp(ps_7_M_AXI_GP0_RRESP),
        .M_AXI_GP0_rvalid(ps_7_M_AXI_GP0_RVALID),
        .M_AXI_GP0_wdata(ps_7_M_AXI_GP0_WDATA),
        .M_AXI_GP0_wid(ps_7_M_AXI_GP0_WID),
        .M_AXI_GP0_wlast(ps_7_M_AXI_GP0_WLAST),
        .M_AXI_GP0_wready(ps_7_M_AXI_GP0_WREADY),
        .M_AXI_GP0_wstrb(ps_7_M_AXI_GP0_WSTRB),
        .M_AXI_GP0_wvalid(ps_7_M_AXI_GP0_WVALID),
        .SPI0_MISO_I_0(SPI0_MISO_I_0_1),
        .SPI0_MOSI_O_0(ps_7_SPI0_MOSI_O),
        .SPI0_SCLK_O_0(ps_7_SPI0_SCLK_O),
        .SPI0_SS_O_0(ps_7_SPI0_SS_O),
        .S_AXI_HP0_ACLK(F_clk0),
        .S_AXI_HP0_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .S_AXI_HP0_awburst(smartconnect_0_M00_AXI_AWBURST),
        .S_AXI_HP0_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .S_AXI_HP0_awlen(smartconnect_0_M00_AXI_AWLEN),
        .S_AXI_HP0_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .S_AXI_HP0_awprot(smartconnect_0_M00_AXI_AWPROT),
        .S_AXI_HP0_awqos(smartconnect_0_M00_AXI_AWQOS),
        .S_AXI_HP0_awready(smartconnect_0_M00_AXI_AWREADY),
        .S_AXI_HP0_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .S_AXI_HP0_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .S_AXI_HP0_bready(smartconnect_0_M00_AXI_BREADY),
        .S_AXI_HP0_bresp(smartconnect_0_M00_AXI_BRESP),
        .S_AXI_HP0_bvalid(smartconnect_0_M00_AXI_BVALID),
        .S_AXI_HP0_wdata(smartconnect_0_M00_AXI_WDATA),
        .S_AXI_HP0_wlast(smartconnect_0_M00_AXI_WLAST),
        .S_AXI_HP0_wready(smartconnect_0_M00_AXI_WREADY),
        .S_AXI_HP0_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .S_AXI_HP0_wvalid(smartconnect_0_M00_AXI_WVALID));
  Rx_TestBench_imp_YJJKUH Rx_TestBench
       (.M_AXI_S2MM_awaddr(axi_dma_0_M_AXI_S2MM_AWADDR),
        .M_AXI_S2MM_awburst(axi_dma_0_M_AXI_S2MM_AWBURST),
        .M_AXI_S2MM_awcache(axi_dma_0_M_AXI_S2MM_AWCACHE),
        .M_AXI_S2MM_awlen(axi_dma_0_M_AXI_S2MM_AWLEN),
        .M_AXI_S2MM_awprot(axi_dma_0_M_AXI_S2MM_AWPROT),
        .M_AXI_S2MM_awready(axi_dma_0_M_AXI_S2MM_AWREADY),
        .M_AXI_S2MM_awsize(axi_dma_0_M_AXI_S2MM_AWSIZE),
        .M_AXI_S2MM_awvalid(axi_dma_0_M_AXI_S2MM_AWVALID),
        .M_AXI_S2MM_bready(axi_dma_0_M_AXI_S2MM_BREADY),
        .M_AXI_S2MM_bresp(axi_dma_0_M_AXI_S2MM_BRESP),
        .M_AXI_S2MM_bvalid(axi_dma_0_M_AXI_S2MM_BVALID),
        .M_AXI_S2MM_wdata(axi_dma_0_M_AXI_S2MM_WDATA),
        .M_AXI_S2MM_wlast(axi_dma_0_M_AXI_S2MM_WLAST),
        .M_AXI_S2MM_wready(axi_dma_0_M_AXI_S2MM_WREADY),
        .M_AXI_S2MM_wstrb(axi_dma_0_M_AXI_S2MM_WSTRB),
        .M_AXI_S2MM_wvalid(axi_dma_0_M_AXI_S2MM_WVALID),
        .S_AXI_LITE_araddr(axi_smc_M00_AXI_ARADDR),
        .S_AXI_LITE_arready(axi_smc_M00_AXI_ARREADY),
        .S_AXI_LITE_arvalid(axi_smc_M00_AXI_ARVALID),
        .S_AXI_LITE_awaddr(axi_smc_M00_AXI_AWADDR),
        .S_AXI_LITE_awready(axi_smc_M00_AXI_AWREADY),
        .S_AXI_LITE_awvalid(axi_smc_M00_AXI_AWVALID),
        .S_AXI_LITE_bready(axi_smc_M00_AXI_BREADY),
        .S_AXI_LITE_bresp(axi_smc_M00_AXI_BRESP),
        .S_AXI_LITE_bvalid(axi_smc_M00_AXI_BVALID),
        .S_AXI_LITE_rdata(axi_smc_M00_AXI_RDATA),
        .S_AXI_LITE_rready(axi_smc_M00_AXI_RREADY),
        .S_AXI_LITE_rresp(axi_smc_M00_AXI_RRESP),
        .S_AXI_LITE_rvalid(axi_smc_M00_AXI_RVALID),
        .S_AXI_LITE_wdata(axi_smc_M00_AXI_WDATA),
        .S_AXI_LITE_wready(axi_smc_M00_AXI_WREADY),
        .S_AXI_LITE_wvalid(axi_smc_M00_AXI_WVALID),
        .axi_resetn(rst_ps_7_50M_peripheral_aresetn),
        .iq_ch0_i(util_wfifo_0_dout_data_0),
        .iq_ch0_q(util_wfifo_0_dout_data_1),
        .iq_ch1_i(util_wfifo_0_dout_data_2),
        .iq_ch1_q(util_wfifo_0_dout_data_3),
        .resetn(proc_sys_reset_0_peripheral_aresetn),
        .rx_valid(util_wfifo_0_dout_valid_0),
        .s2mm_introut(axi_dma_0_s2mm_introut),
        .s_axi_lite_aclk(F_clk0),
        .s_axis_aclk(Net),
        .s_axis_aresetn(proc_sys_reset_0_interconnect_aresetn));
  Tx_TestBench_imp_41GIBT Tx_TestBench
       (.Dout(xlslice_0_Dout),
        .Dout1(xlslice_1_Dout),
        .Dout2(xlslice_2_Dout),
        .Dout3(xlslice_3_Dout),
        .aclk(Net),
        .m_axis_dout_tvalid(cordic_0_m_axis_dout_tvalid),
        .m_axis_dout_tvalid1(cordic_1_m_axis_dout_tvalid));
  system_top_ad9361_io_manager_0_0 ad9361_io_manager_0
       (.gpio_clksel(ad9361_io_manager_0_gpio_clksel),
        .gpio_ctl(ad9361_io_manager_0_gpio_ctl),
        .gpio_en_agc(ad9361_io_manager_0_gpio_en_agc),
        .gpio_resetb(ad9361_io_manager_0_gpio_resetb),
        .gpio_status(gpio_status_0_1),
        .gpio_sync(ad9361_io_manager_0_gpio_sync),
        .ps_gpio_i(ps_7_GPIO_0_TRI_I),
        .ps_gpio_o(ps_7_GPIO_0_TRI_O),
        .ps_gpio_t(ps_7_GPIO_0_TRI_T),
        .up_enable(ad9361_io_manager_0_up_enable),
        .up_txnrx(ad9361_io_manager_0_up_txnrx));
  system_top_axi_smc_0 axi_smc
       (.M00_AXI_araddr(axi_smc_M00_AXI_ARADDR),
        .M00_AXI_arready(axi_smc_M00_AXI_ARREADY),
        .M00_AXI_arvalid(axi_smc_M00_AXI_ARVALID),
        .M00_AXI_awaddr(axi_smc_M00_AXI_AWADDR),
        .M00_AXI_awready(axi_smc_M00_AXI_AWREADY),
        .M00_AXI_awvalid(axi_smc_M00_AXI_AWVALID),
        .M00_AXI_bready(axi_smc_M00_AXI_BREADY),
        .M00_AXI_bresp(axi_smc_M00_AXI_BRESP),
        .M00_AXI_bvalid(axi_smc_M00_AXI_BVALID),
        .M00_AXI_rdata(axi_smc_M00_AXI_RDATA),
        .M00_AXI_rready(axi_smc_M00_AXI_RREADY),
        .M00_AXI_rresp(axi_smc_M00_AXI_RRESP),
        .M00_AXI_rvalid(axi_smc_M00_AXI_RVALID),
        .M00_AXI_wdata(axi_smc_M00_AXI_WDATA),
        .M00_AXI_wready(axi_smc_M00_AXI_WREADY),
        .M00_AXI_wvalid(axi_smc_M00_AXI_WVALID),
        .M01_AXI_araddr(axi_smc_M01_AXI_ARADDR),
        .M01_AXI_arprot(axi_smc_M01_AXI_ARPROT),
        .M01_AXI_arready(axi_smc_M01_AXI_ARREADY),
        .M01_AXI_arvalid(axi_smc_M01_AXI_ARVALID),
        .M01_AXI_awaddr(axi_smc_M01_AXI_AWADDR),
        .M01_AXI_awprot(axi_smc_M01_AXI_AWPROT),
        .M01_AXI_awready(axi_smc_M01_AXI_AWREADY),
        .M01_AXI_awvalid(axi_smc_M01_AXI_AWVALID),
        .M01_AXI_bready(axi_smc_M01_AXI_BREADY),
        .M01_AXI_bresp(axi_smc_M01_AXI_BRESP),
        .M01_AXI_bvalid(axi_smc_M01_AXI_BVALID),
        .M01_AXI_rdata(axi_smc_M01_AXI_RDATA),
        .M01_AXI_rready(axi_smc_M01_AXI_RREADY),
        .M01_AXI_rresp(axi_smc_M01_AXI_RRESP),
        .M01_AXI_rvalid(axi_smc_M01_AXI_RVALID),
        .M01_AXI_wdata(axi_smc_M01_AXI_WDATA),
        .M01_AXI_wready(axi_smc_M01_AXI_WREADY),
        .M01_AXI_wstrb(axi_smc_M01_AXI_WSTRB),
        .M01_AXI_wvalid(axi_smc_M01_AXI_WVALID),
        .S00_AXI_araddr(ps_7_M_AXI_GP0_ARADDR),
        .S00_AXI_arburst(ps_7_M_AXI_GP0_ARBURST),
        .S00_AXI_arcache(ps_7_M_AXI_GP0_ARCACHE),
        .S00_AXI_arid(ps_7_M_AXI_GP0_ARID),
        .S00_AXI_arlen(ps_7_M_AXI_GP0_ARLEN),
        .S00_AXI_arlock(ps_7_M_AXI_GP0_ARLOCK),
        .S00_AXI_arprot(ps_7_M_AXI_GP0_ARPROT),
        .S00_AXI_arqos(ps_7_M_AXI_GP0_ARQOS),
        .S00_AXI_arready(ps_7_M_AXI_GP0_ARREADY),
        .S00_AXI_arsize(ps_7_M_AXI_GP0_ARSIZE),
        .S00_AXI_arvalid(ps_7_M_AXI_GP0_ARVALID),
        .S00_AXI_awaddr(ps_7_M_AXI_GP0_AWADDR),
        .S00_AXI_awburst(ps_7_M_AXI_GP0_AWBURST),
        .S00_AXI_awcache(ps_7_M_AXI_GP0_AWCACHE),
        .S00_AXI_awid(ps_7_M_AXI_GP0_AWID),
        .S00_AXI_awlen(ps_7_M_AXI_GP0_AWLEN),
        .S00_AXI_awlock(ps_7_M_AXI_GP0_AWLOCK),
        .S00_AXI_awprot(ps_7_M_AXI_GP0_AWPROT),
        .S00_AXI_awqos(ps_7_M_AXI_GP0_AWQOS),
        .S00_AXI_awready(ps_7_M_AXI_GP0_AWREADY),
        .S00_AXI_awsize(ps_7_M_AXI_GP0_AWSIZE),
        .S00_AXI_awvalid(ps_7_M_AXI_GP0_AWVALID),
        .S00_AXI_bid(ps_7_M_AXI_GP0_BID),
        .S00_AXI_bready(ps_7_M_AXI_GP0_BREADY),
        .S00_AXI_bresp(ps_7_M_AXI_GP0_BRESP),
        .S00_AXI_bvalid(ps_7_M_AXI_GP0_BVALID),
        .S00_AXI_rdata(ps_7_M_AXI_GP0_RDATA),
        .S00_AXI_rid(ps_7_M_AXI_GP0_RID),
        .S00_AXI_rlast(ps_7_M_AXI_GP0_RLAST),
        .S00_AXI_rready(ps_7_M_AXI_GP0_RREADY),
        .S00_AXI_rresp(ps_7_M_AXI_GP0_RRESP),
        .S00_AXI_rvalid(ps_7_M_AXI_GP0_RVALID),
        .S00_AXI_wdata(ps_7_M_AXI_GP0_WDATA),
        .S00_AXI_wid(ps_7_M_AXI_GP0_WID),
        .S00_AXI_wlast(ps_7_M_AXI_GP0_WLAST),
        .S00_AXI_wready(ps_7_M_AXI_GP0_WREADY),
        .S00_AXI_wstrb(ps_7_M_AXI_GP0_WSTRB),
        .S00_AXI_wvalid(ps_7_M_AXI_GP0_WVALID),
        .aclk(F_clk0),
        .aresetn(rst_ps_7_50M_peripheral_aresetn));
  system_top_clock_divider_0_0 clock_divider_0
       (.a_r1(IP_AnalogDevices_adc_r1_mode),
        .clk_in(axi_ad9361_0_l_clk),
        .clk_out(Net),
        .d_r1(IP_AnalogDevices_dac_r1_mode));
  system_top_rst_ad9361_0 rst_ad9361
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(rst_ps_7_50M_peripheral_aresetn),
        .interconnect_aresetn(proc_sys_reset_0_interconnect_aresetn),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(proc_sys_reset_0_peripheral_aresetn),
        .slowest_sync_clk(Net));
  system_top_rst_ps_100M_0 rst_ps_100M
       (.aux_reset_in(1'b1),
        .dcm_locked(1'b1),
        .ext_reset_in(ps_7_FCLK_RESET0_N),
        .mb_debug_sys_rst(1'b0),
        .peripheral_aresetn(rst_ps_7_50M_peripheral_aresetn),
        .slowest_sync_clk(F_clk0));
  system_top_smartconnect_0_0 smartconnect_0
       (.M00_AXI_awaddr(smartconnect_0_M00_AXI_AWADDR),
        .M00_AXI_awburst(smartconnect_0_M00_AXI_AWBURST),
        .M00_AXI_awcache(smartconnect_0_M00_AXI_AWCACHE),
        .M00_AXI_awlen(smartconnect_0_M00_AXI_AWLEN),
        .M00_AXI_awlock(smartconnect_0_M00_AXI_AWLOCK),
        .M00_AXI_awprot(smartconnect_0_M00_AXI_AWPROT),
        .M00_AXI_awqos(smartconnect_0_M00_AXI_AWQOS),
        .M00_AXI_awready(smartconnect_0_M00_AXI_AWREADY),
        .M00_AXI_awsize(smartconnect_0_M00_AXI_AWSIZE),
        .M00_AXI_awvalid(smartconnect_0_M00_AXI_AWVALID),
        .M00_AXI_bready(smartconnect_0_M00_AXI_BREADY),
        .M00_AXI_bresp(smartconnect_0_M00_AXI_BRESP),
        .M00_AXI_bvalid(smartconnect_0_M00_AXI_BVALID),
        .M00_AXI_wdata(smartconnect_0_M00_AXI_WDATA),
        .M00_AXI_wlast(smartconnect_0_M00_AXI_WLAST),
        .M00_AXI_wready(smartconnect_0_M00_AXI_WREADY),
        .M00_AXI_wstrb(smartconnect_0_M00_AXI_WSTRB),
        .M00_AXI_wvalid(smartconnect_0_M00_AXI_WVALID),
        .S00_AXI_awaddr(axi_dma_0_M_AXI_S2MM_AWADDR),
        .S00_AXI_awburst(axi_dma_0_M_AXI_S2MM_AWBURST),
        .S00_AXI_awcache(axi_dma_0_M_AXI_S2MM_AWCACHE),
        .S00_AXI_awlen(axi_dma_0_M_AXI_S2MM_AWLEN),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot(axi_dma_0_M_AXI_S2MM_AWPROT),
        .S00_AXI_awqos({1'b0,1'b0,1'b0,1'b0}),
        .S00_AXI_awready(axi_dma_0_M_AXI_S2MM_AWREADY),
        .S00_AXI_awsize(axi_dma_0_M_AXI_S2MM_AWSIZE),
        .S00_AXI_awvalid(axi_dma_0_M_AXI_S2MM_AWVALID),
        .S00_AXI_bready(axi_dma_0_M_AXI_S2MM_BREADY),
        .S00_AXI_bresp(axi_dma_0_M_AXI_S2MM_BRESP),
        .S00_AXI_bvalid(axi_dma_0_M_AXI_S2MM_BVALID),
        .S00_AXI_wdata(axi_dma_0_M_AXI_S2MM_WDATA),
        .S00_AXI_wlast(axi_dma_0_M_AXI_S2MM_WLAST),
        .S00_AXI_wready(axi_dma_0_M_AXI_S2MM_WREADY),
        .S00_AXI_wstrb(axi_dma_0_M_AXI_S2MM_WSTRB),
        .S00_AXI_wvalid(axi_dma_0_M_AXI_S2MM_WVALID),
        .aclk(F_clk0),
        .aresetn(rst_ps_7_50M_peripheral_aresetn));
endmodule
