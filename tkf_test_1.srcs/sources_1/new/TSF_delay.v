`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:42:19 02/06/07
// Design Name:    
// Module Name:    shit_reg_2cycs
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
module TSF_delay(TSF, clk, en, TSF_delay);
    input [63:0] TSF;
    input clk,en;
   output [63:0] TSF_delay;

reg [63:0] shift_data[2:0];

//parameter delay_cycles = 2;

always@(posedge clk)
begin
  if(en)
    begin
//  shift_data[delay_cycles-1:0] <= {shift_data[delay_cycles-2:0],hit} ; 
	  shift_data[2] <= shift_data[1]; 
	  shift_data[1] <= shift_data[0]; 
	  shift_data[0] <= TSF;
    end
end

assign TSF_delay = shift_data[2];

endmodule
