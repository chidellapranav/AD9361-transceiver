-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Mon Oct 19 09:46:05 2026
-- Host        : pranavsai running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/pranavsai/PRJ_SELF/AD9361/AD9361.gen/sources_1/bd/system_top/ip/system_top_tlast_generator_0_0/system_top_tlast_generator_0_0_sim_netlist.vhdl
-- Design      : system_top_tlast_generator_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z035ifbg676-2L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_top_tlast_generator_0_0_tlast_generator is
  port (
    sample_counter : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    rx_valid : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of system_top_tlast_generator_0_0_tlast_generator : entity is "tlast_generator";
end system_top_tlast_generator_0_0_tlast_generator;

architecture STRUCTURE of system_top_tlast_generator_0_0_tlast_generator is
  signal data0 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal m_axis_tlast_INST_0_i_1_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_2_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_3_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_4_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_5_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_6_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_7_n_0 : STD_LOGIC;
  signal m_axis_tlast_INST_0_i_8_n_0 : STD_LOGIC;
  signal p_0_in : STD_LOGIC;
  signal \^sample_counter\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \sample_counter[31]_i_2_n_0\ : STD_LOGIC;
  signal sample_counter_0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \sample_counter_reg[12]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[12]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[12]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[12]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[16]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[16]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[16]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[16]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[20]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[20]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[20]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[20]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[24]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[24]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[24]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[24]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[28]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[28]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[28]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[28]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[31]_i_4_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[31]_i_4_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[4]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[4]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[4]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[4]_i_2_n_3\ : STD_LOGIC;
  signal \sample_counter_reg[8]_i_2_n_0\ : STD_LOGIC;
  signal \sample_counter_reg[8]_i_2_n_1\ : STD_LOGIC;
  signal \sample_counter_reg[8]_i_2_n_2\ : STD_LOGIC;
  signal \sample_counter_reg[8]_i_2_n_3\ : STD_LOGIC;
  signal \NLW_sample_counter_reg[31]_i_4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_sample_counter_reg[31]_i_4_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of m_axis_tlast_INST_0 : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \sample_counter[1]_i_1\ : label is "soft_lutpair0";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \sample_counter_reg[12]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[16]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[20]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[24]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[28]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[31]_i_4\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[4]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \sample_counter_reg[8]_i_2\ : label is 35;
begin
  sample_counter(31 downto 0) <= \^sample_counter\(31 downto 0);
m_axis_tlast_INST_0: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      O => m_axis_tlast
    );
m_axis_tlast_INST_0_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \^sample_counter\(18),
      I1 => \^sample_counter\(19),
      I2 => \^sample_counter\(16),
      I3 => \^sample_counter\(17),
      I4 => m_axis_tlast_INST_0_i_5_n_0,
      O => m_axis_tlast_INST_0_i_1_n_0
    );
m_axis_tlast_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \^sample_counter\(26),
      I1 => \^sample_counter\(27),
      I2 => \^sample_counter\(24),
      I3 => \^sample_counter\(25),
      I4 => m_axis_tlast_INST_0_i_6_n_0,
      O => m_axis_tlast_INST_0_i_2_n_0
    );
m_axis_tlast_INST_0_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFF7FFF"
    )
        port map (
      I0 => \^sample_counter\(2),
      I1 => \^sample_counter\(3),
      I2 => \^sample_counter\(0),
      I3 => \^sample_counter\(1),
      I4 => m_axis_tlast_INST_0_i_7_n_0,
      O => m_axis_tlast_INST_0_i_3_n_0
    );
m_axis_tlast_INST_0_i_4: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFEFFF"
    )
        port map (
      I0 => \^sample_counter\(10),
      I1 => \^sample_counter\(11),
      I2 => \^sample_counter\(8),
      I3 => \^sample_counter\(9),
      I4 => m_axis_tlast_INST_0_i_8_n_0,
      O => m_axis_tlast_INST_0_i_4_n_0
    );
m_axis_tlast_INST_0_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^sample_counter\(21),
      I1 => \^sample_counter\(20),
      I2 => \^sample_counter\(23),
      I3 => \^sample_counter\(22),
      O => m_axis_tlast_INST_0_i_5_n_0
    );
m_axis_tlast_INST_0_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^sample_counter\(29),
      I1 => \^sample_counter\(28),
      I2 => \^sample_counter\(31),
      I3 => \^sample_counter\(30),
      O => m_axis_tlast_INST_0_i_6_n_0
    );
