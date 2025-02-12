`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:38:49 03/19/07
// Design Name:    
// Module Name:    TSF3_Sector7
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
module TSF3_Sector7(hit9, hit10, hit11, hit12, en, clk, TSF3_sync);
    input [76:1] hit9;
    input [76:1] hit10;
    input [88:1] hit11;
    input [88:1] hit12;
    input en;
    input clk;
   output [76:65] TSF3_sync;

wire [76:65] TSF3;
reg  [76:65] TSF3_sync;

always@(posedge clk)
begin
	if(en)
		begin
			TSF3_sync <= TSF3;
		end
end

assign TSF3[65]= ( 
(( hit12[66] && hit10[57] && hit9[56] ) || 
( hit11[65] && ( ( hit12[66] && hit10[57] ) || ( hit12[66] && hit9[56] ) || ( hit9[56] && hit10[57] ) ) ) )
 || 
 (( hit12[65] && hit10[56] && hit9[56] ) ||
( hit11[65] && ( ( hit12[65] && hit10[56] ) ||( hit12[65] && hit9[56] ) ||( hit9[56] && hit10[56] ) ) ) )
|| 
 (( hit12[65] && hit10[57] && hit9[56] ) ||
( hit11[65] && ( ( hit12[65] && hit10[57] ) ||( hit12[65] && hit9[56] ) ||( hit9[56] && hit10[57] ) ) ) )
|| 
 (( hit12[66] && hit10[57] && hit9[57] ) ||
( hit11[65] && ( ( hit12[66] && hit10[57] ) ||( hit12[66] && hit9[57] ) ||( hit9[57] && hit10[57] ) ) ) )
|| 
 (( hit12[65] && hit10[57] && hit9[57] ) ||
( hit11[65] && ( ( hit12[65] && hit10[57] ) ||( hit12[65] && hit9[57] ) ||( hit9[57] && hit10[57] ) ) ) )
|| 
 (( hit12[66] && hit10[56] && hit9[56] ) ||
( hit11[65] && ( ( hit12[66] && hit10[56] ) ||( hit12[66] && hit9[56] ) ||( hit9[56] && hit10[56] ) ) ) )
|| 
 (( hit12[65] && hit10[56] && hit9[55] ) ||
( hit11[65] && ( ( hit12[65] && hit10[56] ) ||( hit12[65] && hit9[55] ) ||( hit9[55] && hit10[56] ) ) ) )
|| 
 (( hit12[66] && hit10[56] && hit9[55] ) ||
( hit11[65] && ( ( hit12[66] && hit10[56] ) ||( hit12[66] && hit9[55] ) ||( hit9[55] && hit10[56] ) ) ) )
|| 
 (( hit12[66] && hit10[58] && hit9[57] ) ||
( hit11[65] && ( ( hit12[66] && hit10[58] ) ||( hit12[66] && hit9[57] ) ||( hit9[57] && hit10[58] ) ) ) )
|| 
 (( hit12[65] && hit10[58] && hit9[57] ) ||
( hit11[65] && ( ( hit12[65] && hit10[58] ) ||( hit12[65] && hit9[57] ) ||( hit9[57] && hit10[58] ) ) ) )
|| 
 (( hit12[66] && hit10[57] && hit9[55] ) ||
( hit11[65] && ( ( hit12[66] && hit10[57] ) ||( hit12[66] && hit9[55] ) ||( hit9[55] && hit10[57] ) ) ) )
|| 
 (( hit12[65] && hit10[56] && hit9[57] ) ||
( hit11[65] && ( ( hit12[65] && hit10[56] ) ||( hit12[65] && hit9[57] ) ||( hit9[57] && hit10[56] ) ) ) )
);
assign TSF3[66]= ( 
(( hit12[67] && hit10[58] && hit9[57] ) || 
( hit11[66] && ( ( hit12[67] && hit10[58] ) || ( hit12[67] && hit9[57] ) || ( hit9[57] && hit10[58] ) ) ) )
 || 
 (( hit12[66] && hit10[57] && hit9[57] ) ||
( hit11[66] && ( ( hit12[66] && hit10[57] ) ||( hit12[66] && hit9[57] ) ||( hit9[57] && hit10[57] ) ) ) )
|| 
 (( hit12[66] && hit10[58] && hit9[57] ) ||
( hit11[66] && ( ( hit12[66] && hit10[58] ) ||( hit12[66] && hit9[57] ) ||( hit9[57] && hit10[58] ) ) ) )
|| 
 (( hit12[67] && hit10[58] && hit9[58] ) ||
( hit11[66] && ( ( hit12[67] && hit10[58] ) ||( hit12[67] && hit9[58] ) ||( hit9[58] && hit10[58] ) ) ) )
|| 
 (( hit12[67] && hit10[57] && hit9[57] ) ||
( hit11[66] && ( ( hit12[67] && hit10[57] ) ||( hit12[67] && hit9[57] ) ||( hit9[57] && hit10[57] ) ) ) )
|| 
 (( hit12[66] && hit10[57] && hit9[56] ) ||
( hit11[66] && ( ( hit12[66] && hit10[57] ) ||( hit12[66] && hit9[56] ) ||( hit9[56] && hit10[57] ) ) ) )
|| 
 (( hit12[66] && hit10[58] && hit9[58] ) ||
( hit11[66] && ( ( hit12[66] && hit10[58] ) ||( hit12[66] && hit9[58] ) ||( hit9[58] && hit10[58] ) ) ) )
|| 
 (( hit12[67] && hit10[57] && hit9[56] ) ||
( hit11[66] && ( ( hit12[67] && hit10[57] ) ||( hit12[67] && hit9[56] ) ||( hit9[56] && hit10[57] ) ) ) )
|| 
 (( hit12[67] && hit10[58] && hit9[56] ) ||
( hit11[66] && ( ( hit12[67] && hit10[58] ) ||( hit12[67] && hit9[56] ) ||( hit9[56] && hit10[58] ) ) ) )
|| 
 (( hit12[66] && hit10[57] && hit9[58] ) ||
( hit11[66] && ( ( hit12[66] && hit10[57] ) ||( hit12[66] && hit9[58] ) ||( hit9[58] && hit10[57] ) ) ) )
);
assign TSF3[67]= ( 
(( hit12[67] && hit10[58] && hit9[58] ) || 
( hit11[67] && ( ( hit12[67] && hit10[58] ) || ( hit12[67] && hit9[58] ) || ( hit9[58] && hit10[58] ) ) ) )
 || 
 (( hit12[68] && hit10[59] && hit9[58] ) ||
( hit11[67] && ( ( hit12[68] && hit10[59] ) ||( hit12[68] && hit9[58] ) ||( hit9[58] && hit10[59] ) ) ) )
|| 
 (( hit12[68] && hit10[58] && hit9[58] ) ||
( hit11[67] && ( ( hit12[68] && hit10[58] ) ||( hit12[68] && hit9[58] ) ||( hit9[58] && hit10[58] ) ) ) )
|| 
 (( hit12[67] && hit10[58] && hit9[57] ) ||
( hit11[67] && ( ( hit12[67] && hit10[58] ) ||( hit12[67] && hit9[57] ) ||( hit9[57] && hit10[58] ) ) ) )
|| 
 (( hit12[67] && hit10[59] && hit9[58] ) ||
( hit11[67] && ( ( hit12[67] && hit10[59] ) ||( hit12[67] && hit9[58] ) ||( hit9[58] && hit10[59] ) ) ) )
|| 
 (( hit12[68] && hit10[58] && hit9[57] ) ||
( hit11[67] && ( ( hit12[68] && hit10[58] ) ||( hit12[68] && hit9[57] ) ||( hit9[57] && hit10[58] ) ) ) )
|| 
 (( hit12[68] && hit10[59] && hit9[59] ) ||
( hit11[67] && ( ( hit12[68] && hit10[59] ) ||( hit12[68] && hit9[59] ) ||( hit9[59] && hit10[59] ) ) ) )
|| 
 (( hit12[67] && hit10[59] && hit9[59] ) ||
( hit11[67] && ( ( hit12[67] && hit10[59] ) ||( hit12[67] && hit9[59] ) ||( hit9[59] && hit10[59] ) ) ) )
|| 
 (( hit12[67] && hit10[58] && hit9[59] ) ||
( hit11[67] && ( ( hit12[67] && hit10[58] ) ||( hit12[67] && hit9[59] ) ||( hit9[59] && hit10[58] ) ) ) )
|| 
 (( hit12[68] && hit10[59] && hit9[57] ) ||
( hit11[67] && ( ( hit12[68] && hit10[59] ) ||( hit12[68] && hit9[57] ) ||( hit9[57] && hit10[59] ) ) ) )
);
assign TSF3[68]= ( 
(( hit12[68] && hit10[59] && hit9[59] ) || 
( hit11[68] && ( ( hit12[68] && hit10[59] ) || ( hit12[68] && hit9[59] ) || ( hit9[59] && hit10[59] ) ) ) )
 || 
 (( hit12[69] && hit10[59] && hit9[59] ) ||
( hit11[68] && ( ( hit12[69] && hit10[59] ) ||( hit12[69] && hit9[59] ) ||( hit9[59] && hit10[59] ) ) ) )
|| 
 (( hit12[69] && hit10[60] && hit9[59] ) ||
( hit11[68] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[68] && hit10[59] && hit9[58] ) ||
( hit11[68] && ( ( hit12[68] && hit10[59] ) ||( hit12[68] && hit9[58] ) ||( hit9[58] && hit10[59] ) ) ) )
|| 
 (( hit12[69] && hit10[59] && hit9[58] ) ||
( hit11[68] && ( ( hit12[69] && hit10[59] ) ||( hit12[69] && hit9[58] ) ||( hit9[58] && hit10[59] ) ) ) )
|| 
 (( hit12[68] && hit10[60] && hit9[59] ) ||
( hit11[68] && ( ( hit12[68] && hit10[60] ) ||( hit12[68] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[69] && hit10[60] && hit9[60] ) ||
( hit11[68] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[60] ) ||( hit9[60] && hit10[60] ) ) ) )
|| 
 (( hit12[68] && hit10[60] && hit9[60] ) ||
( hit11[68] && ( ( hit12[68] && hit10[60] ) ||( hit12[68] && hit9[60] ) ||( hit9[60] && hit10[60] ) ) ) )
|| 
 (( hit12[68] && hit10[59] && hit9[60] ) ||
( hit11[68] && ( ( hit12[68] && hit10[59] ) ||( hit12[68] && hit9[60] ) ||( hit9[60] && hit10[59] ) ) ) )
|| 
 (( hit12[68] && hit10[58] && hit9[58] ) ||
( hit11[68] && ( ( hit12[68] && hit10[58] ) ||( hit12[68] && hit9[58] ) ||( hit9[58] && hit10[58] ) ) ) )
|| 
 (( hit12[69] && hit10[58] && hit9[58] ) ||
( hit11[68] && ( ( hit12[69] && hit10[58] ) ||( hit12[69] && hit9[58] ) ||( hit9[58] && hit10[58] ) ) ) )
|| 
 (( hit12[69] && hit10[60] && hit9[58] ) ||
( hit11[68] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[58] ) ||( hit9[58] && hit10[60] ) ) ) )
);
assign TSF3[69]= ( 
(( hit12[70] && hit10[60] && hit9[60] ) || 
( hit11[69] && ( ( hit12[70] && hit10[60] ) || ( hit12[70] && hit9[60] ) || ( hit9[60] && hit10[60] ) ) ) )
 || 
 (( hit12[69] && hit10[60] && hit9[59] ) ||
( hit11[69] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[69] && hit10[60] && hit9[60] ) ||
( hit11[69] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[60] ) ||( hit9[60] && hit10[60] ) ) ) )
|| 
 (( hit12[70] && hit10[61] && hit9[60] ) ||
( hit11[69] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[70] && hit10[60] && hit9[59] ) ||
( hit11[69] && ( ( hit12[70] && hit10[60] ) ||( hit12[70] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[69] && hit10[61] && hit9[60] ) ||
( hit11[69] && ( ( hit12[69] && hit10[61] ) ||( hit12[69] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[70] && hit10[61] && hit9[61] ) ||
( hit11[69] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[61] ) ||( hit9[61] && hit10[61] ) ) ) )
|| 
 (( hit12[69] && hit10[59] && hit9[59] ) ||
( hit11[69] && ( ( hit12[69] && hit10[59] ) ||( hit12[69] && hit9[59] ) ||( hit9[59] && hit10[59] ) ) ) )
|| 
 (( hit12[69] && hit10[61] && hit9[61] ) ||
( hit11[69] && ( ( hit12[69] && hit10[61] ) ||( hit12[69] && hit9[61] ) ||( hit9[61] && hit10[61] ) ) ) )
|| 
 (( hit12[70] && hit10[59] && hit9[59] ) ||
( hit11[69] && ( ( hit12[70] && hit10[59] ) ||( hit12[70] && hit9[59] ) ||( hit9[59] && hit10[59] ) ) ) )
|| 
 (( hit12[70] && hit10[60] && hit9[61] ) ||
( hit11[69] && ( ( hit12[70] && hit10[60] ) ||( hit12[70] && hit9[61] ) ||( hit9[61] && hit10[60] ) ) ) )
|| 
 (( hit12[69] && hit10[60] && hit9[61] ) ||
( hit11[69] && ( ( hit12[69] && hit10[60] ) ||( hit12[69] && hit9[61] ) ||( hit9[61] && hit10[60] ) ) ) )
);
assign TSF3[70]= ( 
(( hit12[71] && hit10[61] && hit9[61] ) || 
( hit11[70] && ( ( hit12[71] && hit10[61] ) || ( hit12[71] && hit9[61] ) || ( hit9[61] && hit10[61] ) ) ) )
 || 
 (( hit12[70] && hit10[61] && hit9[60] ) ||
( hit11[70] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[70] && hit10[61] && hit9[61] ) ||
( hit11[70] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[61] ) ||( hit9[61] && hit10[61] ) ) ) )
|| 
 (( hit12[71] && hit10[61] && hit9[60] ) ||
( hit11[70] && ( ( hit12[71] && hit10[61] ) ||( hit12[71] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[71] && hit10[62] && hit9[61] ) ||
( hit11[70] && ( ( hit12[71] && hit10[62] ) ||( hit12[71] && hit9[61] ) ||( hit9[61] && hit10[62] ) ) ) )
|| 
 (( hit12[70] && hit10[60] && hit9[60] ) ||
( hit11[70] && ( ( hit12[70] && hit10[60] ) ||( hit12[70] && hit9[60] ) ||( hit9[60] && hit10[60] ) ) ) )
|| 
 (( hit12[70] && hit10[62] && hit9[61] ) ||
( hit11[70] && ( ( hit12[70] && hit10[62] ) ||( hit12[70] && hit9[61] ) ||( hit9[61] && hit10[62] ) ) ) )
|| 
 (( hit12[71] && hit10[60] && hit9[60] ) ||
( hit11[70] && ( ( hit12[71] && hit10[60] ) ||( hit12[71] && hit9[60] ) ||( hit9[60] && hit10[60] ) ) ) )
|| 
 (( hit12[71] && hit10[62] && hit9[62] ) ||
( hit11[70] && ( ( hit12[71] && hit10[62] ) ||( hit12[71] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[70] && hit10[60] && hit9[59] ) ||
( hit11[70] && ( ( hit12[70] && hit10[60] ) ||( hit12[70] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[70] && hit10[62] && hit9[62] ) ||
( hit11[70] && ( ( hit12[70] && hit10[62] ) ||( hit12[70] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[71] && hit10[60] && hit9[59] ) ||
( hit11[70] && ( ( hit12[71] && hit10[60] ) ||( hit12[71] && hit9[59] ) ||( hit9[59] && hit10[60] ) ) ) )
|| 
 (( hit12[70] && hit10[61] && hit9[59] ) ||
( hit11[70] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[59] ) ||( hit9[59] && hit10[61] ) ) ) )
|| 
 (( hit12[71] && hit10[61] && hit9[59] ) ||
( hit11[70] && ( ( hit12[71] && hit10[61] ) ||( hit12[71] && hit9[59] ) ||( hit9[59] && hit10[61] ) ) ) )
|| 
 (( hit12[71] && hit10[61] && hit9[62] ) ||
( hit11[70] && ( ( hit12[71] && hit10[61] ) ||( hit12[71] && hit9[62] ) ||( hit9[62] && hit10[61] ) ) ) )
|| 
 (( hit12[70] && hit10[61] && hit9[62] ) ||
( hit11[70] && ( ( hit12[70] && hit10[61] ) ||( hit12[70] && hit9[62] ) ||( hit9[62] && hit10[61] ) ) ) )
);
assign TSF3[71]= ( 
(( hit12[71] && hit10[62] && hit9[61] ) || 
( hit11[71] && ( ( hit12[71] && hit10[62] ) || ( hit12[71] && hit9[61] ) || ( hit9[61] && hit10[62] ) ) ) )
 || 
 (( hit12[72] && hit10[62] && hit9[62] ) ||
( hit11[71] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[72] && hit10[62] && hit9[61] ) ||
( hit11[71] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[61] ) ||( hit9[61] && hit10[62] ) ) ) )
|| 
 (( hit12[71] && hit10[62] && hit9[62] ) ||
( hit11[71] && ( ( hit12[71] && hit10[62] ) ||( hit12[71] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[71] && hit10[61] && hit9[61] ) ||
( hit11[71] && ( ( hit12[71] && hit10[61] ) ||( hit12[71] && hit9[61] ) ||( hit9[61] && hit10[61] ) ) ) )
|| 
 (( hit12[72] && hit10[61] && hit9[61] ) ||
( hit11[71] && ( ( hit12[72] && hit10[61] ) ||( hit12[72] && hit9[61] ) ||( hit9[61] && hit10[61] ) ) ) )
|| 
 (( hit12[72] && hit10[63] && hit9[62] ) ||
( hit11[71] && ( ( hit12[72] && hit10[63] ) ||( hit12[72] && hit9[62] ) ||( hit9[62] && hit10[63] ) ) ) )
|| 
 (( hit12[71] && hit10[61] && hit9[60] ) ||
( hit11[71] && ( ( hit12[71] && hit10[61] ) ||( hit12[71] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[71] && hit10[63] && hit9[62] ) ||
( hit11[71] && ( ( hit12[71] && hit10[63] ) ||( hit12[71] && hit9[62] ) ||( hit9[62] && hit10[63] ) ) ) )
|| 
 (( hit12[72] && hit10[61] && hit9[60] ) ||
( hit11[71] && ( ( hit12[72] && hit10[61] ) ||( hit12[72] && hit9[60] ) ||( hit9[60] && hit10[61] ) ) ) )
|| 
 (( hit12[72] && hit10[62] && hit9[60] ) ||
( hit11[71] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[60] ) ||( hit9[60] && hit10[62] ) ) ) )
|| 
 (( hit12[71] && hit10[62] && hit9[60] ) ||
( hit11[71] && ( ( hit12[71] && hit10[62] ) ||( hit12[71] && hit9[60] ) ||( hit9[60] && hit10[62] ) ) ) )
);
assign TSF3[72]= ( 
(( hit12[73] && hit10[63] && hit9[62] ) || 
( hit11[72] && ( ( hit12[73] && hit10[63] ) || ( hit12[73] && hit9[62] ) || ( hit9[62] && hit10[63] ) ) ) )
 || 
 (( hit12[72] && hit10[63] && hit9[62] ) ||
( hit11[72] && ( ( hit12[72] && hit10[63] ) ||( hit12[72] && hit9[62] ) ||( hit9[62] && hit10[63] ) ) ) )
|| 
 (( hit12[72] && hit10[62] && hit9[62] ) ||
( hit11[72] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[73] && hit10[63] && hit9[63] ) ||
( hit11[72] && ( ( hit12[73] && hit10[63] ) ||( hit12[73] && hit9[63] ) ||( hit9[63] && hit10[63] ) ) ) )
|| 
 (( hit12[72] && hit10[63] && hit9[63] ) ||
( hit11[72] && ( ( hit12[72] && hit10[63] ) ||( hit12[72] && hit9[63] ) ||( hit9[63] && hit10[63] ) ) ) )
|| 
 (( hit12[73] && hit10[62] && hit9[62] ) ||
( hit11[72] && ( ( hit12[73] && hit10[62] ) ||( hit12[73] && hit9[62] ) ||( hit9[62] && hit10[62] ) ) ) )
|| 
 (( hit12[72] && hit10[62] && hit9[61] ) ||
( hit11[72] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[61] ) ||( hit9[61] && hit10[62] ) ) ) )
|| 
 (( hit12[73] && hit10[62] && hit9[61] ) ||
( hit11[72] && ( ( hit12[73] && hit10[62] ) ||( hit12[73] && hit9[61] ) ||( hit9[61] && hit10[62] ) ) ) )
|| 
 (( hit12[73] && hit10[64] && hit9[63] ) ||
( hit11[72] && ( ( hit12[73] && hit10[64] ) ||( hit12[73] && hit9[63] ) ||( hit9[63] && hit10[64] ) ) ) )
|| 
 (( hit12[72] && hit10[64] && hit9[63] ) ||
( hit11[72] && ( ( hit12[72] && hit10[64] ) ||( hit12[72] && hit9[63] ) ||( hit9[63] && hit10[64] ) ) ) )
|| 
 (( hit12[73] && hit10[63] && hit9[61] ) ||
( hit11[72] && ( ( hit12[73] && hit10[63] ) ||( hit12[73] && hit9[61] ) ||( hit9[61] && hit10[63] ) ) ) )
|| 
 (( hit12[72] && hit10[62] && hit9[63] ) ||
( hit11[72] && ( ( hit12[72] && hit10[62] ) ||( hit12[72] && hit9[63] ) ||( hit9[63] && hit10[62] ) ) ) )
);
assign TSF3[73]= ( 
(( hit12[74] && hit10[64] && hit9[63] ) || 
( hit11[73] && ( ( hit12[74] && hit10[64] ) || ( hit12[74] && hit9[63] ) || ( hit9[63] && hit10[64] ) ) ) )
 || 
 (( hit12[73] && hit10[63] && hit9[63] ) ||
( hit11[73] && ( ( hit12[73] && hit10[63] ) ||( hit12[73] && hit9[63] ) ||( hit9[63] && hit10[63] ) ) ) )
|| 
 (( hit12[73] && hit10[64] && hit9[63] ) ||
( hit11[73] && ( ( hit12[73] && hit10[64] ) ||( hit12[73] && hit9[63] ) ||( hit9[63] && hit10[64] ) ) ) )
|| 
 (( hit12[74] && hit10[64] && hit9[64] ) ||
( hit11[73] && ( ( hit12[74] && hit10[64] ) ||( hit12[74] && hit9[64] ) ||( hit9[64] && hit10[64] ) ) ) )
|| 
 (( hit12[74] && hit10[63] && hit9[63] ) ||
( hit11[73] && ( ( hit12[74] && hit10[63] ) ||( hit12[74] && hit9[63] ) ||( hit9[63] && hit10[63] ) ) ) )
|| 
 (( hit12[73] && hit10[64] && hit9[64] ) ||
( hit11[73] && ( ( hit12[73] && hit10[64] ) ||( hit12[73] && hit9[64] ) ||( hit9[64] && hit10[64] ) ) ) )
|| 
 (( hit12[73] && hit10[63] && hit9[62] ) ||
( hit11[73] && ( ( hit12[73] && hit10[63] ) ||( hit12[73] && hit9[62] ) ||( hit9[62] && hit10[63] ) ) ) )
|| 
 (( hit12[74] && hit10[63] && hit9[62] ) ||
( hit11[73] && ( ( hit12[74] && hit10[63] ) ||( hit12[74] && hit9[62] ) ||( hit9[62] && hit10[63] ) ) ) )
|| 
 (( hit12[74] && hit10[64] && hit9[62] ) ||
( hit11[73] && ( ( hit12[74] && hit10[64] ) ||( hit12[74] && hit9[62] ) ||( hit9[62] && hit10[64] ) ) ) )
|| 
 (( hit12[73] && hit10[63] && hit9[64] ) ||
( hit11[73] && ( ( hit12[73] && hit10[63] ) ||( hit12[73] && hit9[64] ) ||( hit9[64] && hit10[63] ) ) ) )
);
assign TSF3[74]= ( 
(( hit12[74] && hit10[64] && hit9[64] ) || 
( hit11[74] && ( ( hit12[74] && hit10[64] ) || ( hit12[74] && hit9[64] ) || ( hit9[64] && hit10[64] ) ) ) )
 || 
 (( hit12[75] && hit10[65] && hit9[64] ) ||
( hit11[74] && ( ( hit12[75] && hit10[65] ) ||( hit12[75] && hit9[64] ) ||( hit9[64] && hit10[65] ) ) ) )
|| 
 (( hit12[75] && hit10[64] && hit9[64] ) ||
( hit11[74] && ( ( hit12[75] && hit10[64] ) ||( hit12[75] && hit9[64] ) ||( hit9[64] && hit10[64] ) ) ) )
|| 
 (( hit12[74] && hit10[65] && hit9[64] ) ||
( hit11[74] && ( ( hit12[74] && hit10[65] ) ||( hit12[74] && hit9[64] ) ||( hit9[64] && hit10[65] ) ) ) )
|| 
 (( hit12[74] && hit10[64] && hit9[63] ) ||
( hit11[74] && ( ( hit12[74] && hit10[64] ) ||( hit12[74] && hit9[63] ) ||( hit9[63] && hit10[64] ) ) ) )
|| 
 (( hit12[75] && hit10[65] && hit9[65] ) ||
( hit11[74] && ( ( hit12[75] && hit10[65] ) ||( hit12[75] && hit9[65] ) ||( hit9[65] && hit10[65] ) ) ) )
|| 
 (( hit12[75] && hit10[64] && hit9[63] ) ||
( hit11[74] && ( ( hit12[75] && hit10[64] ) ||( hit12[75] && hit9[63] ) ||( hit9[63] && hit10[64] ) ) ) )
|| 
 (( hit12[74] && hit10[65] && hit9[65] ) ||
( hit11[74] && ( ( hit12[74] && hit10[65] ) ||( hit12[74] && hit9[65] ) ||( hit9[65] && hit10[65] ) ) ) )
|| 
 (( hit12[74] && hit10[64] && hit9[65] ) ||
( hit11[74] && ( ( hit12[74] && hit10[64] ) ||( hit12[74] && hit9[65] ) ||( hit9[65] && hit10[64] ) ) ) )
|| 
 (( hit12[75] && hit10[65] && hit9[63] ) ||
( hit11[74] && ( ( hit12[75] && hit10[65] ) ||( hit12[75] && hit9[63] ) ||( hit9[63] && hit10[65] ) ) ) )
);
assign TSF3[75]= ( 
(( hit12[75] && hit10[65] && hit9[65] ) || 
( hit11[75] && ( ( hit12[75] && hit10[65] ) || ( hit12[75] && hit9[65] ) || ( hit9[65] && hit10[65] ) ) ) )
 || 
 (( hit12[76] && hit10[66] && hit9[65] ) ||
( hit11[75] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
|| 
 (( hit12[76] && hit10[65] && hit9[65] ) ||
( hit11[75] && ( ( hit12[76] && hit10[65] ) ||( hit12[76] && hit9[65] ) ||( hit9[65] && hit10[65] ) ) ) )
|| 
 (( hit12[75] && hit10[65] && hit9[64] ) ||
( hit11[75] && ( ( hit12[75] && hit10[65] ) ||( hit12[75] && hit9[64] ) ||( hit9[64] && hit10[65] ) ) ) )
|| 
 (( hit12[75] && hit10[66] && hit9[65] ) ||
( hit11[75] && ( ( hit12[75] && hit10[66] ) ||( hit12[75] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
|| 
 (( hit12[76] && hit10[65] && hit9[64] ) ||
( hit11[75] && ( ( hit12[76] && hit10[65] ) ||( hit12[76] && hit9[64] ) ||( hit9[64] && hit10[65] ) ) ) )
|| 
 (( hit12[76] && hit10[66] && hit9[66] ) ||
( hit11[75] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[66] ) ||( hit9[66] && hit10[66] ) ) ) )
|| 
 (( hit12[75] && hit10[66] && hit9[66] ) ||
( hit11[75] && ( ( hit12[75] && hit10[66] ) ||( hit12[75] && hit9[66] ) ||( hit9[66] && hit10[66] ) ) ) )
|| 
 (( hit12[75] && hit10[65] && hit9[66] ) ||
( hit11[75] && ( ( hit12[75] && hit10[65] ) ||( hit12[75] && hit9[66] ) ||( hit9[66] && hit10[65] ) ) ) )
|| 
 (( hit12[76] && hit10[66] && hit9[64] ) ||
( hit11[75] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[64] ) ||( hit9[64] && hit10[66] ) ) ) )
|| 
 (( hit12[75] && hit10[64] && hit9[64] ) ||
( hit11[75] && ( ( hit12[75] && hit10[64] ) ||( hit12[75] && hit9[64] ) ||( hit9[64] && hit10[64] ) ) ) )
);
assign TSF3[76]= ( 
(( hit12[77] && hit10[66] && hit9[66] ) || 
( hit11[76] && ( ( hit12[77] && hit10[66] ) || ( hit12[77] && hit9[66] ) || ( hit9[66] && hit10[66] ) ) ) )
 || 
 (( hit12[76] && hit10[66] && hit9[66] ) ||
( hit11[76] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[66] ) ||( hit9[66] && hit10[66] ) ) ) )
|| 
 (( hit12[76] && hit10[66] && hit9[65] ) ||
( hit11[76] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
|| 
 (( hit12[77] && hit10[67] && hit9[66] ) ||
( hit11[76] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[66] && hit9[65] ) ||
( hit11[76] && ( ( hit12[77] && hit10[66] ) ||( hit12[77] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
|| 
 (( hit12[76] && hit10[67] && hit9[66] ) ||
( hit11[76] && ( ( hit12[76] && hit10[67] ) ||( hit12[76] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[67] && hit9[67] ) ||
( hit11[76] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[67] ) ||( hit9[67] && hit10[67] ) ) ) )
|| 
 (( hit12[76] && hit10[67] && hit9[67] ) ||
( hit11[76] && ( ( hit12[76] && hit10[67] ) ||( hit12[76] && hit9[67] ) ||( hit9[67] && hit10[67] ) ) ) )
|| 
 (( hit12[76] && hit10[65] && hit9[65] ) ||
( hit11[76] && ( ( hit12[76] && hit10[65] ) ||( hit12[76] && hit9[65] ) ||( hit9[65] && hit10[65] ) ) ) )
|| 
 (( hit12[77] && hit10[65] && hit9[65] ) ||
( hit11[76] && ( ( hit12[77] && hit10[65] ) ||( hit12[77] && hit9[65] ) ||( hit9[65] && hit10[65] ) ) ) )
|| 
 (( hit12[76] && hit10[66] && hit9[67] ) ||
( hit11[76] && ( ( hit12[76] && hit10[66] ) ||( hit12[76] && hit9[67] ) ||( hit9[67] && hit10[66] ) ) ) )
|| 
 (( hit12[77] && hit10[66] && hit9[67] ) ||
( hit11[76] && ( ( hit12[77] && hit10[66] ) ||( hit12[77] && hit9[67] ) ||( hit9[67] && hit10[66] ) ) ) )
);

endmodule
