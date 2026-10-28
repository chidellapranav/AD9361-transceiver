-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:46:34 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_tx_modem_burst_0_0_stub.vhdl
-- Design      : system_top_tx_modem_burst_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    enable : in STD_LOGIC;
    tx_i : out STD_LOGIC_VECTOR ( 15 downto 0 );
    tx_q : out STD_LOGIC_VECTOR ( 15 downto 0 );
    tx_valid : out STD_LOGIC;
    burst_active : out STD_LOGIC;
    burst_last : out STD_LOGIC;
    error : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,resetn,enable,tx_i[15:0],tx_q[15:0],tx_valid,burst_active,burst_last,error";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "tx_modem_burst,Vivado 2022.2";
begin
end;
