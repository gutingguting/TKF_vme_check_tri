`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:38:49 03/19/07
// Design Name:    
// Module Name:    TSF3_Sector8
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
module TSF3_Sector8(hit9, hit10, hit11, hit12, en, clk, TSF3_sync);
    input [76:1] hit9;
    input [76:1] hit10;
    input [88:1] hit11;
    input [88:1] hit12;
    input en;
    input clk;
   output [88:77] TSF3_sync;

wire [88:77] TSF3;
reg  [88:77] TSF3_sync;

always@(posedge clk)
begin
	if(en)
		begin
			TSF3_sync <= TSF3;
		end
end

assign TSF3[77]= ( 
(( hit12[78] && hit10[67] && hit9[67] ) || 
( hit11[77] && ( ( hit12[78] && hit10[67] ) || ( hit12[78] && hit9[67] ) || ( hit9[67] && hit10[67] ) ) ) )
 || 
 (( hit12[77] && hit10[67] && hit9[66] ) ||
( hit11[77] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[67] && hit9[67] ) ||
( hit11[77] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[67] ) ||( hit9[67] && hit10[67] ) ) ) )
|| 
 (( hit12[78] && hit10[67] && hit9[66] ) ||
( hit11[77] && ( ( hit12[78] && hit10[67] ) ||( hit12[78] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[78] && hit10[68] && hit9[67] ) ||
( hit11[77] && ( ( hit12[78] && hit10[68] ) ||( hit12[78] && hit9[67] ) ||( hit9[67] && hit10[68] ) ) ) )
|| 
 (( hit12[77] && hit10[66] && hit9[66] ) ||
( hit11[77] && ( ( hit12[77] && hit10[66] ) ||( hit12[77] && hit9[66] ) ||( hit9[66] && hit10[66] ) ) ) )
|| 
 (( hit12[77] && hit10[68] && hit9[67] ) ||
( hit11[77] && ( ( hit12[77] && hit10[68] ) ||( hit12[77] && hit9[67] ) ||( hit9[67] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[66] && hit9[66] ) ||
( hit11[77] && ( ( hit12[78] && hit10[66] ) ||( hit12[78] && hit9[66] ) ||( hit9[66] && hit10[66] ) ) ) )
|| 
 (( hit12[78] && hit10[68] && hit9[68] ) ||
( hit11[77] && ( ( hit12[78] && hit10[68] ) ||( hit12[78] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[77] && hit10[68] && hit9[68] ) ||
( hit11[77] && ( ( hit12[77] && hit10[68] ) ||( hit12[77] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[67] && hit9[68] ) ||
( hit11[77] && ( ( hit12[78] && hit10[67] ) ||( hit12[78] && hit9[68] ) ||( hit9[68] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[67] && hit9[68] ) ||
( hit11[77] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[68] ) ||( hit9[68] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[67] && hit9[65] ) ||
( hit11[77] && ( ( hit12[77] && hit10[67] ) ||( hit12[77] && hit9[65] ) ||( hit9[65] && hit10[67] ) ) ) )
|| 
 (( hit12[77] && hit10[66] && hit9[65] ) ||
( hit11[77] && ( ( hit12[77] && hit10[66] ) ||( hit12[77] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
|| 
 (( hit12[78] && hit10[67] && hit9[65] ) ||
( hit11[77] && ( ( hit12[78] && hit10[67] ) ||( hit12[78] && hit9[65] ) ||( hit9[65] && hit10[67] ) ) ) )
|| 
 (( hit12[78] && hit10[66] && hit9[65] ) ||
( hit11[77] && ( ( hit12[78] && hit10[66] ) ||( hit12[78] && hit9[65] ) ||( hit9[65] && hit10[66] ) ) ) )
);
assign TSF3[78]= ( 
(( hit12[78] && hit10[68] && hit9[67] ) || 
( hit11[78] && ( ( hit12[78] && hit10[68] ) || ( hit12[78] && hit9[67] ) || ( hit9[67] && hit10[68] ) ) ) )
 || 
 (( hit12[79] && hit10[68] && hit9[68] ) ||
( hit11[78] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[79] && hit10[68] && hit9[67] ) ||
( hit11[78] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[67] ) ||( hit9[67] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[68] && hit9[68] ) ||
( hit11[78] && ( ( hit12[78] && hit10[68] ) ||( hit12[78] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[67] && hit9[67] ) ||
( hit11[78] && ( ( hit12[78] && hit10[67] ) ||( hit12[78] && hit9[67] ) ||( hit9[67] && hit10[67] ) ) ) )
|| 
 (( hit12[79] && hit10[67] && hit9[67] ) ||
( hit11[78] && ( ( hit12[79] && hit10[67] ) ||( hit12[79] && hit9[67] ) ||( hit9[67] && hit10[67] ) ) ) )
|| 
 (( hit12[79] && hit10[69] && hit9[68] ) ||
( hit11[78] && ( ( hit12[79] && hit10[69] ) ||( hit12[79] && hit9[68] ) ||( hit9[68] && hit10[69] ) ) ) )
|| 
 (( hit12[78] && hit10[69] && hit9[68] ) ||
( hit11[78] && ( ( hit12[78] && hit10[69] ) ||( hit12[78] && hit9[68] ) ||( hit9[68] && hit10[69] ) ) ) )
|| 
 (( hit12[78] && hit10[67] && hit9[66] ) ||
( hit11[78] && ( ( hit12[78] && hit10[67] ) ||( hit12[78] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[79] && hit10[67] && hit9[66] ) ||
( hit11[78] && ( ( hit12[79] && hit10[67] ) ||( hit12[79] && hit9[66] ) ||( hit9[66] && hit10[67] ) ) ) )
|| 
 (( hit12[79] && hit10[69] && hit9[69] ) ||
( hit11[78] && ( ( hit12[79] && hit10[69] ) ||( hit12[79] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[79] && hit10[68] && hit9[69] ) ||
( hit11[78] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[69] ) ||( hit9[69] && hit10[68] ) ) ) )
|| 
 (( hit12[79] && hit10[68] && hit9[66] ) ||
( hit11[78] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[66] ) ||( hit9[66] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[68] && hit9[66] ) ||
( hit11[78] && ( ( hit12[78] && hit10[68] ) ||( hit12[78] && hit9[66] ) ||( hit9[66] && hit10[68] ) ) ) )
|| 
 (( hit12[78] && hit10[69] && hit9[69] ) ||
( hit11[78] && ( ( hit12[78] && hit10[69] ) ||( hit12[78] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[78] && hit10[68] && hit9[69] ) ||
( hit11[78] && ( ( hit12[78] && hit10[68] ) ||( hit12[78] && hit9[69] ) ||( hit9[69] && hit10[68] ) ) ) )
);
assign TSF3[79]= ( 
(( hit12[79] && hit10[69] && hit9[68] ) || 
( hit11[79] && ( ( hit12[79] && hit10[69] ) || ( hit12[79] && hit9[68] ) || ( hit9[68] && hit10[69] ) ) ) )
 || 
 (( hit12[80] && hit10[69] && hit9[68] ) ||
( hit11[79] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[68] ) ||( hit9[68] && hit10[69] ) ) ) )
|| 
 (( hit12[80] && hit10[69] && hit9[69] ) ||
( hit11[79] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[79] && hit10[68] && hit9[68] ) ||
( hit11[79] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[79] && hit10[69] && hit9[69] ) ||
( hit11[79] && ( ( hit12[79] && hit10[69] ) ||( hit12[79] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[80] && hit10[68] && hit9[68] ) ||
( hit11[79] && ( ( hit12[80] && hit10[68] ) ||( hit12[80] && hit9[68] ) ||( hit9[68] && hit10[68] ) ) ) )
|| 
 (( hit12[79] && hit10[68] && hit9[67] ) ||
( hit11[79] && ( ( hit12[79] && hit10[68] ) ||( hit12[79] && hit9[67] ) ||( hit9[67] && hit10[68] ) ) ) )
|| 
 (( hit12[80] && hit10[68] && hit9[67] ) ||
( hit11[79] && ( ( hit12[80] && hit10[68] ) ||( hit12[80] && hit9[67] ) ||( hit9[67] && hit10[68] ) ) ) )
|| 
 (( hit12[80] && hit10[70] && hit9[69] ) ||
( hit11[79] && ( ( hit12[80] && hit10[70] ) ||( hit12[80] && hit9[69] ) ||( hit9[69] && hit10[70] ) ) ) )
|| 
 (( hit12[79] && hit10[70] && hit9[69] ) ||
( hit11[79] && ( ( hit12[79] && hit10[70] ) ||( hit12[79] && hit9[69] ) ||( hit9[69] && hit10[70] ) ) ) )
|| 
 (( hit12[80] && hit10[69] && hit9[67] ) ||
( hit11[79] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[67] ) ||( hit9[67] && hit10[69] ) ) ) )
|| 
 (( hit12[79] && hit10[69] && hit9[67] ) ||
( hit11[79] && ( ( hit12[79] && hit10[69] ) ||( hit12[79] && hit9[67] ) ||( hit9[67] && hit10[69] ) ) ) )
);
assign TSF3[80]= ( 
(( hit12[81] && hit10[70] && hit9[69] ) || 
( hit11[80] && ( ( hit12[81] && hit10[70] ) || ( hit12[81] && hit9[69] ) || ( hit9[69] && hit10[70] ) ) ) )
 || 
 (( hit12[80] && hit10[69] && hit9[69] ) ||
( hit11[80] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[80] && hit10[70] && hit9[69] ) ||
( hit11[80] && ( ( hit12[80] && hit10[70] ) ||( hit12[80] && hit9[69] ) ||( hit9[69] && hit10[70] ) ) ) )
|| 
 (( hit12[81] && hit10[70] && hit9[70] ) ||
( hit11[80] && ( ( hit12[81] && hit10[70] ) ||( hit12[81] && hit9[70] ) ||( hit9[70] && hit10[70] ) ) ) )
|| 
 (( hit12[81] && hit10[69] && hit9[69] ) ||
( hit11[80] && ( ( hit12[81] && hit10[69] ) ||( hit12[81] && hit9[69] ) ||( hit9[69] && hit10[69] ) ) ) )
|| 
 (( hit12[80] && hit10[70] && hit9[70] ) ||
( hit11[80] && ( ( hit12[80] && hit10[70] ) ||( hit12[80] && hit9[70] ) ||( hit9[70] && hit10[70] ) ) ) )
|| 
 (( hit12[80] && hit10[69] && hit9[68] ) ||
( hit11[80] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[68] ) ||( hit9[68] && hit10[69] ) ) ) )
|| 
 (( hit12[81] && hit10[69] && hit9[68] ) ||
( hit11[80] && ( ( hit12[81] && hit10[69] ) ||( hit12[81] && hit9[68] ) ||( hit9[68] && hit10[69] ) ) ) )
|| 
 (( hit12[81] && hit10[70] && hit9[68] ) ||
( hit11[80] && ( ( hit12[81] && hit10[70] ) ||( hit12[81] && hit9[68] ) ||( hit9[68] && hit10[70] ) ) ) )
|| 
 (( hit12[80] && hit10[69] && hit9[70] ) ||
( hit11[80] && ( ( hit12[80] && hit10[69] ) ||( hit12[80] && hit9[70] ) ||( hit9[70] && hit10[69] ) ) ) )
|| 
 (( hit12[81] && hit10[71] && hit9[70] ) ||
( hit11[80] && ( ( hit12[81] && hit10[71] ) ||( hit12[81] && hit9[70] ) ||( hit9[70] && hit10[71] ) ) ) )
|| 
 (( hit12[80] && hit10[71] && hit9[70] ) ||
( hit11[80] && ( ( hit12[80] && hit10[71] ) ||( hit12[80] && hit9[70] ) ||( hit9[70] && hit10[71] ) ) ) )
);
assign TSF3[81]= ( 
(( hit12[82] && hit10[71] && hit9[70] ) || 
( hit11[81] && ( ( hit12[82] && hit10[71] ) || ( hit12[82] && hit9[70] ) || ( hit9[70] && hit10[71] ) ) ) )
 || 
 (( hit12[81] && hit10[70] && hit9[70] ) ||
( hit11[81] && ( ( hit12[81] && hit10[70] ) ||( hit12[81] && hit9[70] ) ||( hit9[70] && hit10[70] ) ) ) )
|| 
 (( hit12[81] && hit10[71] && hit9[70] ) ||
( hit11[81] && ( ( hit12[81] && hit10[71] ) ||( hit12[81] && hit9[70] ) ||( hit9[70] && hit10[71] ) ) ) )
|| 
 (( hit12[82] && hit10[70] && hit9[70] ) ||
( hit11[81] && ( ( hit12[82] && hit10[70] ) ||( hit12[82] && hit9[70] ) ||( hit9[70] && hit10[70] ) ) ) )
|| 
 (( hit12[82] && hit10[71] && hit9[71] ) ||
( hit11[81] && ( ( hit12[82] && hit10[71] ) ||( hit12[82] && hit9[71] ) ||( hit9[71] && hit10[71] ) ) ) )
|| 
 (( hit12[81] && hit10[70] && hit9[69] ) ||
( hit11[81] && ( ( hit12[81] && hit10[70] ) ||( hit12[81] && hit9[69] ) ||( hit9[69] && hit10[70] ) ) ) )
|| 
 (( hit12[81] && hit10[71] && hit9[71] ) ||
( hit11[81] && ( ( hit12[81] && hit10[71] ) ||( hit12[81] && hit9[71] ) ||( hit9[71] && hit10[71] ) ) ) )
|| 
 (( hit12[82] && hit10[70] && hit9[69] ) ||
( hit11[81] && ( ( hit12[82] && hit10[70] ) ||( hit12[82] && hit9[69] ) ||( hit9[69] && hit10[70] ) ) ) )
|| 
 (( hit12[82] && hit10[71] && hit9[69] ) ||
( hit11[81] && ( ( hit12[82] && hit10[71] ) ||( hit12[82] && hit9[69] ) ||( hit9[69] && hit10[71] ) ) ) )
|| 
 (( hit12[81] && hit10[70] && hit9[71] ) ||
( hit11[81] && ( ( hit12[81] && hit10[70] ) ||( hit12[81] && hit9[71] ) ||( hit9[71] && hit10[70] ) ) ) )
);
assign TSF3[82]= ( 
(( hit12[82] && hit10[71] && hit9[71] ) || 
( hit11[82] && ( ( hit12[82] && hit10[71] ) || ( hit12[82] && hit9[71] ) || ( hit9[71] && hit10[71] ) ) ) )
 || 
 (( hit12[83] && hit10[72] && hit9[71] ) ||
( hit11[82] && ( ( hit12[83] && hit10[72] ) ||( hit12[83] && hit9[71] ) ||( hit9[71] && hit10[72] ) ) ) )
|| 
 (( hit12[83] && hit10[71] && hit9[71] ) ||
( hit11[82] && ( ( hit12[83] && hit10[71] ) ||( hit12[83] && hit9[71] ) ||( hit9[71] && hit10[71] ) ) ) )
|| 
 (( hit12[82] && hit10[71] && hit9[70] ) ||
( hit11[82] && ( ( hit12[82] && hit10[71] ) ||( hit12[82] && hit9[70] ) ||( hit9[70] && hit10[71] ) ) ) )
|| 
 (( hit12[82] && hit10[72] && hit9[71] ) ||
( hit11[82] && ( ( hit12[82] && hit10[72] ) ||( hit12[82] && hit9[71] ) ||( hit9[71] && hit10[72] ) ) ) )
|| 
 (( hit12[83] && hit10[71] && hit9[70] ) ||
( hit11[82] && ( ( hit12[83] && hit10[71] ) ||( hit12[83] && hit9[70] ) ||( hit9[70] && hit10[71] ) ) ) )
|| 
 (( hit12[83] && hit10[72] && hit9[72] ) ||
( hit11[82] && ( ( hit12[83] && hit10[72] ) ||( hit12[83] && hit9[72] ) ||( hit9[72] && hit10[72] ) ) ) )
|| 
 (( hit12[82] && hit10[72] && hit9[72] ) ||
( hit11[82] && ( ( hit12[82] && hit10[72] ) ||( hit12[82] && hit9[72] ) ||( hit9[72] && hit10[72] ) ) ) )
|| 
 (( hit12[83] && hit10[72] && hit9[70] ) ||
( hit11[82] && ( ( hit12[83] && hit10[72] ) ||( hit12[83] && hit9[70] ) ||( hit9[70] && hit10[72] ) ) ) )
|| 
 (( hit12[82] && hit10[71] && hit9[72] ) ||
( hit11[82] && ( ( hit12[82] && hit10[71] ) ||( hit12[82] && hit9[72] ) ||( hit9[72] && hit10[71] ) ) ) )
);
assign TSF3[83]= ( 
(( hit12[83] && hit10[72] && hit9[72] ) || 
( hit11[83] && ( ( hit12[83] && hit10[72] ) || ( hit12[83] && hit9[72] ) || ( hit9[72] && hit10[72] ) ) ) )
 || 
 (( hit12[84] && hit10[72] && hit9[72] ) ||
( hit11[83] && ( ( hit12[84] && hit10[72] ) ||( hit12[84] && hit9[72] ) ||( hit9[72] && hit10[72] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[72] ) ||
( hit11[83] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[83] && hit10[72] && hit9[71] ) ||
( hit11[83] && ( ( hit12[83] && hit10[72] ) ||( hit12[83] && hit9[71] ) ||( hit9[71] && hit10[72] ) ) ) )
|| 
 (( hit12[84] && hit10[72] && hit9[71] ) ||
( hit11[83] && ( ( hit12[84] && hit10[72] ) ||( hit12[84] && hit9[71] ) ||( hit9[71] && hit10[72] ) ) ) )
|| 
 (( hit12[83] && hit10[73] && hit9[72] ) ||
( hit11[83] && ( ( hit12[83] && hit10[73] ) ||( hit12[83] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[73] ) ||
( hit11[83] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[73] ) ||( hit9[73] && hit10[73] ) ) ) )
|| 
 (( hit12[83] && hit10[73] && hit9[73] ) ||
( hit11[83] && ( ( hit12[83] && hit10[73] ) ||( hit12[83] && hit9[73] ) ||( hit9[73] && hit10[73] ) ) ) )
|| 
 (( hit12[83] && hit10[71] && hit9[71] ) ||
( hit11[83] && ( ( hit12[83] && hit10[71] ) ||( hit12[83] && hit9[71] ) ||( hit9[71] && hit10[71] ) ) ) )
|| 
 (( hit12[84] && hit10[71] && hit9[71] ) ||
( hit11[83] && ( ( hit12[84] && hit10[71] ) ||( hit12[84] && hit9[71] ) ||( hit9[71] && hit10[71] ) ) ) )
|| 
 (( hit12[83] && hit10[72] && hit9[73] ) ||
( hit11[83] && ( ( hit12[83] && hit10[72] ) ||( hit12[83] && hit9[73] ) ||( hit9[73] && hit10[72] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[71] ) ||
( hit11[83] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[71] ) ||( hit9[71] && hit10[73] ) ) ) )
);
assign TSF3[84]= ( 
(( hit12[85] && hit10[73] && hit9[73] ) || 
( hit11[84] && ( ( hit12[85] && hit10[73] ) || ( hit12[85] && hit9[73] ) || ( hit9[73] && hit10[73] ) ) ) )
 || 
 (( hit12[84] && hit10[73] && hit9[72] ) ||
( hit11[84] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[73] ) ||
( hit11[84] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[73] ) ||( hit9[73] && hit10[73] ) ) ) )
|| 
 (( hit12[85] && hit10[73] && hit9[72] ) ||
( hit11[84] && ( ( hit12[85] && hit10[73] ) ||( hit12[85] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[85] && hit10[74] && hit9[73] ) ||
( hit11[84] && ( ( hit12[85] && hit10[74] ) ||( hit12[85] && hit9[73] ) ||( hit9[73] && hit10[74] ) ) ) )
|| 
 (( hit12[84] && hit10[74] && hit9[73] ) ||
( hit11[84] && ( ( hit12[84] && hit10[74] ) ||( hit12[84] && hit9[73] ) ||( hit9[73] && hit10[74] ) ) ) )
|| 
 (( hit12[84] && hit10[72] && hit9[72] ) ||
( hit11[84] && ( ( hit12[84] && hit10[72] ) ||( hit12[84] && hit9[72] ) ||( hit9[72] && hit10[72] ) ) ) )
|| 
 (( hit12[85] && hit10[72] && hit9[72] ) ||
( hit11[84] && ( ( hit12[85] && hit10[72] ) ||( hit12[85] && hit9[72] ) ||( hit9[72] && hit10[72] ) ) ) )
|| 
 (( hit12[85] && hit10[74] && hit9[74] ) ||
( hit11[84] && ( ( hit12[85] && hit10[74] ) ||( hit12[85] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[84] && hit10[74] && hit9[74] ) ||
( hit11[84] && ( ( hit12[84] && hit10[74] ) ||( hit12[84] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[85] && hit10[73] && hit9[74] ) ||
( hit11[84] && ( ( hit12[85] && hit10[73] ) ||( hit12[85] && hit9[74] ) ||( hit9[74] && hit10[73] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[74] ) ||
( hit11[84] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[74] ) ||( hit9[74] && hit10[73] ) ) ) )
|| 
 (( hit12[84] && hit10[73] && hit9[71] ) ||
( hit11[84] && ( ( hit12[84] && hit10[73] ) ||( hit12[84] && hit9[71] ) ||( hit9[71] && hit10[73] ) ) ) )
|| 
 (( hit12[84] && hit10[72] && hit9[71] ) ||
( hit11[84] && ( ( hit12[84] && hit10[72] ) ||( hit12[84] && hit9[71] ) ||( hit9[71] && hit10[72] ) ) ) )
);
assign TSF3[85]= ( 
(( hit12[85] && hit10[74] && hit9[73] ) || 
( hit11[85] && ( ( hit12[85] && hit10[74] ) || ( hit12[85] && hit9[73] ) || ( hit9[73] && hit10[74] ) ) ) )
 || 
 (( hit12[86] && hit10[74] && hit9[74] ) ||
( hit11[85] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[86] && hit10[74] && hit9[73] ) ||
( hit11[85] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[73] ) ||( hit9[73] && hit10[74] ) ) ) )
|| 
 (( hit12[85] && hit10[74] && hit9[74] ) ||
( hit11[85] && ( ( hit12[85] && hit10[74] ) ||( hit12[85] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[85] && hit10[73] && hit9[73] ) ||
( hit11[85] && ( ( hit12[85] && hit10[73] ) ||( hit12[85] && hit9[73] ) ||( hit9[73] && hit10[73] ) ) ) )
|| 
 (( hit12[86] && hit10[75] && hit9[74] ) ||
( hit11[85] && ( ( hit12[86] && hit10[75] ) ||( hit12[86] && hit9[74] ) ||( hit9[74] && hit10[75] ) ) ) )
|| 
 (( hit12[86] && hit10[73] && hit9[73] ) ||
( hit11[85] && ( ( hit12[86] && hit10[73] ) ||( hit12[86] && hit9[73] ) ||( hit9[73] && hit10[73] ) ) ) )
|| 
 (( hit12[85] && hit10[75] && hit9[74] ) ||
( hit11[85] && ( ( hit12[85] && hit10[75] ) ||( hit12[85] && hit9[74] ) ||( hit9[74] && hit10[75] ) ) ) )
|| 
 (( hit12[85] && hit10[73] && hit9[72] ) ||
( hit11[85] && ( ( hit12[85] && hit10[73] ) ||( hit12[85] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[86] && hit10[75] && hit9[75] ) ||
( hit11[85] && ( ( hit12[86] && hit10[75] ) ||( hit12[86] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[86] && hit10[73] && hit9[72] ) ||
( hit11[85] && ( ( hit12[86] && hit10[73] ) ||( hit12[86] && hit9[72] ) ||( hit9[72] && hit10[73] ) ) ) )
|| 
 (( hit12[85] && hit10[75] && hit9[75] ) ||
( hit11[85] && ( ( hit12[85] && hit10[75] ) ||( hit12[85] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[86] && hit10[74] && hit9[72] ) ||
( hit11[85] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[72] ) ||( hit9[72] && hit10[74] ) ) ) )
|| 
 (( hit12[85] && hit10[74] && hit9[72] ) ||
( hit11[85] && ( ( hit12[85] && hit10[74] ) ||( hit12[85] && hit9[72] ) ||( hit9[72] && hit10[74] ) ) ) )
|| 
 (( hit12[86] && hit10[74] && hit9[75] ) ||
( hit11[85] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[75] ) ||( hit9[75] && hit10[74] ) ) ) )
|| 
 (( hit12[85] && hit10[74] && hit9[75] ) ||
( hit11[85] && ( ( hit12[85] && hit10[74] ) ||( hit12[85] && hit9[75] ) ||( hit9[75] && hit10[74] ) ) ) )
);
assign TSF3[86]= ( 
(( hit12[86] && hit10[75] && hit9[74] ) || 
( hit11[86] && ( ( hit12[86] && hit10[75] ) || ( hit12[86] && hit9[74] ) || ( hit9[74] && hit10[75] ) ) ) )
 || 
 (( hit12[87] && hit10[75] && hit9[75] ) ||
( hit11[86] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[87] && hit10[75] && hit9[74] ) ||
( hit11[86] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[74] ) ||( hit9[74] && hit10[75] ) ) ) )
|| 
 (( hit12[86] && hit10[74] && hit9[74] ) ||
( hit11[86] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[86] && hit10[75] && hit9[75] ) ||
( hit11[86] && ( ( hit12[86] && hit10[75] ) ||( hit12[86] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[87] && hit10[74] && hit9[74] ) ||
( hit11[86] && ( ( hit12[87] && hit10[74] ) ||( hit12[87] && hit9[74] ) ||( hit9[74] && hit10[74] ) ) ) )
|| 
 (( hit12[86] && hit10[74] && hit9[73] ) ||
( hit11[86] && ( ( hit12[86] && hit10[74] ) ||( hit12[86] && hit9[73] ) ||( hit9[73] && hit10[74] ) ) ) )
|| 
 (( hit12[87] && hit10[76] && hit9[75] ) ||
( hit11[86] && ( ( hit12[87] && hit10[76] ) ||( hit12[87] && hit9[75] ) ||( hit9[75] && hit10[76] ) ) ) )
|| 
 (( hit12[87] && hit10[74] && hit9[73] ) ||
( hit11[86] && ( ( hit12[87] && hit10[74] ) ||( hit12[87] && hit9[73] ) ||( hit9[73] && hit10[74] ) ) ) )
|| 
 (( hit12[86] && hit10[76] && hit9[75] ) ||
( hit11[86] && ( ( hit12[86] && hit10[76] ) ||( hit12[86] && hit9[75] ) ||( hit9[75] && hit10[76] ) ) ) )
|| 
 (( hit12[87] && hit10[75] && hit9[73] ) ||
( hit11[86] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[73] ) ||( hit9[73] && hit10[75] ) ) ) )
|| 
 (( hit12[86] && hit10[75] && hit9[73] ) ||
( hit11[86] && ( ( hit12[86] && hit10[75] ) ||( hit12[86] && hit9[73] ) ||( hit9[73] && hit10[75] ) ) ) )
);
assign TSF3[87]= ( 
(( hit12[88] && hit10[76] && hit9[75] ) || 
( hit11[87] && ( ( hit12[88] && hit10[76] ) || ( hit12[88] && hit9[75] ) || ( hit9[75] && hit10[76] ) ) ) )
 || 
 (( hit12[87] && hit10[75] && hit9[75] ) ||
( hit11[87] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[87] && hit10[76] && hit9[75] ) ||
( hit11[87] && ( ( hit12[87] && hit10[76] ) ||( hit12[87] && hit9[75] ) ||( hit9[75] && hit10[76] ) ) ) )
|| 
 (( hit12[88] && hit10[76] && hit9[76] ) ||
( hit11[87] && ( ( hit12[88] && hit10[76] ) ||( hit12[88] && hit9[76] ) ||( hit9[76] && hit10[76] ) ) ) )
|| 
 (( hit12[87] && hit10[76] && hit9[76] ) ||
( hit11[87] && ( ( hit12[87] && hit10[76] ) ||( hit12[87] && hit9[76] ) ||( hit9[76] && hit10[76] ) ) ) )
|| 
 (( hit12[88] && hit10[75] && hit9[75] ) ||
( hit11[87] && ( ( hit12[88] && hit10[75] ) ||( hit12[88] && hit9[75] ) ||( hit9[75] && hit10[75] ) ) ) )
|| 
 (( hit12[87] && hit10[75] && hit9[74] ) ||
( hit11[87] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[74] ) ||( hit9[74] && hit10[75] ) ) ) )
|| 
 (( hit12[88] && hit10[75] && hit9[74] ) ||
( hit11[87] && ( ( hit12[88] && hit10[75] ) ||( hit12[88] && hit9[74] ) ||( hit9[74] && hit10[75] ) ) ) )
|| 
 (( hit12[88] && hit10[1] && hit9[76] ) ||
( hit11[87] && ( ( hit12[88] && hit10[1] ) ||( hit12[88] && hit9[76] ) ||( hit9[76] && hit10[1] ) ) ) )
|| 
 (( hit12[87] && hit10[1] && hit9[76] ) ||
( hit11[87] && ( ( hit12[87] && hit10[1] ) ||( hit12[87] && hit9[76] ) ||( hit9[76] && hit10[1] ) ) ) )
|| 
 (( hit12[88] && hit10[76] && hit9[74] ) ||
( hit11[87] && ( ( hit12[88] && hit10[76] ) ||( hit12[88] && hit9[74] ) ||( hit9[74] && hit10[76] ) ) ) )
|| 
 (( hit12[87] && hit10[75] && hit9[76] ) ||
( hit11[87] && ( ( hit12[87] && hit10[75] ) ||( hit12[87] && hit9[76] ) ||( hit9[76] && hit10[75] ) ) ) )
);
assign TSF3[88]= ( 
(( hit12[1] && hit10[1] && hit9[76] ) || 
( hit11[88] && ( ( hit12[1] && hit10[1] ) || ( hit12[1] && hit9[76] ) || ( hit9[76] && hit10[1] ) ) ) )
 || 
 (( hit12[88] && hit10[76] && hit9[76] ) ||
( hit11[88] && ( ( hit12[88] && hit10[76] ) ||( hit12[88] && hit9[76] ) ||( hit9[76] && hit10[76] ) ) ) )
|| 
 (( hit12[88] && hit10[1] && hit9[76] ) ||
( hit11[88] && ( ( hit12[88] && hit10[1] ) ||( hit12[88] && hit9[76] ) ||( hit9[76] && hit10[1] ) ) ) )
|| 
 (( hit12[1] && hit10[76] && hit9[76] ) ||
( hit11[88] && ( ( hit12[1] && hit10[76] ) ||( hit12[1] && hit9[76] ) ||( hit9[76] && hit10[76] ) ) ) )
|| 
 (( hit12[1] && hit10[1] && hit9[1] ) ||
( hit11[88] && ( ( hit12[1] && hit10[1] ) ||( hit12[1] && hit9[1] ) ||( hit9[1] && hit10[1] ) ) ) )
|| 
 (( hit12[88] && hit10[76] && hit9[75] ) ||
( hit11[88] && ( ( hit12[88] && hit10[76] ) ||( hit12[88] && hit9[75] ) ||( hit9[75] && hit10[76] ) ) ) )
|| 
 (( hit12[88] && hit10[1] && hit9[1] ) ||
( hit11[88] && ( ( hit12[88] && hit10[1] ) ||( hit12[88] && hit9[1] ) ||( hit9[1] && hit10[1] ) ) ) )
|| 
 (( hit12[1] && hit10[76] && hit9[75] ) ||
( hit11[88] && ( ( hit12[1] && hit10[76] ) ||( hit12[1] && hit9[75] ) ||( hit9[75] && hit10[76] ) ) ) )
|| 
 (( hit12[1] && hit10[1] && hit9[75] ) ||
( hit11[88] && ( ( hit12[1] && hit10[1] ) ||( hit12[1] && hit9[75] ) ||( hit9[75] && hit10[1] ) ) ) )
|| 
 (( hit12[88] && hit10[76] && hit9[1] ) ||
( hit11[88] && ( ( hit12[88] && hit10[76] ) ||( hit12[88] && hit9[1] ) ||( hit9[1] && hit10[76] ) ) ) )
);


endmodule
