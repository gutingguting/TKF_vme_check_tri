`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    16:25:42 07/04/05
// Design Name:    
// Module Name:    reset_gen
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
module reset_gen(clk, lock, reset, reset_out);
    input clk;
    input lock;
    input reset;
    output reset_out;

    wire    clk;
	 wire    lock;
	 wire    reset;
	 reg     reset_out;
	 reg     reset_int;

    reg  [15:0] startup_cnt;
	 	 
always@(posedge clk or negedge lock)
begin
  if(!lock)
	 begin
	   startup_cnt <= 16'b0;
		reset_int <= 1'b1;
      reset_out <= 1'b1;
    end
  else if(startup_cnt != 16'H0FFF)
    begin
      startup_cnt <= startup_cnt + 1;
		reset_out <= 1'b1;
	 end
  else
    begin
      reset_int <= 1'b0;
		reset_out <= reset;
	 end
end

/*always@(posedge clk or negedge lock)
begin
  if(!lock)
	 begin
	   reset_int <= 1'b1;
	 end
  else if(startup_cnt == 16'H000F)
	 begin
	 	reset_int <= 1'b0;
	 end
end
*/	
//always@(posedge clk)
//begin
//  reset_out <= reset || reset_int;
//end
 

endmodule
