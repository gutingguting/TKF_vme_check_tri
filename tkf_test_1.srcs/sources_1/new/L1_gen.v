`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:45:46 12/27/06
// Design Name:    
// Module Name:    L1_gen
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
module L1_gen(clk,L1_IN,L1_VME,Trkcount,L1_select,L1);
	input 	    clk,L1_IN,L1_VME;
	input  [2:0] L1_select;
	input  [2:0] Trkcount;
	output       L1;

//L1_select 
reg L1_slf;
reg [3:0] L1_strech_cnt;
reg L1_test=1; // effected when assign to low level.
wire L1_selected;
reg [1:0] L1_tmp;
wire L1_IN_chk;

always @(L1_select[2:1], Trkcount,L1_VME)
   case (L1_select[2:1])
      2'b00: L1_slf = L1_VME;
      2'b01: L1_slf = Trkcount[0];
      2'b10: L1_slf = Trkcount[1];
      2'b11: L1_slf = Trkcount[2];
   endcase


always@(posedge clk)
begin
  if(L1_slf && (L1_strech_cnt==4'b0))
    begin
	   L1_strech_cnt <= 4'b1;
	   L1_test <= 1'b1;
    end
  else if((L1_strech_cnt>4'b0) && (L1_strech_cnt < 4'b1010))
    begin L1_strech_cnt <=  L1_strech_cnt +1; end
  else if(L1_strech_cnt == 4'b1010)
    begin 
	   L1_strech_cnt <= 4'b0;
	   L1_test <= 4'b0;
    end
  else
    begin
	   L1_strech_cnt <= 4'b0;
	   L1_test <= 4'b0;
    end
end

//width_check_2cycs INST_width_check_2cycs_L1(
//						.width_check_in(~L1_IN), 
//						.width_check_o(L1_IN_chk), 
//						.clk(clk), 
//						.reset(1'b0)							
//															);

assign L1_selected = L1_select[0] ? L1_test : ~L1_IN;

assign L1=L1_selected;

endmodule
