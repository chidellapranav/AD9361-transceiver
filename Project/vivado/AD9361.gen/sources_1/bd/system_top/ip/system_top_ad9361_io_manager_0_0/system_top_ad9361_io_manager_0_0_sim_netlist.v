// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:19 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_ad9361_io_manager_0_0/system_top_ad9361_io_manager_0_0_sim_netlist.v
// Design      : system_top_ad9361_io_manager_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_top_ad9361_io_manager_0_0,ad9361_io_manager,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "ad9361_io_manager,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_top_ad9361_io_manager_0_0
   (ps_gpio_o,
    ps_gpio_i,
    ps_gpio_t,
    gpio_resetb,
    gpio_sync,
    gpio_en_agc,
    gpio_ctl,
    gpio_status,
    gpio_clksel,
    up_enable,
    up_txnrx);
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_O" *) input [63:0]ps_gpio_o;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_I" *) output [63:0]ps_gpio_i;
  (* X_INTERFACE_INFO = "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_T" *) input [63:0]ps_gpio_t;
  output gpio_resetb;
  output gpio_sync;
  output gpio_en_agc;
  output [3:0]gpio_ctl;
  input [7:0]gpio_status;
  output gpio_clksel;
  output up_enable;
  output up_txnrx;

  wire \<const0> ;
  wire [7:0]gpio_status;
  wire [63:0]ps_gpio_o;

  assign gpio_clksel = ps_gpio_o[54];
  assign gpio_ctl[3:0] = ps_gpio_o[53:50];
  assign gpio_en_agc = ps_gpio_o[49];
  assign gpio_resetb = ps_gpio_o[47];
  assign gpio_sync = ps_gpio_o[48];
  assign ps_gpio_i[63] = \<const0> ;
  assign ps_gpio_i[62] = \<const0> ;
  assign ps_gpio_i[61] = \<const0> ;
  assign ps_gpio_i[60] = \<const0> ;
  assign ps_gpio_i[59] = \<const0> ;
  assign ps_gpio_i[58] = \<const0> ;
  assign ps_gpio_i[57] = \<const0> ;
  assign ps_gpio_i[56:47] = ps_gpio_o[56:47];
  assign ps_gpio_i[46:39] = gpio_status;
  assign ps_gpio_i[38] = \<const0> ;
  assign ps_gpio_i[37] = \<const0> ;
  assign ps_gpio_i[36] = \<const0> ;
  assign ps_gpio_i[35] = \<const0> ;
  assign ps_gpio_i[34] = \<const0> ;
  assign ps_gpio_i[33] = \<const0> ;
  assign ps_gpio_i[32] = \<const0> ;
  assign ps_gpio_i[31] = \<const0> ;
  assign ps_gpio_i[30] = \<const0> ;
  assign ps_gpio_i[29] = \<const0> ;
  assign ps_gpio_i[28] = \<const0> ;
  assign ps_gpio_i[27] = \<const0> ;
  assign ps_gpio_i[26] = \<const0> ;
  assign ps_gpio_i[25] = \<const0> ;
  assign ps_gpio_i[24] = \<const0> ;
  assign ps_gpio_i[23] = \<const0> ;
  assign ps_gpio_i[22] = \<const0> ;
  assign ps_gpio_i[21] = \<const0> ;
  assign ps_gpio_i[20] = \<const0> ;
  assign ps_gpio_i[19] = \<const0> ;
  assign ps_gpio_i[18] = \<const0> ;
  assign ps_gpio_i[17] = \<const0> ;
  assign ps_gpio_i[16] = \<const0> ;
  assign ps_gpio_i[15] = \<const0> ;
  assign ps_gpio_i[14] = \<const0> ;
  assign ps_gpio_i[13] = \<const0> ;
  assign ps_gpio_i[12] = \<const0> ;
  assign ps_gpio_i[11] = \<const0> ;
  assign ps_gpio_i[10] = \<const0> ;
  assign ps_gpio_i[9] = \<const0> ;
  assign ps_gpio_i[8] = \<const0> ;
  assign ps_gpio_i[7] = \<const0> ;
  assign ps_gpio_i[6] = \<const0> ;
  assign ps_gpio_i[5] = \<const0> ;
  assign ps_gpio_i[4] = \<const0> ;
  assign ps_gpio_i[3] = \<const0> ;
  assign ps_gpio_i[2] = \<const0> ;
  assign ps_gpio_i[1] = \<const0> ;
  assign ps_gpio_i[0] = \<const0> ;
  assign up_enable = ps_gpio_o[55];
  assign up_txnrx = ps_gpio_o[56];
  GND GND
       (.G(\<const0> ));
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
