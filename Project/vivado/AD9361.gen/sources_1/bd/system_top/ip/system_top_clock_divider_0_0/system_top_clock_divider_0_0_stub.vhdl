-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:47:12 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_clock_divider_0_0/system_top_clock_divider_0_0_stub.vhdl
-- Design      : system_top_clock_divider_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_top_clock_divider_0_0 is
  Port ( 
    clk_in : in STD_LOGIC;
    d_r1 : in STD_LOGIC;
    a_r1 : in STD_LOGIC;
    clk_out : out STD_LOGIC
  );

end system_top_clock_divider_0_0;

architecture stub of system_top_clock_divider_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_in,d_r1,a_r1,clk_out";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "clock_divider,Vivado 2022.2";
begin
end;
