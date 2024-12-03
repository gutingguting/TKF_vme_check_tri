`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    11:54:34 02/04/07
// Design Name:    
// Module Name:    and2_16ch
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
module or2_16ch(i, o);
    input [31:0] i;
    output [15:0] o;

assign o[0]=i[0]||i[1];
assign o[1]=i[2]||i[3];
assign o[2]=i[4]||i[5];
assign o[3]=i[6]||i[7];
assign o[4]=i[8]||i[9];
assign o[5]=i[10]||i[11];
assign o[6]=i[12]||i[13];
assign o[7]=i[14]||i[15];
assign o[8]=i[16]||i[17];
assign o[9]=i[18]||i[19];
assign o[10]=i[20]||i[21];
assign o[11]=i[22]||i[23];
assign o[12]=i[24]||i[25];
assign o[13]=i[26]||i[27];
assign o[14]=i[28]||i[29];
assign o[15]=i[30]||i[31];


endmodule
