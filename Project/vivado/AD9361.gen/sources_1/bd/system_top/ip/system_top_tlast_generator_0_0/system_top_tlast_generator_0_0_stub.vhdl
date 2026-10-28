-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:46:05 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_tlast_generator_0_0/system_top_tlast_generator_0_0_stub.vhdl
-- Design      : system_top_tlast_generator_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_top_tlast_generator_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    iq_ch0_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    iq_ch0_q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    iq_ch1_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    iq_ch1_q : in STD_LOGIC_VECTOR ( 15 downto 0 );
    rx_valid : in STD_LOGIC;
    m_axis_tdata : out STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tlast : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    sample_counter : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end system_top_tlast_generator_0_0;

architecture stub of system_top_tlast_generator_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,resetn,iq_ch0_i[15:0],iq_ch0_q[15:0],iq_ch1_i[15:0],iq_ch1_q[15:0],rx_valid,m_axis_tdata[63:0],m_axis_tvalid,m_axis_tlast,m_axis_tready,sample_counter[31:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "tlast_generator,Vivado 2022.2";
begin
end;
