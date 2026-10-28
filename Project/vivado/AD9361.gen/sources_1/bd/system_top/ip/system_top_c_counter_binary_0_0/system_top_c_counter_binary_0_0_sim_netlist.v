// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Mon Oct 19 09:47:19 2026
// Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_c_counter_binary_0_0/system_top_c_counter_binary_0_0_sim_netlist.v
// Design      : system_top_c_counter_binary_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z035ifbg676-2L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "system_top_c_counter_binary_0_0,c_counter_binary_v12_0_15,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_counter_binary_v12_0_15,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module system_top_c_counter_binary_0_0
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
  system_top_c_counter_binary_0_0_c_counter_binary_v12_0_15 U0
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
f61KNQNml06rOqP9TVyU0Ugt+rc5OED7nWoXHm+beti8lc8GOtpw6QDmuKX+PX2+1ev3iSd70oYj
S4CWuVai2+0F8n+1EKQVJgcaEMLF/zWB2CYJsexCUI737uVrHbC/ym9SEWL/nJqwjALnwu69Ugqj
C/FU4gXUSo7Fer3HyUK+YofHkmOmmmWV/Vn5N8zMlySyzrg2cO3+MSrcAK0jCtdNYGcBLdq24BO5
sxNsBzgqSmTUb9WW7LB5cNnPr80/HuS5GvS4XfY5GFujyuGh+3EXtj8fv9jkPiIIFGltmO3Wyo+b
bvTEOYSJ7S/MrvbL7BjQP0JO0M6Z/3JjkXQE0w==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
WpgE1LMGKC63ppJWdS8YyuogLIwxoB6WNAi59zynBegphbiDIWLe+Qy+2SWQYvJ1sMNkQ3gLDacf
t9ud0CG8edKpW11dT8wR4M3tXtU9k+e9qEKuAVKRphitjcAMCAvtl84kzkCkcUZgYQ5g2NrFCNqf
cj3NJccUzYTxZfbOMqkmh27OrcZ9QeIQjk9yDny/qW+tXyfvffz+w7Tm3A32sh1zXhdAzUvTABEu
fkg9nh/JkX0G64kGTi0kclFNwp//TbBSjlY9a2zvQJDvf50x0LPpTZyjyh4uf5c7A7KZwICxt6iK
Yi2q2hzHDPxr/9+5adpwgSNSPjeLOwYw27BlbQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 13616)
`pragma protect data_block
+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
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
