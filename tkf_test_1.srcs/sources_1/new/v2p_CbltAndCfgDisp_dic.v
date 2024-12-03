`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    20:14:07 08/14/07
// Design Name:    
// Module Name:    v2p_addrdis_dic
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
module v2p_CbltAndCfgDisp_dic(clk,AddrEqIn,AddrEqOut,done,prog_dic);
input clk;
input AddrEqIn;
input done;

output AddrEqOut;
output prog_dic;

reg AddrEqOut;
reg prog_dic;
always @ (posedge clk)
begin
	AddrEqOut <= AddrEqIn;
	prog_dic <= !done;
end

endmodule
