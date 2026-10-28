// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:46:04 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_tlast_generator_0_0_sim_netlist.v
// Design      : system_top_tlast_generator_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_top_tlast_generator_0_0,tlast_generator,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "tlast_generator,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clk,
    resetn,
    iq_ch0_i,
    iq_ch0_q,
    iq_ch1_i,
    iq_ch1_q,
    rx_valid,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tlast,
    m_axis_tready,
    sample_counter);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis, ASSOCIATED_RESET resetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 resetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input resetn;
  input [15:0]iq_ch0_i;
  input [15:0]iq_ch0_q;
  input [15:0]iq_ch1_i;
  input [15:0]iq_ch1_q;
  (* X_INTERFACE_INFO = "analog.com:interface:fifo_rd:1.0 rx VALID" *) input rx_valid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TDATA" *) output [63:0]m_axis_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TVALID" *) output m_axis_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TLAST" *) output m_axis_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME m_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0" *) input m_axis_tready;
  output [31:0]sample_counter;

  wire clk;
  wire [15:0]iq_ch0_i;
  wire [15:0]iq_ch0_q;
  wire [15:0]iq_ch1_i;
  wire [15:0]iq_ch1_q;
  wire m_axis_tlast;
  wire m_axis_tready;
  wire resetn;
  wire rx_valid;
  wire [31:0]sample_counter;

  assign m_axis_tdata[63:48] = iq_ch1_q;
  assign m_axis_tdata[47:32] = iq_ch1_i;
  assign m_axis_tdata[31:16] = iq_ch0_q;
  assign m_axis_tdata[15:0] = iq_ch0_i;
  assign m_axis_tvalid = rx_valid;
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tlast_generator inst
       (.clk(clk),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready),
        .resetn(resetn),
        .rx_valid(rx_valid),
        .sample_counter(sample_counter));
endmodule

