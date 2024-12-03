-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Dec  2 16:34:43 2024
-- Host        : DESKTOP-BA26H3B running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/DELL/Desktop/TKF_FIRMWARE/FIRMWARE
--               source/TKF_add_sp3_11.14/tkf_test_1/tkf_test_1.srcs/sources_1/ip/ram_256_256/ram_256_256_stub.vhdl}
-- Design      : ram_256_256
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku060-ffva1517-2-i
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ram_256_256 is
  Port ( 
    clka : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 0 to 0 );
    addra : in STD_LOGIC_VECTOR ( 7 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 255 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 255 downto 0 );
    clkb : in STD_LOGIC;
    enb : in STD_LOGIC;
    web : in STD_LOGIC_VECTOR ( 0 to 0 );
    addrb : in STD_LOGIC_VECTOR ( 7 downto 0 );
    dinb : in STD_LOGIC_VECTOR ( 255 downto 0 );
    doutb : out STD_LOGIC_VECTOR ( 255 downto 0 )
  );

end ram_256_256;

architecture stub of ram_256_256 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,wea[0:0],addra[7:0],dina[255:0],douta[255:0],clkb,enb,web[0:0],addrb[7:0],dinb[255:0],doutb[255:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_3,Vivado 2019.1";
begin
end;
