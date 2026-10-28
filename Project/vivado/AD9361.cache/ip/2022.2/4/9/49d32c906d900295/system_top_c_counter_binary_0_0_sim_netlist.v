// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:17 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_c_counter_binary_0_0_sim_netlist.v
// Design      : system_top_c_counter_binary_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_top_c_counter_binary_0_0,c_counter_binary_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_15,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    Q);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:thresh0_intf:l_intf:load_intf:up_intf:sinit_intf:sset_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value data} bitwidth {attribs {resolve_type generated dependency bitwidth format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} integer {signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}} DATA_WIDTH 16}" *) output [15:0]Q;

  wire CLK;
  wire [15:0]Q;
  wire NLW_U0_THRESH0_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_CE_OVERRIDES_SYNC = "0" *) 
  (* C_FB_LATENCY = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_WIDTH = "16" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* c_count_by = "100101000" *) 
  (* c_count_mode = "0" *) 
  (* c_count_to = "1" *) 
  (* c_has_load = "0" *) 
  (* c_has_thresh0 = "0" *) 
  (* c_latency = "1" *) 
  (* c_load_low = "0" *) 
  (* c_restrict_count = "0" *) 
  (* c_thresh0_value = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_c_counter_binary_v12_0_15 U0
       (.CE(1'b1),
        .CLK(CLK),
        .L({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .LOAD(1'b0),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0),
        .THRESH0(NLW_U0_THRESH0_UNCONNECTED),
        .UP(1'b1));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
KdkdvVsuosc8qR9X5PxQ/ghTeTrEz4qKVuenhDR9wRSL/BO/mhSwQtiFj74UO0sGv0zvjAntaq/3
l2/v8gOiVKmM666gbk/2UCISA4OFA3FDR9jYmiXdNXb2qHeS1ywQz5n/sTR5iu4KFEfwrl3IXtQw
aEiGegL+CQMaovJsto4=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pZCj3qT3VD1SCS5RiZExsqqu16KpMtHXilQL9p5/eBl7qrfQjT1VhFtVbYUusepbChjsCCmCn7hr
72SuHmOmDWG78UARN7MLdO/+sePuyS06ak4nAw5xwjT0g+9970uMWYKvTeeYqoz2i+k+zX60Cuvu
iwBfxWM22DqukHlYzbEFWhNyXIkgJe71p67vGdXBmqu4/2wmlwGApqBxlwR+alwZ9UGHlxNQS4N5
z1wHu3Cp8LwGRjlaXjElcY8RDpvyz5l59ey8ar5HXR9Zqf6e1unE2NdhzHhEGRerRFXoKZppk1HB
6kIEY4EHAWz+HvPcqoP9eoYKDazoAGkJRVP6YA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
gLgm7VvY3cNcNvdXvikCQd2nRniE4ae4hePOcAUlPDMoHDzQAD7Ngo12MGFns9JNPcCaUXfAmxL2
JNGojjrDRUWrv8FPV6FOEbDHs96fef8+gqLF4OqLck4kWpKhnJwaJjjzQirvXEzZxP+GsBKnkSp8
ceVlZJwP0F6XRv+RpQA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GeZP242oKQSNuofqDs4oIIXZEufPhRVrlFFeRSLY4VCxhMEMwfPrNXe33xO0zIEBoPW2X9mvUoTY
izdWQEtWImFzjzPCjkSLhEdIMmUBH02Y+Tw3eW5x23T0cK96pmoV2MH8kl99I27MN6stVd977fuB
Mjao5MnSXIGZ/uXGtgfUO9Zjs4/2wGmsI2/lANN2WOL9Sz4xeA8k40c2dNYgxgHoCwx8Ya/RYIZS
Cpuvzq4ZyFSNT/kMXnUmqj75/flpXT3mmyW+frexux3j9PxpKHmxAE9crvDx85rMamGiA4ftl+ac
H0FtL2cBqdlP60x+FjqleWCJoN6AYdxA0YZaeg==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
URmEGftuxvv0+tViRUdsFNnPXucZlVDfUQpjjXkpOA38QUzsIL9j1pGGp9doC4jcg/9MD149BTSw
vAG8684a3k+Tx/8sFGl/viK1q8ty9nktEABSahv8Etm5ZJVAzQJT7EaOzrYqyywSwabogvGUmN/7
DE3eOn6+sMCiMl6BLUhYyK39ntTWNFYVPiheclbBb36V1vzMOQl0mvPuS4hDXqba/+qBZXhqeYWK
ceNfwci6SsRRef6hLF/1S+20r2uBxJeYJjyfWGGFEGfxlAOz1MiYUUR/bEHWnbjwIcJTBHQNRdq4
4Ryb+iPuKcsXU/8ApD14i6ScW+VBPWSqnH9w+A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
NtQgA3rUKfJt+21sTot44yr4gmte57FoFl8Q/327tsRJeEyNAiwWZaZN2mbo2NFcvyN2GhDw6avJ
NsF1Oxs36P8shoqOOiloWWrdTcyAdMhdk+UjeZgKcNSqd4Js87w/5LVQTwjB2mcBDfe1jrivv+IW
ZRBC8NvlW5z/1wF7+vzXRMziLQYeOkLB0OkpIY+eT5cZXDKuZ+4l0FMPjd+El96JGAEHG7Q0qS3F
OEApYEp8+nSZnragoytq4pkhVJEC22ye0hBhoBClJpszCcg0u+Ugf+mYZsj8BC2uqSY6Hh/gpjjw
enQ7aEYBaUR7GCwQN7fZmNhZYtBkyvNqydRQcA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
CpIFM8Y8dBmpjtOVnOKcfppEFV+c1cRgsQtewNUe+5apiLDoRCdMyTqoCay7nz+Xagc0OvfZDg/Y
jSTsDjKVcEIyxOfix7iwjKW8Rz+a5wBIatI8wfCo7uLtuucz9otOWWI7BFQ2gn4VdQ73HJJlZMMY
OyEOd33tGjNSjxz3W07knDr1FwTE3BOfhq+Qj2ErnuV1dQbrTb3MiQMTnHaTCwtz6ip0pD6b5G4K
kBRUYe+UNXCMvSfNIN9MPSmolO4MjNwM5gnZZqLcR1hGuzH/Yeb/jPnhsZ7jFvlTT3nsM9JzMRAE
QwlzVuulHKQDS2I96arFosYPYMsalmn6CQW0gg==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
qinIxHFISC9r9LS7OKOuYVGM5EBkuuQNV1nDRui+QVNLn2QFCrWPeEClQIlNViKOt8MX9urHvu4e
l2L+eZKw6+St9cW9yUsYu36yoB4LqwG+vKvfR9CW82LGPyMAxdgk/p3n+F0Xp9Y2HaERwWDL99tW
V7cDvLLhyIwz7w4rI0BWWV+KMjXP2F5MNgykzZn7tzV8oY6MxOykFqRdI8DLAdlYGAs90wjJ3x84
S3fHciSox97FYpDi64v31Vb4RmRrwueXcvCc3w8gzjuwg7qraWLMYyPB+mERB2v1htX80PsWWVHE
QXkWiHWYvvrXEykUS04MmLNHpV8ZgBXO/NBEGn7mrITDEswk3u1Yviqy7CW2wLPQBoo5xW+uiu2e
8YZV/E+bAt+P/EH5RsC9alBgtuVKU1s9DaiEH8eUPEgJQ/TXwQW01pg8ECTYgiBS+IQSbld23aq3
goVo0ZMzRu/SA00Jmwt7upvsMkh9Q+2732ahu1FmlSNmyNGB1+bYf782

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
T1jqx5hmzZZMhPApzUC1oZLMAkHma8Ki4b2CvLNqxSn+MNWoTPomvQ775DMBEDai/gahYALsohdX
0f/e6LuPqt4zYtyAzmH+nRgOG/tilS1J674KsaHxudAfo4sM3awB/C4Q3VdYsO9FgvPQylnYKSGE
gJ46W+1Y789VQqPbt4dpnprhix6sLlwfww7We6cq2wu4PilFzovejouUBZqNMZHYi4suKcMcenp3
C7QRKloo8IF9yKrhGPcRJLQt2nus3bI0Q3ICxRk13Nrfhh/z4cdm0OGXz42q44snFEVy1lLxPOs7
W9tSe5ag3923oCT4NGGgK/gMTx5qXxFhV2MJUw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
pop6XVEHtVBBoqM4P6m7MUMpGxBlE4/w756EJsp0PBnolPWHcJ67nLmFwKYUQ8NDymvVyIY/lH7x
8yqHaRqrd/aVJ57SeUUNx6poXukvlD7BDoEoVo6Oyyddb5m1o/Iep/CFXatfwfSUTbVf5pJ0mZ/8
rGQzgv8aE9x6djmkDKNGRYsWHRFEfoGmLGvffJ9KtuBV3vAu8zZwahlxPURPIL9O8nwqpyh22mqQ
QBLYy+Ow3khg6gZhGUArjLo4A1pHndqj90djc7/8+VmJTcUbecTcvK1P/l3BmBriKfIADdd9kHJ2
ezvM+pLYNiyWFxmfZ1k0DqzFJsLqGxYf32aWZA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
puyzSsGgtoacmH92RG0QLWKniTPUAEobY5uCaBnhWQArQJuUMl5cSKkw5Y5eCOFZyFNoju8UZYgF
LYafOAUzqEDjEfdV96rJNt/aZ9Cw9wkaBnNRmFp8HKlMaGY5kYUY6FL283oH2K7yQ0r55QsUuXga
mXSBA1tu4Dfjs5ZdK9sjtc/Qdb2N1cFLo1gf8O7O+XHtIgFpLafCqlJUPbzQcZan3Tm/V6nLqBia
6JXLCU4T7tn12T5VYbcgVL88pvT6LiSAhwtwmB/B2XbiXzvNJwkv2kZLv9L5u+hMtqPDejsYBx3S
liLHKzn5KtCqvA1XerE/zaNU/wUydzWimAs8CA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 13376)
`pragma protect data_block
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
`pragma protect end_protected
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
