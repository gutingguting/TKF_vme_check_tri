// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Tue Oct  8 09:49:02 2024
// Host        : DESKTOP-BA26H3B running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/DELL/Desktop/TKF_FIRMWARE/TKF_new_9.30/tkf_test_1/tkf_test_1.srcs/sources_1/ip/fiforam/fiforam_stub.v
// Design      : fiforam
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module fiforam(clka, wea, addra, dina, douta, clkb, enb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[7:0],dina[23:0],douta[23:0],clkb,enb,web[0:0],addrb[7:0],dinb[23:0],doutb[23:0]" */;
  input clka;
  input [0:0]wea;
  input [7:0]addra;
  input [23:0]dina;
  output [23:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [7:0]addrb;
  input [23:0]dinb;
  output [23:0]doutb;
endmodule