module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_tlast_generator
   (sample_counter,
    m_axis_tlast,
    clk,
    resetn,
    rx_valid,
    m_axis_tready);
  output [31:0]sample_counter;
  output m_axis_tlast;
  input clk;
  input resetn;
  input rx_valid;
  input m_axis_tready;

  wire clk;
  wire [31:1]data0;
  wire m_axis_tlast;
  wire m_axis_tlast_INST_0_i_1_n_0;
  wire m_axis_tlast_INST_0_i_2_n_0;
  wire m_axis_tlast_INST_0_i_3_n_0;
  wire m_axis_tlast_INST_0_i_4_n_0;
  wire m_axis_tlast_INST_0_i_5_n_0;
  wire m_axis_tlast_INST_0_i_6_n_0;
  wire m_axis_tlast_INST_0_i_7_n_0;
  wire m_axis_tlast_INST_0_i_8_n_0;
  wire m_axis_tready;
  wire p_0_in;
  wire resetn;
  wire rx_valid;
  wire [31:0]sample_counter;
  wire \sample_counter[31]_i_2_n_0 ;
  wire [31:0]sample_counter_0;
  wire \sample_counter_reg[12]_i_2_n_0 ;
  wire \sample_counter_reg[12]_i_2_n_1 ;
  wire \sample_counter_reg[12]_i_2_n_2 ;
  wire \sample_counter_reg[12]_i_2_n_3 ;
  wire \sample_counter_reg[16]_i_2_n_0 ;
  wire \sample_counter_reg[16]_i_2_n_1 ;
  wire \sample_counter_reg[16]_i_2_n_2 ;
  wire \sample_counter_reg[16]_i_2_n_3 ;
  wire \sample_counter_reg[20]_i_2_n_0 ;
  wire \sample_counter_reg[20]_i_2_n_1 ;
  wire \sample_counter_reg[20]_i_2_n_2 ;
  wire \sample_counter_reg[20]_i_2_n_3 ;
  wire \sample_counter_reg[24]_i_2_n_0 ;
  wire \sample_counter_reg[24]_i_2_n_1 ;
  wire \sample_counter_reg[24]_i_2_n_2 ;
  wire \sample_counter_reg[24]_i_2_n_3 ;
  wire \sample_counter_reg[28]_i_2_n_0 ;
  wire \sample_counter_reg[28]_i_2_n_1 ;
  wire \sample_counter_reg[28]_i_2_n_2 ;
  wire \sample_counter_reg[28]_i_2_n_3 ;
  wire \sample_counter_reg[31]_i_4_n_2 ;
  wire \sample_counter_reg[31]_i_4_n_3 ;
  wire \sample_counter_reg[4]_i_2_n_0 ;
  wire \sample_counter_reg[4]_i_2_n_1 ;
  wire \sample_counter_reg[4]_i_2_n_2 ;
  wire \sample_counter_reg[4]_i_2_n_3 ;
  wire \sample_counter_reg[8]_i_2_n_0 ;
  wire \sample_counter_reg[8]_i_2_n_1 ;
  wire \sample_counter_reg[8]_i_2_n_2 ;
  wire \sample_counter_reg[8]_i_2_n_3 ;
  wire [3:2]\NLW_sample_counter_reg[31]_i_4_CO_UNCONNECTED ;
  wire [3:3]\NLW_sample_counter_reg[31]_i_4_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0001)) 
    m_axis_tlast_INST_0
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .O(m_axis_tlast));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    m_axis_tlast_INST_0_i_1
       (.I0(sample_counter[18]),
        .I1(sample_counter[19]),
        .I2(sample_counter[16]),
        .I3(sample_counter[17]),
        .I4(m_axis_tlast_INST_0_i_5_n_0),
        .O(m_axis_tlast_INST_0_i_1_n_0));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    m_axis_tlast_INST_0_i_2
       (.I0(sample_counter[26]),
        .I1(sample_counter[27]),
        .I2(sample_counter[24]),
        .I3(sample_counter[25]),
        .I4(m_axis_tlast_INST_0_i_6_n_0),
        .O(m_axis_tlast_INST_0_i_2_n_0));
  LUT5 #(
    .INIT(32'hFFFF7FFF)) 
    m_axis_tlast_INST_0_i_3
       (.I0(sample_counter[2]),
        .I1(sample_counter[3]),
        .I2(sample_counter[0]),
        .I3(sample_counter[1]),
        .I4(m_axis_tlast_INST_0_i_7_n_0),
        .O(m_axis_tlast_INST_0_i_3_n_0));
  LUT5 #(
    .INIT(32'hFFFFEFFF)) 
    m_axis_tlast_INST_0_i_4
       (.I0(sample_counter[10]),
        .I1(sample_counter[11]),
        .I2(sample_counter[8]),
        .I3(sample_counter[9]),
        .I4(m_axis_tlast_INST_0_i_8_n_0),
        .O(m_axis_tlast_INST_0_i_4_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    m_axis_tlast_INST_0_i_5
       (.I0(sample_counter[21]),
        .I1(sample_counter[20]),
        .I2(sample_counter[23]),
        .I3(sample_counter[22]),
        .O(m_axis_tlast_INST_0_i_5_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    m_axis_tlast_INST_0_i_6
       (.I0(sample_counter[29]),
        .I1(sample_counter[28]),
        .I2(sample_counter[31]),
        .I3(sample_counter[30]),
        .O(m_axis_tlast_INST_0_i_6_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    m_axis_tlast_INST_0_i_7
       (.I0(sample_counter[5]),
        .I1(sample_counter[4]),
        .I2(sample_counter[7]),
        .I3(sample_counter[6]),
        .O(m_axis_tlast_INST_0_i_7_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    m_axis_tlast_INST_0_i_8
       (.I0(sample_counter[13]),
        .I1(sample_counter[12]),
        .I2(sample_counter[15]),
        .I3(sample_counter[14]),
        .O(m_axis_tlast_INST_0_i_8_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    \sample_counter[0]_i_1 
       (.I0(sample_counter[0]),
        .O(sample_counter_0[0]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[10]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[10]),
        .O(sample_counter_0[10]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[11]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[11]),
        .O(sample_counter_0[11]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[12]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[12]),
        .O(sample_counter_0[12]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[13]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[13]),
        .O(sample_counter_0[13]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[14]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[14]),
        .O(sample_counter_0[14]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[15]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[15]),
        .O(sample_counter_0[15]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[16]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[16]),
        .O(sample_counter_0[16]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[17]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[17]),
        .O(sample_counter_0[17]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[18]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[18]),
        .O(sample_counter_0[18]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[19]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[19]),
        .O(sample_counter_0[19]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[1]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[1]),
        .O(sample_counter_0[1]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[20]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[20]),
        .O(sample_counter_0[20]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[21]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[21]),
        .O(sample_counter_0[21]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[22]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[22]),
        .O(sample_counter_0[22]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[23]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[23]),
        .O(sample_counter_0[23]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[24]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[24]),
        .O(sample_counter_0[24]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[25]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[25]),
        .O(sample_counter_0[25]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[26]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[26]),
        .O(sample_counter_0[26]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[27]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[27]),
        .O(sample_counter_0[27]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[28]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[28]),
        .O(sample_counter_0[28]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[29]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[29]),
        .O(sample_counter_0[29]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[2]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[2]),
        .O(sample_counter_0[2]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[30]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[30]),
        .O(sample_counter_0[30]));
  LUT1 #(
    .INIT(2'h1)) 
    \sample_counter[31]_i_1 
       (.I0(resetn),
        .O(p_0_in));
  LUT2 #(
    .INIT(4'h8)) 
    \sample_counter[31]_i_2 
       (.I0(rx_valid),
        .I1(m_axis_tready),
        .O(\sample_counter[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[31]_i_3 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[31]),
        .O(sample_counter_0[31]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[3]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[3]),
        .O(sample_counter_0[3]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[4]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[4]),
        .O(sample_counter_0[4]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[5]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[5]),
        .O(sample_counter_0[5]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[6]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[6]),
        .O(sample_counter_0[6]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[7]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[7]),
        .O(sample_counter_0[7]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[8]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[8]),
        .O(sample_counter_0[8]));
  LUT5 #(
    .INIT(32'hFFFE0000)) 
    \sample_counter[9]_i_1 
       (.I0(m_axis_tlast_INST_0_i_1_n_0),
        .I1(m_axis_tlast_INST_0_i_2_n_0),
        .I2(m_axis_tlast_INST_0_i_3_n_0),
        .I3(m_axis_tlast_INST_0_i_4_n_0),
        .I4(data0[9]),
        .O(sample_counter_0[9]));
  FDRE \sample_counter_reg[0] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[0]),
        .Q(sample_counter[0]),
        .R(p_0_in));
  FDRE \sample_counter_reg[10] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[10]),
        .Q(sample_counter[10]),
        .R(p_0_in));
  FDRE \sample_counter_reg[11] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[11]),
        .Q(sample_counter[11]),
        .R(p_0_in));
  FDRE \sample_counter_reg[12] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[12]),
        .Q(sample_counter[12]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[12]_i_2 
       (.CI(\sample_counter_reg[8]_i_2_n_0 ),
        .CO({\sample_counter_reg[12]_i_2_n_0 ,\sample_counter_reg[12]_i_2_n_1 ,\sample_counter_reg[12]_i_2_n_2 ,\sample_counter_reg[12]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[12:9]),
        .S(sample_counter[12:9]));
  FDRE \sample_counter_reg[13] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[13]),
        .Q(sample_counter[13]),
        .R(p_0_in));
  FDRE \sample_counter_reg[14] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[14]),
        .Q(sample_counter[14]),
        .R(p_0_in));
  FDRE \sample_counter_reg[15] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[15]),
        .Q(sample_counter[15]),
        .R(p_0_in));
  FDRE \sample_counter_reg[16] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[16]),
        .Q(sample_counter[16]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[16]_i_2 
       (.CI(\sample_counter_reg[12]_i_2_n_0 ),
        .CO({\sample_counter_reg[16]_i_2_n_0 ,\sample_counter_reg[16]_i_2_n_1 ,\sample_counter_reg[16]_i_2_n_2 ,\sample_counter_reg[16]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:13]),
        .S(sample_counter[16:13]));
  FDRE \sample_counter_reg[17] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[17]),
        .Q(sample_counter[17]),
        .R(p_0_in));
  FDRE \sample_counter_reg[18] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[18]),
        .Q(sample_counter[18]),
        .R(p_0_in));
  FDRE \sample_counter_reg[19] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[19]),
        .Q(sample_counter[19]),
        .R(p_0_in));
  FDRE \sample_counter_reg[1] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[1]),
        .Q(sample_counter[1]),
        .R(p_0_in));
  FDRE \sample_counter_reg[20] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[20]),
        .Q(sample_counter[20]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[20]_i_2 
       (.CI(\sample_counter_reg[16]_i_2_n_0 ),
        .CO({\sample_counter_reg[20]_i_2_n_0 ,\sample_counter_reg[20]_i_2_n_1 ,\sample_counter_reg[20]_i_2_n_2 ,\sample_counter_reg[20]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[20:17]),
        .S(sample_counter[20:17]));
  FDRE \sample_counter_reg[21] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[21]),
        .Q(sample_counter[21]),
        .R(p_0_in));
  FDRE \sample_counter_reg[22] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[22]),
        .Q(sample_counter[22]),
        .R(p_0_in));
  FDRE \sample_counter_reg[23] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[23]),
        .Q(sample_counter[23]),
        .R(p_0_in));
  FDRE \sample_counter_reg[24] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[24]),
        .Q(sample_counter[24]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[24]_i_2 
       (.CI(\sample_counter_reg[20]_i_2_n_0 ),
        .CO({\sample_counter_reg[24]_i_2_n_0 ,\sample_counter_reg[24]_i_2_n_1 ,\sample_counter_reg[24]_i_2_n_2 ,\sample_counter_reg[24]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[24:21]),
        .S(sample_counter[24:21]));
  FDRE \sample_counter_reg[25] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[25]),
        .Q(sample_counter[25]),
        .R(p_0_in));
  FDRE \sample_counter_reg[26] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[26]),
        .Q(sample_counter[26]),
        .R(p_0_in));
  FDRE \sample_counter_reg[27] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[27]),
        .Q(sample_counter[27]),
        .R(p_0_in));
  FDRE \sample_counter_reg[28] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[28]),
        .Q(sample_counter[28]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[28]_i_2 
       (.CI(\sample_counter_reg[24]_i_2_n_0 ),
        .CO({\sample_counter_reg[28]_i_2_n_0 ,\sample_counter_reg[28]_i_2_n_1 ,\sample_counter_reg[28]_i_2_n_2 ,\sample_counter_reg[28]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[28:25]),
        .S(sample_counter[28:25]));
  FDRE \sample_counter_reg[29] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[29]),
        .Q(sample_counter[29]),
        .R(p_0_in));
  FDRE \sample_counter_reg[2] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[2]),
        .Q(sample_counter[2]),
        .R(p_0_in));
  FDRE \sample_counter_reg[30] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[30]),
        .Q(sample_counter[30]),
        .R(p_0_in));
  FDRE \sample_counter_reg[31] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[31]),
        .Q(sample_counter[31]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[31]_i_4 
       (.CI(\sample_counter_reg[28]_i_2_n_0 ),
        .CO({\NLW_sample_counter_reg[31]_i_4_CO_UNCONNECTED [3:2],\sample_counter_reg[31]_i_4_n_2 ,\sample_counter_reg[31]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\NLW_sample_counter_reg[31]_i_4_O_UNCONNECTED [3],data0[31:29]}),
        .S({1'b0,sample_counter[31:29]}));
  FDRE \sample_counter_reg[3] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[3]),
        .Q(sample_counter[3]),
        .R(p_0_in));
  FDRE \sample_counter_reg[4] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[4]),
        .Q(sample_counter[4]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[4]_i_2 
       (.CI(1'b0),
        .CO({\sample_counter_reg[4]_i_2_n_0 ,\sample_counter_reg[4]_i_2_n_1 ,\sample_counter_reg[4]_i_2_n_2 ,\sample_counter_reg[4]_i_2_n_3 }),
        .CYINIT(sample_counter[0]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[4:1]),
        .S(sample_counter[4:1]));
  FDRE \sample_counter_reg[5] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[5]),
        .Q(sample_counter[5]),
        .R(p_0_in));
  FDRE \sample_counter_reg[6] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[6]),
        .Q(sample_counter[6]),
        .R(p_0_in));
  FDRE \sample_counter_reg[7] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[7]),
        .Q(sample_counter[7]),
        .R(p_0_in));
  FDRE \sample_counter_reg[8] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[8]),
        .Q(sample_counter[8]),
        .R(p_0_in));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \sample_counter_reg[8]_i_2 
       (.CI(\sample_counter_reg[4]_i_2_n_0 ),
        .CO({\sample_counter_reg[8]_i_2_n_0 ,\sample_counter_reg[8]_i_2_n_1 ,\sample_counter_reg[8]_i_2_n_2 ,\sample_counter_reg[8]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:5]),
        .S(sample_counter[8:5]));
  FDRE \sample_counter_reg[9] 
       (.C(clk),
        .CE(\sample_counter[31]_i_2_n_0 ),
        .D(sample_counter_0[9]),
        .Q(sample_counter[9]),
        .R(p_0_in));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
