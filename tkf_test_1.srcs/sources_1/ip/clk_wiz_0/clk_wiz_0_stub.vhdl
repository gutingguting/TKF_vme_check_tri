-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Fri Nov 22 14:54:44 2024
-- Host        : DESKTOP-BA26H3B running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/DELL/Desktop/TKF_FIRMWARE/FIRMWARE
--               source/TKF_add_sp3_11.14/tkf_test_1/tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.vhdl}
-- Design      : clk_wiz_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-i
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_0 is
  Port ( 
    clk40_0 : out STD_LOGIC;
    clk40_180 : out STD_LOGIC;
    clk40_2x : out STD_LOGIC;
    clk40_3x : out STD_LOGIC;
    clk_40 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_0;

architecture stub of clk_wiz_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk40_0,clk40_180,clk40_2x,clk40_3x,clk_40,reset,locked,clk_in1";
begin
end;
