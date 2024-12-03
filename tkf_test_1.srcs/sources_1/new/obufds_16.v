`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:30:47 02/03/07
// Design Name:    
// Module Name:    obufds_16
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
module obufds_16(di, do_p, do_n);
    input [15:0] di;
    output [15:0] do_p;
    output [15:0] do_n;

OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst0 (.O(do_p[0]), .OB(do_n[0]),.I(di[0]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst1 (.O(do_p[1]), .OB(do_n[1]),.I(di[1]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst2 (.O(do_p[2]), .OB(do_n[2]),.I(di[2]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst3 (.O(do_p[3]), .OB(do_n[3]),.I(di[3]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst4 (.O(do_p[4]), .OB(do_n[4]),.I(di[4]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst5 (.O(do_p[5]), .OB(do_n[5]),.I(di[5]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst6 (.O(do_p[6]), .OB(do_n[6]),.I(di[6]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst7 (.O(do_p[7]), .OB(do_n[7]),.I(di[7]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst8 (.O(do_p[8]), .OB(do_n[8]),.I(di[8]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst9 (.O(do_p[9]), .OB(do_n[9]),.I(di[9]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst10 (.O(do_p[10]), .OB(do_n[10]),.I(di[10]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst11 (.O(do_p[11]), .OB(do_n[11]),.I(di[11]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst12 (.O(do_p[12]), .OB(do_n[12]),.I(di[12]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst13 (.O(do_p[13]), .OB(do_n[13]),.I(di[13]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst14 (.O(do_p[14]), .OB(do_n[14]),.I(di[14]));
OBUFDS #(.IOSTANDARD("LVDS_25") ) OBUFDS_inst15 (.O(do_p[15]), .OB(do_n[15]),.I(di[15]));


endmodule
