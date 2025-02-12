`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:38:49 03/19/07
// Design Name:    
// Module Name:    TSF3_Sector5
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
module TSF3_Sector5(hit9, hit10, hit11, hit12, en, clk, TSF3_sync);
    input [76:1] hit9;
    input [76:1] hit10;
    input [88:1] hit11;
    input [88:1] hit12;
    input en;
    input clk;
   output [56:45] TSF3_sync;

wire [56:45] TSF3;
reg  [56:45] TSF3_sync;

always@(posedge clk)
begin
	if(en)
		begin
			TSF3_sync <= TSF3;
		end
end

assign TSF3[45]= ( 
(( hit12[45] && hit10[39] && hit9[39] ) || 
( hit11[45] && ( ( hit12[45] && hit10[39] ) || ( hit12[45] && hit9[39] ) || ( hit9[39] && hit10[39] ) ) ) )
 || 
 (( hit12[46] && hit10[40] && hit9[39] ) ||
( hit11[45] && ( ( hit12[46] && hit10[40] ) ||( hit12[46] && hit9[39] ) ||( hit9[39] && hit10[40] ) ) ) )
|| 
 (( hit12[46] && hit10[39] && hit9[39] ) ||
( hit11[45] && ( ( hit12[46] && hit10[39] ) ||( hit12[46] && hit9[39] ) ||( hit9[39] && hit10[39] ) ) ) )
|| 
 (( hit12[45] && hit10[39] && hit9[38] ) ||
( hit11[45] && ( ( hit12[45] && hit10[39] ) ||( hit12[45] && hit9[38] ) ||( hit9[38] && hit10[39] ) ) ) )
|| 
 (( hit12[45] && hit10[40] && hit9[39] ) ||
( hit11[45] && ( ( hit12[45] && hit10[40] ) ||( hit12[45] && hit9[39] ) ||( hit9[39] && hit10[40] ) ) ) )
|| 
 (( hit12[46] && hit10[39] && hit9[38] ) ||
( hit11[45] && ( ( hit12[46] && hit10[39] ) ||( hit12[46] && hit9[38] ) ||( hit9[38] && hit10[39] ) ) ) )
|| 
 (( hit12[46] && hit10[40] && hit9[40] ) ||
( hit11[45] && ( ( hit12[46] && hit10[40] ) ||( hit12[46] && hit9[40] ) ||( hit9[40] && hit10[40] ) ) ) )
|| 
 (( hit12[45] && hit10[40] && hit9[40] ) ||
( hit11[45] && ( ( hit12[45] && hit10[40] ) ||( hit12[45] && hit9[40] ) ||( hit9[40] && hit10[40] ) ) ) )
|| 
 (( hit12[45] && hit10[39] && hit9[40] ) ||
( hit11[45] && ( ( hit12[45] && hit10[39] ) ||( hit12[45] && hit9[40] ) ||( hit9[40] && hit10[39] ) ) ) )
|| 
 (( hit12[46] && hit10[40] && hit9[38] ) ||
( hit11[45] && ( ( hit12[46] && hit10[40] ) ||( hit12[46] && hit9[38] ) ||( hit9[38] && hit10[40] ) ) ) )
);
assign TSF3[46]= ( 
(( hit12[46] && hit10[40] && hit9[40] ) || 
( hit11[46] && ( ( hit12[46] && hit10[40] ) || ( hit12[46] && hit9[40] ) || ( hit9[40] && hit10[40] ) ) ) )
 || 
 (( hit12[47] && hit10[40] && hit9[40] ) ||
( hit11[46] && ( ( hit12[47] && hit10[40] ) ||( hit12[47] && hit9[40] ) ||( hit9[40] && hit10[40] ) ) ) )
|| 
 (( hit12[47] && hit10[41] && hit9[40] ) ||
( hit11[46] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[46] && hit10[40] && hit9[39] ) ||
( hit11[46] && ( ( hit12[46] && hit10[40] ) ||( hit12[46] && hit9[39] ) ||( hit9[39] && hit10[40] ) ) ) )
|| 
 (( hit12[47] && hit10[40] && hit9[39] ) ||
( hit11[46] && ( ( hit12[47] && hit10[40] ) ||( hit12[47] && hit9[39] ) ||( hit9[39] && hit10[40] ) ) ) )
|| 
 (( hit12[46] && hit10[41] && hit9[40] ) ||
( hit11[46] && ( ( hit12[46] && hit10[41] ) ||( hit12[46] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[47] && hit10[41] && hit9[41] ) ||
( hit11[46] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[41] ) ||( hit9[41] && hit10[41] ) ) ) )
|| 
 (( hit12[46] && hit10[41] && hit9[41] ) ||
( hit11[46] && ( ( hit12[46] && hit10[41] ) ||( hit12[46] && hit9[41] ) ||( hit9[41] && hit10[41] ) ) ) )
|| 
 (( hit12[46] && hit10[40] && hit9[41] ) ||
( hit11[46] && ( ( hit12[46] && hit10[40] ) ||( hit12[46] && hit9[41] ) ||( hit9[41] && hit10[40] ) ) ) )
|| 
 (( hit12[46] && hit10[39] && hit9[39] ) ||
( hit11[46] && ( ( hit12[46] && hit10[39] ) ||( hit12[46] && hit9[39] ) ||( hit9[39] && hit10[39] ) ) ) )
|| 
 (( hit12[47] && hit10[39] && hit9[39] ) ||
( hit11[46] && ( ( hit12[47] && hit10[39] ) ||( hit12[47] && hit9[39] ) ||( hit9[39] && hit10[39] ) ) ) )
|| 
 (( hit12[47] && hit10[41] && hit9[39] ) ||
( hit11[46] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[39] ) ||( hit9[39] && hit10[41] ) ) ) )
);
assign TSF3[47]= ( 
(( hit12[48] && hit10[41] && hit9[41] ) || 
( hit11[47] && ( ( hit12[48] && hit10[41] ) || ( hit12[48] && hit9[41] ) || ( hit9[41] && hit10[41] ) ) ) )
 || 
 (( hit12[47] && hit10[41] && hit9[40] ) ||
( hit11[47] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[47] && hit10[41] && hit9[41] ) ||
( hit11[47] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[41] ) ||( hit9[41] && hit10[41] ) ) ) )
|| 
 (( hit12[48] && hit10[42] && hit9[41] ) ||
( hit11[47] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[48] && hit10[41] && hit9[40] ) ||
( hit11[47] && ( ( hit12[48] && hit10[41] ) ||( hit12[48] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[47] && hit10[42] && hit9[41] ) ||
( hit11[47] && ( ( hit12[47] && hit10[42] ) ||( hit12[47] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[48] && hit10[42] && hit9[42] ) ||
( hit11[47] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[42] ) ||( hit9[42] && hit10[42] ) ) ) )
|| 
 (( hit12[47] && hit10[40] && hit9[40] ) ||
( hit11[47] && ( ( hit12[47] && hit10[40] ) ||( hit12[47] && hit9[40] ) ||( hit9[40] && hit10[40] ) ) ) )
|| 
 (( hit12[47] && hit10[42] && hit9[42] ) ||
( hit11[47] && ( ( hit12[47] && hit10[42] ) ||( hit12[47] && hit9[42] ) ||( hit9[42] && hit10[42] ) ) ) )
|| 
 (( hit12[48] && hit10[40] && hit9[40] ) ||
( hit11[47] && ( ( hit12[48] && hit10[40] ) ||( hit12[48] && hit9[40] ) ||( hit9[40] && hit10[40] ) ) ) )
|| 
 (( hit12[48] && hit10[41] && hit9[42] ) ||
( hit11[47] && ( ( hit12[48] && hit10[41] ) ||( hit12[48] && hit9[42] ) ||( hit9[42] && hit10[41] ) ) ) )
|| 
 (( hit12[47] && hit10[41] && hit9[42] ) ||
( hit11[47] && ( ( hit12[47] && hit10[41] ) ||( hit12[47] && hit9[42] ) ||( hit9[42] && hit10[41] ) ) ) )
);
assign TSF3[48]= ( 
(( hit12[49] && hit10[42] && hit9[42] ) || 
( hit11[48] && ( ( hit12[49] && hit10[42] ) || ( hit12[49] && hit9[42] ) || ( hit9[42] && hit10[42] ) ) ) )
 || 
 (( hit12[48] && hit10[42] && hit9[41] ) ||
( hit11[48] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[48] && hit10[42] && hit9[42] ) ||
( hit11[48] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[42] ) ||( hit9[42] && hit10[42] ) ) ) )
|| 
 (( hit12[49] && hit10[42] && hit9[41] ) ||
( hit11[48] && ( ( hit12[49] && hit10[42] ) ||( hit12[49] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[49] && hit10[43] && hit9[42] ) ||
( hit11[48] && ( ( hit12[49] && hit10[43] ) ||( hit12[49] && hit9[42] ) ||( hit9[42] && hit10[43] ) ) ) )
|| 
 (( hit12[48] && hit10[41] && hit9[41] ) ||
( hit11[48] && ( ( hit12[48] && hit10[41] ) ||( hit12[48] && hit9[41] ) ||( hit9[41] && hit10[41] ) ) ) )
|| 
 (( hit12[48] && hit10[43] && hit9[42] ) ||
( hit11[48] && ( ( hit12[48] && hit10[43] ) ||( hit12[48] && hit9[42] ) ||( hit9[42] && hit10[43] ) ) ) )
|| 
 (( hit12[49] && hit10[41] && hit9[41] ) ||
( hit11[48] && ( ( hit12[49] && hit10[41] ) ||( hit12[49] && hit9[41] ) ||( hit9[41] && hit10[41] ) ) ) )
|| 
 (( hit12[49] && hit10[43] && hit9[43] ) ||
( hit11[48] && ( ( hit12[49] && hit10[43] ) ||( hit12[49] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[48] && hit10[41] && hit9[40] ) ||
( hit11[48] && ( ( hit12[48] && hit10[41] ) ||( hit12[48] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[48] && hit10[43] && hit9[43] ) ||
( hit11[48] && ( ( hit12[48] && hit10[43] ) ||( hit12[48] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[49] && hit10[41] && hit9[40] ) ||
( hit11[48] && ( ( hit12[49] && hit10[41] ) ||( hit12[49] && hit9[40] ) ||( hit9[40] && hit10[41] ) ) ) )
|| 
 (( hit12[48] && hit10[42] && hit9[40] ) ||
( hit11[48] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[40] ) ||( hit9[40] && hit10[42] ) ) ) )
|| 
 (( hit12[49] && hit10[42] && hit9[40] ) ||
( hit11[48] && ( ( hit12[49] && hit10[42] ) ||( hit12[49] && hit9[40] ) ||( hit9[40] && hit10[42] ) ) ) )
|| 
 (( hit12[49] && hit10[42] && hit9[43] ) ||
( hit11[48] && ( ( hit12[49] && hit10[42] ) ||( hit12[49] && hit9[43] ) ||( hit9[43] && hit10[42] ) ) ) )
|| 
 (( hit12[48] && hit10[42] && hit9[43] ) ||
( hit11[48] && ( ( hit12[48] && hit10[42] ) ||( hit12[48] && hit9[43] ) ||( hit9[43] && hit10[42] ) ) ) )
);
assign TSF3[49]= ( 
(( hit12[49] && hit10[43] && hit9[42] ) || 
( hit11[49] && ( ( hit12[49] && hit10[43] ) || ( hit12[49] && hit9[42] ) || ( hit9[42] && hit10[43] ) ) ) )
 || 
 (( hit12[50] && hit10[43] && hit9[43] ) ||
( hit11[49] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[50] && hit10[43] && hit9[42] ) ||
( hit11[49] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[42] ) ||( hit9[42] && hit10[43] ) ) ) )
|| 
 (( hit12[49] && hit10[43] && hit9[43] ) ||
( hit11[49] && ( ( hit12[49] && hit10[43] ) ||( hit12[49] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[49] && hit10[42] && hit9[42] ) ||
( hit11[49] && ( ( hit12[49] && hit10[42] ) ||( hit12[49] && hit9[42] ) ||( hit9[42] && hit10[42] ) ) ) )
|| 
 (( hit12[50] && hit10[42] && hit9[42] ) ||
( hit11[49] && ( ( hit12[50] && hit10[42] ) ||( hit12[50] && hit9[42] ) ||( hit9[42] && hit10[42] ) ) ) )
|| 
 (( hit12[50] && hit10[44] && hit9[43] ) ||
( hit11[49] && ( ( hit12[50] && hit10[44] ) ||( hit12[50] && hit9[43] ) ||( hit9[43] && hit10[44] ) ) ) )
|| 
 (( hit12[49] && hit10[42] && hit9[41] ) ||
( hit11[49] && ( ( hit12[49] && hit10[42] ) ||( hit12[49] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[49] && hit10[44] && hit9[43] ) ||
( hit11[49] && ( ( hit12[49] && hit10[44] ) ||( hit12[49] && hit9[43] ) ||( hit9[43] && hit10[44] ) ) ) )
|| 
 (( hit12[50] && hit10[42] && hit9[41] ) ||
( hit11[49] && ( ( hit12[50] && hit10[42] ) ||( hit12[50] && hit9[41] ) ||( hit9[41] && hit10[42] ) ) ) )
|| 
 (( hit12[50] && hit10[43] && hit9[41] ) ||
( hit11[49] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[41] ) ||( hit9[41] && hit10[43] ) ) ) )
|| 
 (( hit12[49] && hit10[43] && hit9[41] ) ||
( hit11[49] && ( ( hit12[49] && hit10[43] ) ||( hit12[49] && hit9[41] ) ||( hit9[41] && hit10[43] ) ) ) )
);
assign TSF3[50]= ( 
(( hit12[51] && hit10[44] && hit9[43] ) || 
( hit11[50] && ( ( hit12[51] && hit10[44] ) || ( hit12[51] && hit9[43] ) || ( hit9[43] && hit10[44] ) ) ) )
 || 
 (( hit12[50] && hit10[44] && hit9[43] ) ||
( hit11[50] && ( ( hit12[50] && hit10[44] ) ||( hit12[50] && hit9[43] ) ||( hit9[43] && hit10[44] ) ) ) )
|| 
 (( hit12[50] && hit10[43] && hit9[43] ) ||
( hit11[50] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[51] && hit10[44] && hit9[44] ) ||
( hit11[50] && ( ( hit12[51] && hit10[44] ) ||( hit12[51] && hit9[44] ) ||( hit9[44] && hit10[44] ) ) ) )
|| 
 (( hit12[50] && hit10[44] && hit9[44] ) ||
( hit11[50] && ( ( hit12[50] && hit10[44] ) ||( hit12[50] && hit9[44] ) ||( hit9[44] && hit10[44] ) ) ) )
|| 
 (( hit12[51] && hit10[43] && hit9[43] ) ||
( hit11[50] && ( ( hit12[51] && hit10[43] ) ||( hit12[51] && hit9[43] ) ||( hit9[43] && hit10[43] ) ) ) )
|| 
 (( hit12[50] && hit10[43] && hit9[42] ) ||
( hit11[50] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[42] ) ||( hit9[42] && hit10[43] ) ) ) )
|| 
 (( hit12[51] && hit10[43] && hit9[42] ) ||
( hit11[50] && ( ( hit12[51] && hit10[43] ) ||( hit12[51] && hit9[42] ) ||( hit9[42] && hit10[43] ) ) ) )
|| 
 (( hit12[51] && hit10[45] && hit9[44] ) ||
( hit11[50] && ( ( hit12[51] && hit10[45] ) ||( hit12[51] && hit9[44] ) ||( hit9[44] && hit10[45] ) ) ) )
|| 
 (( hit12[50] && hit10[45] && hit9[44] ) ||
( hit11[50] && ( ( hit12[50] && hit10[45] ) ||( hit12[50] && hit9[44] ) ||( hit9[44] && hit10[45] ) ) ) )
|| 
 (( hit12[51] && hit10[44] && hit9[42] ) ||
( hit11[50] && ( ( hit12[51] && hit10[44] ) ||( hit12[51] && hit9[42] ) ||( hit9[42] && hit10[44] ) ) ) )
|| 
 (( hit12[50] && hit10[43] && hit9[44] ) ||
( hit11[50] && ( ( hit12[50] && hit10[43] ) ||( hit12[50] && hit9[44] ) ||( hit9[44] && hit10[43] ) ) ) )
);
assign TSF3[51]= ( 
(( hit12[52] && hit10[45] && hit9[44] ) || 
( hit11[51] && ( ( hit12[52] && hit10[45] ) || ( hit12[52] && hit9[44] ) || ( hit9[44] && hit10[45] ) ) ) )
 || 
 (( hit12[51] && hit10[44] && hit9[44] ) ||
( hit11[51] && ( ( hit12[51] && hit10[44] ) ||( hit12[51] && hit9[44] ) ||( hit9[44] && hit10[44] ) ) ) )
|| 
 (( hit12[51] && hit10[45] && hit9[44] ) ||
( hit11[51] && ( ( hit12[51] && hit10[45] ) ||( hit12[51] && hit9[44] ) ||( hit9[44] && hit10[45] ) ) ) )
|| 
 (( hit12[52] && hit10[45] && hit9[45] ) ||
( hit11[51] && ( ( hit12[52] && hit10[45] ) ||( hit12[52] && hit9[45] ) ||( hit9[45] && hit10[45] ) ) ) )
|| 
 (( hit12[52] && hit10[44] && hit9[44] ) ||
( hit11[51] && ( ( hit12[52] && hit10[44] ) ||( hit12[52] && hit9[44] ) ||( hit9[44] && hit10[44] ) ) ) )
|| 
 (( hit12[51] && hit10[45] && hit9[45] ) ||
( hit11[51] && ( ( hit12[51] && hit10[45] ) ||( hit12[51] && hit9[45] ) ||( hit9[45] && hit10[45] ) ) ) )
|| 
 (( hit12[51] && hit10[44] && hit9[43] ) ||
( hit11[51] && ( ( hit12[51] && hit10[44] ) ||( hit12[51] && hit9[43] ) ||( hit9[43] && hit10[44] ) ) ) )
|| 
 (( hit12[52] && hit10[44] && hit9[43] ) ||
( hit11[51] && ( ( hit12[52] && hit10[44] ) ||( hit12[52] && hit9[43] ) ||( hit9[43] && hit10[44] ) ) ) )
|| 
 (( hit12[52] && hit10[45] && hit9[43] ) ||
( hit11[51] && ( ( hit12[52] && hit10[45] ) ||( hit12[52] && hit9[43] ) ||( hit9[43] && hit10[45] ) ) ) )
|| 
 (( hit12[51] && hit10[44] && hit9[45] ) ||
( hit11[51] && ( ( hit12[51] && hit10[44] ) ||( hit12[51] && hit9[45] ) ||( hit9[45] && hit10[44] ) ) ) )
);
assign TSF3[52]= ( 
(( hit12[52] && hit10[45] && hit9[45] ) || 
( hit11[52] && ( ( hit12[52] && hit10[45] ) || ( hit12[52] && hit9[45] ) || ( hit9[45] && hit10[45] ) ) ) )
 || 
 (( hit12[53] && hit10[46] && hit9[45] ) ||
( hit11[52] && ( ( hit12[53] && hit10[46] ) ||( hit12[53] && hit9[45] ) ||( hit9[45] && hit10[46] ) ) ) )
|| 
 (( hit12[53] && hit10[45] && hit9[45] ) ||
( hit11[52] && ( ( hit12[53] && hit10[45] ) ||( hit12[53] && hit9[45] ) ||( hit9[45] && hit10[45] ) ) ) )
|| 
 (( hit12[52] && hit10[46] && hit9[45] ) ||
( hit11[52] && ( ( hit12[52] && hit10[46] ) ||( hit12[52] && hit9[45] ) ||( hit9[45] && hit10[46] ) ) ) )
|| 
 (( hit12[52] && hit10[45] && hit9[44] ) ||
( hit11[52] && ( ( hit12[52] && hit10[45] ) ||( hit12[52] && hit9[44] ) ||( hit9[44] && hit10[45] ) ) ) )
|| 
 (( hit12[53] && hit10[46] && hit9[46] ) ||
( hit11[52] && ( ( hit12[53] && hit10[46] ) ||( hit12[53] && hit9[46] ) ||( hit9[46] && hit10[46] ) ) ) )
|| 
 (( hit12[53] && hit10[45] && hit9[44] ) ||
( hit11[52] && ( ( hit12[53] && hit10[45] ) ||( hit12[53] && hit9[44] ) ||( hit9[44] && hit10[45] ) ) ) )
|| 
 (( hit12[52] && hit10[46] && hit9[46] ) ||
( hit11[52] && ( ( hit12[52] && hit10[46] ) ||( hit12[52] && hit9[46] ) ||( hit9[46] && hit10[46] ) ) ) )
|| 
 (( hit12[52] && hit10[45] && hit9[46] ) ||
( hit11[52] && ( ( hit12[52] && hit10[45] ) ||( hit12[52] && hit9[46] ) ||( hit9[46] && hit10[45] ) ) ) )
|| 
 (( hit12[53] && hit10[46] && hit9[44] ) ||
( hit11[52] && ( ( hit12[53] && hit10[46] ) ||( hit12[53] && hit9[44] ) ||( hit9[44] && hit10[46] ) ) ) )
);
assign TSF3[53]= ( 
(( hit12[53] && hit10[46] && hit9[46] ) || 
( hit11[53] && ( ( hit12[53] && hit10[46] ) || ( hit12[53] && hit9[46] ) || ( hit9[46] && hit10[46] ) ) ) )
 || 
 (( hit12[54] && hit10[47] && hit9[46] ) ||
( hit11[53] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
|| 
 (( hit12[54] && hit10[46] && hit9[46] ) ||
( hit11[53] && ( ( hit12[54] && hit10[46] ) ||( hit12[54] && hit9[46] ) ||( hit9[46] && hit10[46] ) ) ) )
|| 
 (( hit12[53] && hit10[46] && hit9[45] ) ||
( hit11[53] && ( ( hit12[53] && hit10[46] ) ||( hit12[53] && hit9[45] ) ||( hit9[45] && hit10[46] ) ) ) )
|| 
 (( hit12[53] && hit10[47] && hit9[46] ) ||
( hit11[53] && ( ( hit12[53] && hit10[47] ) ||( hit12[53] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
|| 
 (( hit12[54] && hit10[46] && hit9[45] ) ||
( hit11[53] && ( ( hit12[54] && hit10[46] ) ||( hit12[54] && hit9[45] ) ||( hit9[45] && hit10[46] ) ) ) )
|| 
 (( hit12[54] && hit10[47] && hit9[47] ) ||
( hit11[53] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[47] ) ||( hit9[47] && hit10[47] ) ) ) )
|| 
 (( hit12[53] && hit10[47] && hit9[47] ) ||
( hit11[53] && ( ( hit12[53] && hit10[47] ) ||( hit12[53] && hit9[47] ) ||( hit9[47] && hit10[47] ) ) ) )
|| 
 (( hit12[53] && hit10[46] && hit9[47] ) ||
( hit11[53] && ( ( hit12[53] && hit10[46] ) ||( hit12[53] && hit9[47] ) ||( hit9[47] && hit10[46] ) ) ) )
|| 
 (( hit12[54] && hit10[47] && hit9[45] ) ||
( hit11[53] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[45] ) ||( hit9[45] && hit10[47] ) ) ) )
|| 
 (( hit12[53] && hit10[45] && hit9[45] ) ||
( hit11[53] && ( ( hit12[53] && hit10[45] ) ||( hit12[53] && hit9[45] ) ||( hit9[45] && hit10[45] ) ) ) )
);
assign TSF3[54]= ( 
(( hit12[55] && hit10[47] && hit9[47] ) || 
( hit11[54] && ( ( hit12[55] && hit10[47] ) || ( hit12[55] && hit9[47] ) || ( hit9[47] && hit10[47] ) ) ) )
 || 
 (( hit12[54] && hit10[47] && hit9[47] ) ||
( hit11[54] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[47] ) ||( hit9[47] && hit10[47] ) ) ) )
|| 
 (( hit12[54] && hit10[47] && hit9[46] ) ||
( hit11[54] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
|| 
 (( hit12[55] && hit10[48] && hit9[47] ) ||
( hit11[54] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[47] && hit9[46] ) ||
( hit11[54] && ( ( hit12[55] && hit10[47] ) ||( hit12[55] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
|| 
 (( hit12[54] && hit10[48] && hit9[47] ) ||
( hit11[54] && ( ( hit12[54] && hit10[48] ) ||( hit12[54] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[48] && hit9[48] ) ||
( hit11[54] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[48] ) ||( hit9[48] && hit10[48] ) ) ) )
|| 
 (( hit12[54] && hit10[48] && hit9[48] ) ||
( hit11[54] && ( ( hit12[54] && hit10[48] ) ||( hit12[54] && hit9[48] ) ||( hit9[48] && hit10[48] ) ) ) )
|| 
 (( hit12[54] && hit10[46] && hit9[46] ) ||
( hit11[54] && ( ( hit12[54] && hit10[46] ) ||( hit12[54] && hit9[46] ) ||( hit9[46] && hit10[46] ) ) ) )
|| 
 (( hit12[55] && hit10[46] && hit9[46] ) ||
( hit11[54] && ( ( hit12[55] && hit10[46] ) ||( hit12[55] && hit9[46] ) ||( hit9[46] && hit10[46] ) ) ) )
|| 
 (( hit12[54] && hit10[47] && hit9[48] ) ||
( hit11[54] && ( ( hit12[54] && hit10[47] ) ||( hit12[54] && hit9[48] ) ||( hit9[48] && hit10[47] ) ) ) )
|| 
 (( hit12[55] && hit10[47] && hit9[48] ) ||
( hit11[54] && ( ( hit12[55] && hit10[47] ) ||( hit12[55] && hit9[48] ) ||( hit9[48] && hit10[47] ) ) ) )
);
assign TSF3[55]= ( 
(( hit12[56] && hit10[48] && hit9[48] ) || 
( hit11[55] && ( ( hit12[56] && hit10[48] ) || ( hit12[56] && hit9[48] ) || ( hit9[48] && hit10[48] ) ) ) )
 || 
 (( hit12[55] && hit10[48] && hit9[47] ) ||
( hit11[55] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[48] && hit9[48] ) ||
( hit11[55] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[48] ) ||( hit9[48] && hit10[48] ) ) ) )
|| 
 (( hit12[56] && hit10[48] && hit9[47] ) ||
( hit11[55] && ( ( hit12[56] && hit10[48] ) ||( hit12[56] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[56] && hit10[49] && hit9[48] ) ||
( hit11[55] && ( ( hit12[56] && hit10[49] ) ||( hit12[56] && hit9[48] ) ||( hit9[48] && hit10[49] ) ) ) )
|| 
 (( hit12[55] && hit10[47] && hit9[47] ) ||
( hit11[55] && ( ( hit12[55] && hit10[47] ) ||( hit12[55] && hit9[47] ) ||( hit9[47] && hit10[47] ) ) ) )
|| 
 (( hit12[55] && hit10[49] && hit9[48] ) ||
( hit11[55] && ( ( hit12[55] && hit10[49] ) ||( hit12[55] && hit9[48] ) ||( hit9[48] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[47] && hit9[47] ) ||
( hit11[55] && ( ( hit12[56] && hit10[47] ) ||( hit12[56] && hit9[47] ) ||( hit9[47] && hit10[47] ) ) ) )
|| 
 (( hit12[56] && hit10[49] && hit9[49] ) ||
( hit11[55] && ( ( hit12[56] && hit10[49] ) ||( hit12[56] && hit9[49] ) ||( hit9[49] && hit10[49] ) ) ) )
|| 
 (( hit12[55] && hit10[49] && hit9[49] ) ||
( hit11[55] && ( ( hit12[55] && hit10[49] ) ||( hit12[55] && hit9[49] ) ||( hit9[49] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[48] && hit9[49] ) ||
( hit11[55] && ( ( hit12[56] && hit10[48] ) ||( hit12[56] && hit9[49] ) ||( hit9[49] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[48] && hit9[49] ) ||
( hit11[55] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[49] ) ||( hit9[49] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[48] && hit9[46] ) ||
( hit11[55] && ( ( hit12[55] && hit10[48] ) ||( hit12[55] && hit9[46] ) ||( hit9[46] && hit10[48] ) ) ) )
|| 
 (( hit12[55] && hit10[47] && hit9[46] ) ||
( hit11[55] && ( ( hit12[55] && hit10[47] ) ||( hit12[55] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
|| 
 (( hit12[56] && hit10[48] && hit9[46] ) ||
( hit11[55] && ( ( hit12[56] && hit10[48] ) ||( hit12[56] && hit9[46] ) ||( hit9[46] && hit10[48] ) ) ) )
|| 
 (( hit12[56] && hit10[47] && hit9[46] ) ||
( hit11[55] && ( ( hit12[56] && hit10[47] ) ||( hit12[56] && hit9[46] ) ||( hit9[46] && hit10[47] ) ) ) )
);
assign TSF3[56]= ( 
(( hit12[56] && hit10[49] && hit9[48] ) || 
( hit11[56] && ( ( hit12[56] && hit10[49] ) || ( hit12[56] && hit9[48] ) || ( hit9[48] && hit10[49] ) ) ) )
 || 
 (( hit12[57] && hit10[49] && hit9[49] ) ||
( hit11[56] && ( ( hit12[57] && hit10[49] ) ||( hit12[57] && hit9[49] ) ||( hit9[49] && hit10[49] ) ) ) )
|| 
 (( hit12[57] && hit10[49] && hit9[48] ) ||
( hit11[56] && ( ( hit12[57] && hit10[49] ) ||( hit12[57] && hit9[48] ) ||( hit9[48] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[49] && hit9[49] ) ||
( hit11[56] && ( ( hit12[56] && hit10[49] ) ||( hit12[56] && hit9[49] ) ||( hit9[49] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[48] && hit9[48] ) ||
( hit11[56] && ( ( hit12[56] && hit10[48] ) ||( hit12[56] && hit9[48] ) ||( hit9[48] && hit10[48] ) ) ) )
|| 
 (( hit12[57] && hit10[48] && hit9[48] ) ||
( hit11[56] && ( ( hit12[57] && hit10[48] ) ||( hit12[57] && hit9[48] ) ||( hit9[48] && hit10[48] ) ) ) )
|| 
 (( hit12[57] && hit10[50] && hit9[49] ) ||
( hit11[56] && ( ( hit12[57] && hit10[50] ) ||( hit12[57] && hit9[49] ) ||( hit9[49] && hit10[50] ) ) ) )
|| 
 (( hit12[56] && hit10[50] && hit9[49] ) ||
( hit11[56] && ( ( hit12[56] && hit10[50] ) ||( hit12[56] && hit9[49] ) ||( hit9[49] && hit10[50] ) ) ) )
|| 
 (( hit12[56] && hit10[48] && hit9[47] ) ||
( hit11[56] && ( ( hit12[56] && hit10[48] ) ||( hit12[56] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[57] && hit10[48] && hit9[47] ) ||
( hit11[56] && ( ( hit12[57] && hit10[48] ) ||( hit12[57] && hit9[47] ) ||( hit9[47] && hit10[48] ) ) ) )
|| 
 (( hit12[57] && hit10[50] && hit9[50] ) ||
( hit11[56] && ( ( hit12[57] && hit10[50] ) ||( hit12[57] && hit9[50] ) ||( hit9[50] && hit10[50] ) ) ) )
|| 
 (( hit12[57] && hit10[49] && hit9[50] ) ||
( hit11[56] && ( ( hit12[57] && hit10[49] ) ||( hit12[57] && hit9[50] ) ||( hit9[50] && hit10[49] ) ) ) )
|| 
 (( hit12[57] && hit10[49] && hit9[47] ) ||
( hit11[56] && ( ( hit12[57] && hit10[49] ) ||( hit12[57] && hit9[47] ) ||( hit9[47] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[49] && hit9[47] ) ||
( hit11[56] && ( ( hit12[56] && hit10[49] ) ||( hit12[56] && hit9[47] ) ||( hit9[47] && hit10[49] ) ) ) )
|| 
 (( hit12[56] && hit10[50] && hit9[50] ) ||
( hit11[56] && ( ( hit12[56] && hit10[50] ) ||( hit12[56] && hit9[50] ) ||( hit9[50] && hit10[50] ) ) ) )
|| 
 (( hit12[56] && hit10[49] && hit9[50] ) ||
( hit11[56] && ( ( hit12[56] && hit10[49] ) ||( hit12[56] && hit9[50] ) ||( hit9[50] && hit10[49] ) ) ) )
);

endmodule
