-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:47:19 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_ad9361_io_manager_0_0/system_top_ad9361_io_manager_0_0_stub.vhdl
-- Design      : system_top_ad9361_io_manager_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_top_ad9361_io_manager_0_0 is
  Port ( 
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

end system_top_ad9361_io_manager_0_0;

architecture stub of system_top_ad9361_io_manager_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "ps_gpio_o[63:0],ps_gpio_i[63:0],ps_gpio_t[63:0],gpio_resetb,gpio_sync,gpio_en_agc,gpio_ctl[3:0],gpio_status[7:0],gpio_clksel,up_enable,up_txnrx";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "ad9361_io_manager,Vivado 2022.2";
begin
end;
