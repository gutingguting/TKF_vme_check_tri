`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    08:43:37 02/13/07
// Design Name:    
// Module Name:    System_Command_Control
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
module System_Command_Control(clk,reset
										,RST_IN, FRST_IN, TSYNC_IN, CRSV_IN
										,RST, FRST, TSYNC, CRSV
										,Fiber_Read_Latency,Fiber_Read_EN, FRST_PRE
										);
	 input clk;
	 input reset;
    input RST_IN;
    input FRST_IN;
    input TSYNC_IN;
    input CRSV_IN;
	 input Fiber_Read_Latency;

    output RST;
    output FRST;
    output TSYNC;
    output CRSV;
	 output Fiber_Read_EN;
	 output FRST_PRE;

wire rst_inv,frst_inv,tsync_inv,crsv_inv;
wire rst_chk,frst_chk,tsync_chk,crsv_chk;
reg	[8:0] frst_startup_cnt;

wire [7:0] Fiber_Read_Latency;
reg Fiber_Read_EN=0, FRST=1, FRST_PRE=1;

assign rst_inv   = ~RST_IN;
assign frst_inv  = ~FRST_IN;
assign tsync_inv = ~TSYNC_IN;
assign crsv_inv  = ~CRSV_IN;

assign RST   = rst_chk;
assign TSYNC = tsync_chk;
assign CRSV  = crsv_chk;

width_check_4cycs INST_width_check_RST
					(
						.width_check_in(rst_inv), 
						.width_check_o(rst_chk), 
						.clk(clk), 
						.reset(reset)							
					);
width_check_4cycs INST_width_check_FRST
					(
						.width_check_in(frst_inv), 
						.width_check_o(frst_chk), 
						.clk(clk), 
						.reset(reset)							
					);
width_check_4cycs INST_width_check_TSYNC
					(
						.width_check_in(tsync_inv), 
						.width_check_o(tsync_chk), 
						.clk(clk), 
						.reset(reset)							
					);
width_check_4cycs INST_width_check_CRSV
					(
						.width_check_in(crsv_inv), 
						.width_check_o(crsv_chk), 
						.clk(clk), 
						.reset(reset)							
					);

always@(posedge clk)
begin
	if(frst_chk)
		begin
			frst_startup_cnt <= 8'b0;
			Fiber_Read_EN <=1'b0;
			FRST <= 1'b1;
			FRST_PRE <= 1'b1;
		end
	else if(frst_startup_cnt<8'b10000)
		begin
			frst_startup_cnt <= frst_startup_cnt + 1;
			Fiber_Read_EN <= 1'b0;
			FRST <=1'b1;
			FRST_PRE <= 1'b1;
		end
	else if(frst_startup_cnt<Fiber_Read_Latency+16)
		begin
			frst_startup_cnt <= frst_startup_cnt + 1;
			Fiber_Read_EN <=1'b0;
			FRST <= 1'b1;
			FRST_PRE <= 1'b0;
		end
	else
		begin
			Fiber_Read_EN <=	1'b1;
			FRST <=1'b0;
			FRST_PRE <= 1'b0;
		end  
end
endmodule
