// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Fri Nov 22 14:54:44 2024
// Host        : DESKTOP-BA26H3B running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/DELL/Desktop/TKF_FIRMWARE/FIRMWARE
//               source/TKF_add_sp3_11.14/tkf_test_1/tkf_test_1.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v}
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku060-ffva1517-2-i
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk40_0, clk40_180, clk40_2x, clk40_3x, clk_40, 
  reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk40_0,clk40_180,clk40_2x,clk40_3x,clk_40,reset,locked,clk_in1" */;
  output clk40_0;
  output clk40_180;
  output clk40_2x;
  output clk40_3x;
  output clk_40;
  input reset;
  output locked;
  input clk_in1;
endmodule