m_axis_tlast_INST_0_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => \^sample_counter\(5),
      I1 => \^sample_counter\(4),
      I2 => \^sample_counter\(7),
      I3 => \^sample_counter\(6),
      O => m_axis_tlast_INST_0_i_7_n_0
    );
m_axis_tlast_INST_0_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^sample_counter\(13),
      I1 => \^sample_counter\(12),
      I2 => \^sample_counter\(15),
      I3 => \^sample_counter\(14),
      O => m_axis_tlast_INST_0_i_8_n_0
    );
\sample_counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^sample_counter\(0),
      O => sample_counter_0(0)
    );
\sample_counter[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(10),
      O => sample_counter_0(10)
    );
\sample_counter[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(11),
      O => sample_counter_0(11)
    );
\sample_counter[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(12),
      O => sample_counter_0(12)
    );
\sample_counter[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(13),
      O => sample_counter_0(13)
    );
\sample_counter[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(14),
      O => sample_counter_0(14)
    );
\sample_counter[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(15),
      O => sample_counter_0(15)
    );
\sample_counter[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(16),
      O => sample_counter_0(16)
    );
\sample_counter[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(17),
      O => sample_counter_0(17)
    );
\sample_counter[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(18),
      O => sample_counter_0(18)
    );
\sample_counter[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(19),
      O => sample_counter_0(19)
    );
\sample_counter[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(1),
      O => sample_counter_0(1)
    );
\sample_counter[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(20),
      O => sample_counter_0(20)
    );
\sample_counter[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(21),
      O => sample_counter_0(21)
    );
\sample_counter[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(22),
      O => sample_counter_0(22)
    );
\sample_counter[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(23),
      O => sample_counter_0(23)
    );
\sample_counter[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(24),
      O => sample_counter_0(24)
    );
\sample_counter[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(25),
      O => sample_counter_0(25)
    );
\sample_counter[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(26),
      O => sample_counter_0(26)
    );
\sample_counter[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(27),
      O => sample_counter_0(27)
    );
\sample_counter[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(28),
      O => sample_counter_0(28)
    );
\sample_counter[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(29),
      O => sample_counter_0(29)
    );
\sample_counter[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(2),
      O => sample_counter_0(2)
    );
\sample_counter[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(30),
      O => sample_counter_0(30)
    );
\sample_counter[31]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => resetn,
      O => p_0_in
    );
\sample_counter[31]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => rx_valid,
      I1 => m_axis_tready,
      O => \sample_counter[31]_i_2_n_0\
    );
\sample_counter[31]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(31),
      O => sample_counter_0(31)
    );
\sample_counter[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(3),
      O => sample_counter_0(3)
    );
\sample_counter[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(4),
      O => sample_counter_0(4)
    );
\sample_counter[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(5),
      O => sample_counter_0(5)
    );
\sample_counter[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(6),
      O => sample_counter_0(6)
    );
\sample_counter[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(7),
      O => sample_counter_0(7)
    );
\sample_counter[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(8),
      O => sample_counter_0(8)
    );
\sample_counter[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFE0000"
    )
        port map (
      I0 => m_axis_tlast_INST_0_i_1_n_0,
      I1 => m_axis_tlast_INST_0_i_2_n_0,
      I2 => m_axis_tlast_INST_0_i_3_n_0,
      I3 => m_axis_tlast_INST_0_i_4_n_0,
      I4 => data0(9),
      O => sample_counter_0(9)
    );
\sample_counter_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(0),
      Q => \^sample_counter\(0),
      R => p_0_in
    );
\sample_counter_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(10),
      Q => \^sample_counter\(10),
      R => p_0_in
    );
\sample_counter_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(11),
      Q => \^sample_counter\(11),
      R => p_0_in
    );
\sample_counter_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(12),
      Q => \^sample_counter\(12),
      R => p_0_in
    );
\sample_counter_reg[12]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[8]_i_2_n_0\,
      CO(3) => \sample_counter_reg[12]_i_2_n_0\,
      CO(2) => \sample_counter_reg[12]_i_2_n_1\,
      CO(1) => \sample_counter_reg[12]_i_2_n_2\,
      CO(0) => \sample_counter_reg[12]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(12 downto 9),
      S(3 downto 0) => \^sample_counter\(12 downto 9)
    );
\sample_counter_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(13),
      Q => \^sample_counter\(13),
      R => p_0_in
    );
