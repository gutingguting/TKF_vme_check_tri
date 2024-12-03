`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    11:48:28 02/04/07
// Design Name:    
// Module Name:    SL10_Combination
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
module SL10_Combination(hit37_i, hit38_i, hit39_i, hit40_i, hit37, hit38, 
                           hit39, hit40, clk, en);
    input [31:0] hit37_i;
    input [31:0] hit38_i;
    input [31:0] hit39_i;
    input [31:0] hit40_i;
    output [15:0] hit37;
    output [15:0] hit38;
    output [15:0] hit39;
    output [15:0] hit40;
    input clk,en;

	 reg [15:0] hit37,hit38,hit39,hit40;
	 wire [15:0] hit37_or,hit38_or,hit39_or,hit40_or;

or2_16ch L37 (
              .i(hit37_i),
				  .o(hit37_or)
				  );
or2_16ch L38 (
              .i(hit38_i),
				  .o(hit38_or)
				  );
or2_16ch L39 (
              .i(hit39_i),
				  .o(hit39_or)
				  );
or2_16ch L40 (
              .i(hit40_i),
				  .o(hit40_or)
				  );

always@(posedge clk)
begin
	if(!en)
		begin
			hit37<=16'b0;
			hit38<=16'b0;
			hit39<=16'b0;
			hit40<=16'b0;
		end
	else
		begin
			hit37<=hit37_or;
			hit38<=hit38_or;
			hit39<=hit39_or;
			hit40<=hit40_or;
		end
end



endmodule
