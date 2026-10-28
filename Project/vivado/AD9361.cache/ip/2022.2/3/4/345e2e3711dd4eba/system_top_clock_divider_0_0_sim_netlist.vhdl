-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:47:12 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_clock_divider_0_0_sim_netlist.vhdl
-- Design      : system_top_clock_divider_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_divider is
  port (
    clk_out : out STD_LOGIC;
    d_r1 : in STD_LOGIC;
    a_r1 : in STD_LOGIC;
    clk_in : in STD_LOGIC
  );
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_divider;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_divider is
  signal \^clk_out\ : STD_LOGIC;
  signal clk_out_i_1_n_0 : STD_LOGIC;
  signal counter : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \counter[0]_i_1_n_0\ : STD_LOGIC;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of clk_out_i_1 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \counter[0]_i_1\ : label is "soft_lutpair0";
begin
  clk_out <= \^clk_out\;
clk_out_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"15EA"
    )
        port map (
      I0 => counter(0),
      I1 => d_r1,
      I2 => a_r1,
      I3 => \^clk_out\,
      O => clk_out_i_1_n_0
    );
clk_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      D => clk_out_i_1_n_0,
      Q => \^clk_out\,
      R => '0'
    );
\counter[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
        port map (
      I0 => counter(0),
      I1 => d_r1,
      I2 => a_r1,
      O => \counter[0]_i_1_n_0\
    );
\counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      D => \counter[0]_i_1_n_0\,
      Q => counter(0),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    clk_in : in STD_LOGIC;
    d_r1 : in STD_LOGIC;
    a_r1 : in STD_LOGIC;
    clk_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "system_top_clock_divider_0_0,clock_divider,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "clock_divider,Vivado 2022.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_clock_divider
     port map (
      a_r1 => a_r1,
      clk_in => clk_in,
      clk_out => clk_out,
      d_r1 => d_r1
    );
end STRUCTURE;
