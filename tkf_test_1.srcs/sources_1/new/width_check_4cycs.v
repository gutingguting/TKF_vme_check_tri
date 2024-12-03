`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    08:30:11 02/13/07
// Design Name:    
// Module Name:    width_check_2cycs
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
module width_check_4cycs(width_check_in, width_check_o, clk, reset);
    input width_check_in;
    output width_check_o;
    input clk;
    input reset;

reg [2:0] count;
reg width_check_o;

always @ (posedge clk)		  //test the  width of	check	,when it's wider than 100ns,then set width_check_o=1
    begin
	   if(reset)
		  begin
		    count<=0;	
			 width_check_o<=0;
		  end
		
		else
		  begin
	       if((width_check_in==1)&&(count==0))
		         begin 
					    count<=1; 
					end
			 else if((count==1)&&(width_check_in==1)) count<=2;
			 else if((count==2)&&(width_check_in==1)) count<=3;
			 else if((count==3)&&(width_check_in==1)) begin  width_check_o<=1;	count<=4;  end
			 else if(width_check_in==0)	begin width_check_o<=0; count<=0; end
			end 
		end
					

endmodule
