-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:45:57 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_util_wfifo_0_0_stub.vhdl
-- Design      : system_top_util_wfifo_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    din_rst : in STD_LOGIC;
    din_clk : in STD_LOGIC;
    din_enable_0 : in STD_LOGIC;
    din_valid_0 : in STD_LOGIC;
    din_data_0 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    din_enable_1 : in STD_LOGIC;
    din_valid_1 : in STD_LOGIC;
    din_data_1 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    din_enable_2 : in STD_LOGIC;
    din_valid_2 : in STD_LOGIC;
    din_data_2 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    din_enable_3 : in STD_LOGIC;
    din_valid_3 : in STD_LOGIC;
    din_data_3 : in STD_LOGIC_VECTOR ( 15 downto 0 );
    din_ovf : out STD_LOGIC;
    dout_rstn : in STD_LOGIC;
    dout_clk : in STD_LOGIC;
    dout_enable_0 : out STD_LOGIC;
    dout_valid_0 : out STD_LOGIC;
    dout_data_0 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dout_enable_1 : out STD_LOGIC;
    dout_valid_1 : out STD_LOGIC;
    dout_data_1 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dout_enable_2 : out STD_LOGIC;
    dout_valid_2 : out STD_LOGIC;
    dout_data_2 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dout_enable_3 : out STD_LOGIC;
    dout_valid_3 : out STD_LOGIC;
    dout_data_3 : out STD_LOGIC_VECTOR ( 15 downto 0 );
    dout_ovf : in STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "din_rst,din_clk,din_enable_0,din_valid_0,din_data_0[15:0],din_enable_1,din_valid_1,din_data_1[15:0],din_enable_2,din_valid_2,din_data_2[15:0],din_enable_3,din_valid_3,din_data_3[15:0],din_ovf,dout_rstn,dout_clk,dout_enable_0,dout_valid_0,dout_data_0[15:0],dout_enable_1,dout_valid_1,dout_data_1[15:0],dout_enable_2,dout_valid_2,dout_data_2[15:0],dout_enable_3,dout_valid_3,dout_data_3[15:0],dout_ovf";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "util_wfifo,Vivado 2022.2";
begin
end;
