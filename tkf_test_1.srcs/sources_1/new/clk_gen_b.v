`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    14:40:56 07/05/05
// Design Name:    
// Module Name:    clk_gen
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
module clk_gen_b(refclkp, refclkn, reset,USRCLK_M, USRCLK2_M, 
                  lock, refclk_out);
    input refclkp;
    input refclkn;
	 input reset;
//    output rxusrclk;
//    output txusrclk;
    output USRCLK_M;
    output USRCLK2_M;
	 
//	 output rxusrclk2;
//    output txusrclk2;
    output lock;
    output refclk_out;

    wire refclkp;
    wire refclkn;
	 wire reset;
//    wire rxusrclk;
//    wire txusrclk;
//    wire rxusrclk2;
//    wire txusrclk2;
    wire lock;
    wire refclk_out;

	 wire USRCLK_M;
	 wire USRCLK2_M;
//	 wire USRCLK2;
	 wire clk0;
	 wire clkdv2;
	 wire refclkin;

//IBUFGDS_LDT_25 buf1(
//          .I    (refclkp), 
//		    .IB   (refclkn), 
//		    .O    (refclkin));  
//
//DCM dcm0(
//        .CLKFB    (USRCLK_M), 
//        .CLKIN    (refclk_out), 
//        .DSSEN    (1'b0),
//        .PSCLK    (1'b0), 
//        .PSEN     (1'b0), 
//        .PSINCDEC (1'b0), 
//        .RST      (reset),
//    	  .CLK0     (clk0), 
//        .CLK90    (), 
//        .CLK180   (), 
//        .CLK270   (), 
//        .CLK2X    (), 
//        .CLK2X180 (),
//        .CLKDV    (clkdv2), 
//        .CLKFX    (), 
//        .CLKFX180 (), 
//        .LOCKED   (lock), 
//        .PSDONE   (), 
//        .STATUS   ());
//
//BUFG   buf2 (.I (refclkin), .O (refclk_out));

   IBUFGDS #(
      .DIFF_TERM("FALSE"),    // Differential Termination (Virtex-4 only)
      .IBUF_DELAY_VALUE("0"), // Specify the amount of added input delay for the buffer, "0"-"16" (Spartan-3E only)
      .IOSTANDARD("LVDS_25")  // Specify the input I/O standard
   ) buf1 (
      .O(refclk_dcm),  // Clock buffer output
      .I(refclkp),  // Diff_p clock buffer input (connect directly to top-level port)
      .IB(refclkn) // Diff_n clock buffer input (connect directly to top-level port)
   );

DCM dcm0(
        .CLKFB    (USRCLK_M), 
        .CLKIN    (refclk_dcm), 
        .DSSEN    (1'b0),
        .PSCLK    (1'b0), 
        .PSEN     (1'b0), 
        .PSINCDEC (1'b0), 
        .RST      (reset),
    	  .CLK0     (clk0), 
        .CLK90    (), 
        .CLK180   (), 
        .CLK270   (), 
        .CLK2X    (), 
        .CLK2X180 (),
        .CLKDV    (clkdv2), 
        .CLKFX    (), 
        .CLKFX180 (), 
        .LOCKED   (lock), 
        .PSDONE   (), 
        .STATUS   ());

BUFG   buf2 (.I (refclk_dcm), .O (refclk_out));

BUFG   buf3 (.I (clk0), .O (USRCLK_M));
BUFG   buf4 (.I (clkdv2), .O (USRCLK2_M));

//INV    inv1 (.I (USRCLK_M), .O(prerxusrclk));
//INV    inv2 (.I (USRCLK_M), .O(pretxusrclk));
//BUFG   buf4 (.I (prerxusrclk), .O (rxusrclk));
//BUFG   buf5 (.I (pretxusrclk), .O (txusrclk));
//assign rxusrclk2 = USRCLK2;
//assign txusrclk2 = USRCLK2;

endmodule
