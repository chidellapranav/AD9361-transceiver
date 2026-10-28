-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:47:18 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ system_top_ad9361_io_manager_0_0_sim_netlist.vhdl
-- Design      : system_top_ad9361_io_manager_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
    ps_gpio_o : in STD_LOGIC_VECTOR ( 63 downto 0 );
    ps_gpio_i : out STD_LOGIC_VECTOR ( 63 downto 0 );
    ps_gpio_t : in STD_LOGIC_VECTOR ( 63 downto 0 );
    gpio_resetb : out STD_LOGIC;
    gpio_sync : out STD_LOGIC;
    gpio_en_agc : out STD_LOGIC;
    gpio_ctl : out STD_LOGIC_VECTOR ( 3 downto 0 );
    gpio_status : in STD_LOGIC_VECTOR ( 7 downto 0 );
    gpio_clksel : out STD_LOGIC;
    up_enable : out STD_LOGIC;
    up_txnrx : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "system_top_ad9361_io_manager_0_0,ad9361_io_manager,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "ad9361_io_manager,Vivado 2022.2";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  signal \<const0>\ : STD_LOGIC;
  signal \^gpio_status\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \^ps_gpio_o\ : STD_LOGIC_VECTOR ( 63 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of ps_gpio_i : signal is "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_I";
  attribute X_INTERFACE_INFO of ps_gpio_o : signal is "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_O";
  attribute X_INTERFACE_INFO of ps_gpio_t : signal is "xilinx.com:interface:gpio:1.0 GPIO_0 TRI_T";
begin
  \^gpio_status\(7 downto 0) <= gpio_status(7 downto 0);
  \^ps_gpio_o\(56 downto 47) <= ps_gpio_o(56 downto 47);
  gpio_clksel <= \^ps_gpio_o\(54);
  gpio_ctl(3 downto 0) <= \^ps_gpio_o\(53 downto 50);
  gpio_en_agc <= \^ps_gpio_o\(49);
  gpio_resetb <= \^ps_gpio_o\(47);
  gpio_sync <= \^ps_gpio_o\(48);
  ps_gpio_i(63) <= \<const0>\;
  ps_gpio_i(62) <= \<const0>\;
  ps_gpio_i(61) <= \<const0>\;
  ps_gpio_i(60) <= \<const0>\;
  ps_gpio_i(59) <= \<const0>\;
  ps_gpio_i(58) <= \<const0>\;
  ps_gpio_i(57) <= \<const0>\;
  ps_gpio_i(56 downto 47) <= \^ps_gpio_o\(56 downto 47);
  ps_gpio_i(46 downto 39) <= \^gpio_status\(7 downto 0);
  ps_gpio_i(38) <= \<const0>\;
  ps_gpio_i(37) <= \<const0>\;
  ps_gpio_i(36) <= \<const0>\;
  ps_gpio_i(35) <= \<const0>\;
  ps_gpio_i(34) <= \<const0>\;
  ps_gpio_i(33) <= \<const0>\;
  ps_gpio_i(32) <= \<const0>\;
  ps_gpio_i(31) <= \<const0>\;
  ps_gpio_i(30) <= \<const0>\;
  ps_gpio_i(29) <= \<const0>\;
  ps_gpio_i(28) <= \<const0>\;
  ps_gpio_i(27) <= \<const0>\;
  ps_gpio_i(26) <= \<const0>\;
  ps_gpio_i(25) <= \<const0>\;
  ps_gpio_i(24) <= \<const0>\;
  ps_gpio_i(23) <= \<const0>\;
  ps_gpio_i(22) <= \<const0>\;
  ps_gpio_i(21) <= \<const0>\;
  ps_gpio_i(20) <= \<const0>\;
  ps_gpio_i(19) <= \<const0>\;
  ps_gpio_i(18) <= \<const0>\;
  ps_gpio_i(17) <= \<const0>\;
  ps_gpio_i(16) <= \<const0>\;
  ps_gpio_i(15) <= \<const0>\;
  ps_gpio_i(14) <= \<const0>\;
  ps_gpio_i(13) <= \<const0>\;
  ps_gpio_i(12) <= \<const0>\;
  ps_gpio_i(11) <= \<const0>\;
  ps_gpio_i(10) <= \<const0>\;
  ps_gpio_i(9) <= \<const0>\;
  ps_gpio_i(8) <= \<const0>\;
  ps_gpio_i(7) <= \<const0>\;
  ps_gpio_i(6) <= \<const0>\;
  ps_gpio_i(5) <= \<const0>\;
  ps_gpio_i(4) <= \<const0>\;
  ps_gpio_i(3) <= \<const0>\;
  ps_gpio_i(2) <= \<const0>\;
  ps_gpio_i(1) <= \<const0>\;
  ps_gpio_i(0) <= \<const0>\;
  up_enable <= \^ps_gpio_o\(55);
  up_txnrx <= \^ps_gpio_o\(56);
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
end STRUCTURE;