\sample_counter_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(14),
      Q => \^sample_counter\(14),
      R => p_0_in
    );
\sample_counter_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(15),
      Q => \^sample_counter\(15),
      R => p_0_in
    );
\sample_counter_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(16),
      Q => \^sample_counter\(16),
      R => p_0_in
    );
\sample_counter_reg[16]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[12]_i_2_n_0\,
      CO(3) => \sample_counter_reg[16]_i_2_n_0\,
      CO(2) => \sample_counter_reg[16]_i_2_n_1\,
      CO(1) => \sample_counter_reg[16]_i_2_n_2\,
      CO(0) => \sample_counter_reg[16]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(16 downto 13),
      S(3 downto 0) => \^sample_counter\(16 downto 13)
    );
\sample_counter_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(17),
      Q => \^sample_counter\(17),
      R => p_0_in
    );
\sample_counter_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(18),
      Q => \^sample_counter\(18),
      R => p_0_in
    );
\sample_counter_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(19),
      Q => \^sample_counter\(19),
      R => p_0_in
    );
\sample_counter_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(1),
      Q => \^sample_counter\(1),
      R => p_0_in
    );
\sample_counter_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(20),
      Q => \^sample_counter\(20),
      R => p_0_in
    );
\sample_counter_reg[20]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[16]_i_2_n_0\,
      CO(3) => \sample_counter_reg[20]_i_2_n_0\,
      CO(2) => \sample_counter_reg[20]_i_2_n_1\,
      CO(1) => \sample_counter_reg[20]_i_2_n_2\,
      CO(0) => \sample_counter_reg[20]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(20 downto 17),
      S(3 downto 0) => \^sample_counter\(20 downto 17)
    );
\sample_counter_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(21),
      Q => \^sample_counter\(21),
      R => p_0_in
    );
\sample_counter_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(22),
      Q => \^sample_counter\(22),
      R => p_0_in
    );
\sample_counter_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(23),
      Q => \^sample_counter\(23),
      R => p_0_in
    );
\sample_counter_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(24),
      Q => \^sample_counter\(24),
      R => p_0_in
    );
\sample_counter_reg[24]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[20]_i_2_n_0\,
      CO(3) => \sample_counter_reg[24]_i_2_n_0\,
      CO(2) => \sample_counter_reg[24]_i_2_n_1\,
      CO(1) => \sample_counter_reg[24]_i_2_n_2\,
      CO(0) => \sample_counter_reg[24]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(24 downto 21),
      S(3 downto 0) => \^sample_counter\(24 downto 21)
    );
\sample_counter_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(25),
      Q => \^sample_counter\(25),
      R => p_0_in
    );
\sample_counter_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(26),
      Q => \^sample_counter\(26),
      R => p_0_in
    );
\sample_counter_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(27),
      Q => \^sample_counter\(27),
      R => p_0_in
    );
\sample_counter_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(28),
      Q => \^sample_counter\(28),
      R => p_0_in
    );
\sample_counter_reg[28]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[24]_i_2_n_0\,
      CO(3) => \sample_counter_reg[28]_i_2_n_0\,
      CO(2) => \sample_counter_reg[28]_i_2_n_1\,
      CO(1) => \sample_counter_reg[28]_i_2_n_2\,
      CO(0) => \sample_counter_reg[28]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(28 downto 25),
      S(3 downto 0) => \^sample_counter\(28 downto 25)
    );
\sample_counter_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(29),
      Q => \^sample_counter\(29),
      R => p_0_in
    );
\sample_counter_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(2),
      Q => \^sample_counter\(2),
      R => p_0_in
    );
\sample_counter_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(30),
      Q => \^sample_counter\(30),
      R => p_0_in
    );
\sample_counter_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(31),
      Q => \^sample_counter\(31),
      R => p_0_in
    );
\sample_counter_reg[31]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[28]_i_2_n_0\,
      CO(3 downto 2) => \NLW_sample_counter_reg[31]_i_4_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \sample_counter_reg[31]_i_4_n_2\,
      CO(0) => \sample_counter_reg[31]_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_sample_counter_reg[31]_i_4_O_UNCONNECTED\(3),
      O(2 downto 0) => data0(31 downto 29),
      S(3) => '0',
      S(2 downto 0) => \^sample_counter\(31 downto 29)
    );
\sample_counter_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(3),
      Q => \^sample_counter\(3),
      R => p_0_in
    );
