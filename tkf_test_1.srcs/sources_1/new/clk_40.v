`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    16:22:09 07/04/06
// Design Name:    
// Module Name:    clk_40
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module clk_40(clk200p,clk200n,reset,lock40,clk40,clk40_2x,clk40_3x,clk40_i);

input clk200p,clk200n,reset;
output lock40,clk40,clk40_2x,clk40_3x,clk40_i;

//let's design the firmware based on the following assumptions
wire clk40_fb,clk40_180,clk120,clk_40_out; 
   IBUFGDS #(
      .DIFF_TERM("true"),    // Differential Termination (Virtex-4 only)
      .IOSTANDARD("LVDS_25_DT")  // Specify the input I/O standard
   ) buf1 (
      .O(clk200_dcm),  // Clock buffer output
      .I(clk200p),  // Diff_p clock buffer input (connect directly to top-level port)
      .IB(clk200n) // Diff_n clock buffer input (connect directly to top-level port)
   );

assign clk40_i=clk_40_out;

  clk_wiz_0 clk200to40
   (
    // Clock out ports
    .clk40_0(clk40_0),     // output clk40_0
    .clk40_180(clk40_180),     // output clk40_180
    .clk40_2x(clk40_2x),     // output clk40_2x
    .clk40_3x(clk40_3x),     // output clk40_3x
    .clk_40(clk_40_out),     // output clk_40
    // Status and control signals
    .reset(reset), // input reset
    .locked(lock40),       // output locked
   // Clock in ports
    .clk_in1(clk200_dcm));      // input clk_in1

   
// BUF   buf2 (.I (clk40_0), .O (clk40_fb));
BUFG   buf3 (.I (clk40_180), .O (clk40));



endmodule 
