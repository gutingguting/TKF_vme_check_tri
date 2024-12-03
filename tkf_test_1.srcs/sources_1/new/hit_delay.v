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
module hit_delay(hit, clk40, en, hit_delay);
    input [255:0] hit;
    input clk40,en;
   output [255:0] hit_delay;

reg [255:0] shift_data[2:0];

//parameter delay_cycles = 2;

always@(posedge clk40)
begin
	if(en)
		begin
		//  shift_data[delay_cycles-1:0] <= {shift_data[delay_cycles-2:0],hit} ; 
		  shift_data[2] <= shift_data[1]; 
		  shift_data[1] <= shift_data[0]; 
		  shift_data[0] <= hit; 
		end
end

assign hit_delay = shift_data[2];

endmodule