\sample_counter_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(4),
      Q => \^sample_counter\(4),
      R => p_0_in
    );
\sample_counter_reg[4]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \sample_counter_reg[4]_i_2_n_0\,
      CO(2) => \sample_counter_reg[4]_i_2_n_1\,
      CO(1) => \sample_counter_reg[4]_i_2_n_2\,
      CO(0) => \sample_counter_reg[4]_i_2_n_3\,
      CYINIT => \^sample_counter\(0),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(4 downto 1),
      S(3 downto 0) => \^sample_counter\(4 downto 1)
    );
\sample_counter_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(5),
      Q => \^sample_counter\(5),
      R => p_0_in
    );
\sample_counter_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(6),
      Q => \^sample_counter\(6),
      R => p_0_in
    );
\sample_counter_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(7),
      Q => \^sample_counter\(7),
      R => p_0_in
    );
\sample_counter_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(8),
      Q => \^sample_counter\(8),
      R => p_0_in
    );
\sample_counter_reg[8]_i_2\: unisim.vcomponents.CARRY4
     port map (
      CI => \sample_counter_reg[4]_i_2_n_0\,
      CO(3) => \sample_counter_reg[8]_i_2_n_0\,
      CO(2) => \sample_counter_reg[8]_i_2_n_1\,
      CO(1) => \sample_counter_reg[8]_i_2_n_2\,
      CO(0) => \sample_counter_reg[8]_i_2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => data0(8 downto 5),
      S(3 downto 0) => \^sample_counter\(8 downto 5)
    );
\sample_counter_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => clk,
      CE => \sample_counter[31]_i_2_n_0\,
      D => sample_counter_0(9),
      Q => \^sample_counter\(9),
      R => p_0_in
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_top_tlast_generator_0_0 is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of system_top_tlast_generator_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of system_top_tlast_generator_0_0 : entity is "system_top_tlast_generator_0_0,tlast_generator,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of system_top_tlast_generator_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of system_top_tlast_generator_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of system_top_tlast_generator_0_0 : entity is "tlast_generator,Vivado 2022.2";
end system_top_tlast_generator_0_0;

architecture STRUCTURE of system_top_tlast_generator_0_0 is
  signal \^iq_ch0_i\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^iq_ch0_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^iq_ch1_i\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^iq_ch1_q\ : STD_LOGIC_VECTOR ( 15 downto 0 );
  signal \^rx_valid\ : STD_LOGIC;
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, ASSOCIATED_BUSIF m_axis, ASSOCIATED_RESET resetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis TLAST";
  attribute X_INTERFACE_INFO of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_axis TREADY";
  attribute X_INTERFACE_PARAMETER of m_axis_tready : signal is "XIL_INTERFACENAME m_axis, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis TVALID";
  attribute X_INTERFACE_INFO of resetn : signal is "xilinx.com:signal:reset:1.0 resetn RST";
  attribute X_INTERFACE_PARAMETER of resetn : signal is "XIL_INTERFACENAME resetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of rx_valid : signal is "analog.com:interface:fifo_rd:1.0 rx VALID";
  attribute X_INTERFACE_INFO of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis TDATA";
begin
  \^iq_ch0_i\(15 downto 0) <= iq_ch0_i(15 downto 0);
  \^iq_ch0_q\(15 downto 0) <= iq_ch0_q(15 downto 0);
  \^iq_ch1_i\(15 downto 0) <= iq_ch1_i(15 downto 0);
  \^iq_ch1_q\(15 downto 0) <= iq_ch1_q(15 downto 0);
  \^rx_valid\ <= rx_valid;
  m_axis_tdata(63 downto 48) <= \^iq_ch1_q\(15 downto 0);
  m_axis_tdata(47 downto 32) <= \^iq_ch1_i\(15 downto 0);
  m_axis_tdata(31 downto 16) <= \^iq_ch0_q\(15 downto 0);
  m_axis_tdata(15 downto 0) <= \^iq_ch0_i\(15 downto 0);
  m_axis_tvalid <= \^rx_valid\;
inst: entity work.system_top_tlast_generator_0_0_tlast_generator
     port map (
      clk => clk,
      m_axis_tlast => m_axis_tlast,
      m_axis_tready => m_axis_tready,
      resetn => resetn,
      rx_valid => \^rx_valid\,
      sample_counter(31 downto 0) => sample_counter(31 downto 0)
    );
end STRUCTURE;
