`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:16:16 12/12/06
// Design Name:    
// Module Name:    data_trans
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
module data_trans(
                   clk, ds, reset, iack, addr, v2p_data, write
                   ,FPGA_EN, BLK_EN
						 ,GA,VERSION,CSR2
						 ,ONE_EVENT_AMOUNT,ALL_EVENT_AMOUNT
						 ,dtk_0,WR_RAM,RD_RAM
                   ,CSR1,ONCERDNUM,WINDOW,CENTER_LATENCY,PROGFULL,PROGFULL_DIS   							
						 ,L1_gen,L1_select,CMD_RST,CMD_CLR
						 ,loop,testdata_send,single_board_testdata,reset_txgen
						 ,run_mode,Sector_select,TSF_Latency_for_readout,TK_Latency_for_readout
						 ,Fiber_Read_Latency, Fiber_Channel_Set,Fiber_Channel_Alignment_Status,Fiber_Fifo_Status
						 ,Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5
						 ,Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0						  
						 ,Hit_PreSet
					  );
    input clk;
    input ds;
    input reset;
    input iack;
    input [15:0] addr;
    inout [31:0] v2p_data;
    input write;
    input FPGA_EN,BLK_EN;
	 input [4:0] GA;
	 input [23:0] VERSION;
	 input [7:0]  CSR2;
    input [7:0]  ONE_EVENT_AMOUNT;
	 input [12:0] ALL_EVENT_AMOUNT;
    input [4:0]  Sector_select;
	 input [31:0] Fiber_Channel_Alignment_Status,Fiber_Fifo_Status;
    input [31:0] Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5;
	 input [31:0] Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0;						  

	output dtk_0;
	output WR_RAM,RD_RAM;
	output  [7:0] CSR1;
	output  [3:0] ONCERDNUM;
	output  [3:0] WINDOW;
	output  [7:0] CENTER_LATENCY;
	output  [3:0] PROGFULL;
	output  [3:0] PROGFULL_DIS;
	output  [2:0] L1_select;
	output   CMD_RST;
	output   CMD_CLR;
	output   L1_gen;
	output 	loop,testdata_send,single_board_testdata,reset_txgen;
	output [31:0] run_mode;
	output [3:0]  TSF_Latency_for_readout,TK_Latency_for_readout;
	output [7:0]  Fiber_Read_Latency;
	output [15:0] Fiber_Channel_Set;
	output [319:0] Hit_PreSet;


reg bs_lch,DTBS_SYNC;
reg RDREQ,WR,DTK;

// vme wr/rd
//initialization
wire RD_VERSION;
wire WR_CSR,RD_CSR;
reg [7:0] CSR1=8'b10101010;
wire WR_ONCERDNUM,RD_ONCERDNUM;
reg  [3:0] ONCERDNUM;
wire WR_WINDOW,RD_WINDOW;
reg  [3:0] WINDOW;
wire WR_CENTER_LATENCY,RD_CENTER_LATENCY;
reg  [7:0] CENTER_LATENCY;
wire WR_PROGFULL,RD_PROGFULL;
reg  [3:0] PROGFULL;
wire WR_PROGFULL_DIS,RD_PROGFULL_DIS;
reg  [3:0] PROGFULL_DIS;
wire WR_L1,RD_L1;
reg  [2:0] L1_select;
wire WR_CMDRST;
reg   CMD_RST;
wire WR_CMDCLR;
reg   CMD_CLR;
wire RD_ONE_EVENT_AMOUNT,RD_ALL_EVENT_AMOUNT;

wire WR_TXGEN_RST,RD_TXGEN_RST;
reg reset_txgen;

wire WR_run_mode,RD_run_mode;
reg [31:0]run_mode;
wire RD_Sector_select;

//teset
wire WR_L1_GEN,RD_L1_GEN;
reg   L1_gen;
wire WR_TF,RD_TF;
reg 	loop=0,testdata_send=0,single_board_testdata=0;

reg [3:0] TSF_Latency_for_readout,TK_Latency_for_readout;
wire 	WR_TSF_Latency,RD_TSF_Latency;
wire 	WR_TK_Latency,RD_TK_Latency;

reg [7:0] Fiber_Read_Latency;
wire  WR_Fiber_Read_Latency, RD_Fiber_Read_Latency;

reg [15:0] Fiber_Channel_Set=16'hFFFF;
wire[31:0] Fiber_Channel_Alignment_Status,Fiber_Fifo_Status;
wire[31:0] Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5;
wire[31:0] Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0;						  

wire  WR_Fiber_Channel_Set, RD_Fiber_Channel_Set,RD_Fiber_Channel_Alignment_Status,RD_Fiber_Fifo_Status;
wire 	RD_Fiber_Fifo_Count9,RD_Fiber_Fifo_Count8,RD_Fiber_Fifo_Count7,RD_Fiber_Fifo_Count6,RD_Fiber_Fifo_Count5;
wire 	RD_Fiber_Fifo_Count4,RD_Fiber_Fifo_Count3,RD_Fiber_Fifo_Count2,RD_Fiber_Fifo_Count1,RD_Fiber_Fifo_Count0;

wire [9:0] WR_Hit_PreSet,RD_Hit_PreSet;
reg  [319:0] Hit_PreSet;
wire [4:0] WR_backup,RD_backup;
reg  [31:0] backup0,backup1,backup2,backup3,backup4;

reg [2:0] CS,NS;
//reg ds_dl;
wire ds_inv;

assign ds_inv = !ds;

//always@(posedge clk)
//begin
//  if(ds_inv)
//    ds_dl <= 1'b0;
//  else
//    ds_dl <= ds;
//end

parameter S0 = 3'b000, S1 = 3'b001, S2	= 3'b010, S3 = 3'b011,S4 = 3'b100;

assign dtk_0 = DTK;

always@(posedge clk or posedge ds_inv)
begin
    if (ds_inv)
	   begin
		  bs_lch <= 1'b0;
		  DTBS_SYNC <= 1'b0;
      end
    else
	   begin
		  bs_lch <= (FPGA_EN && iack) || (BLK_EN && iack);
		  DTBS_SYNC <= (FPGA_EN && iack) || (BLK_EN && iack);
      end
end

//always@(posedge clk)
//begin
//  DTBS_SYNC <= bs_lch;
//end

always @(posedge clk or posedge reset)
	begin
		if (reset) CS <= S0;
		else CS <= NS;
	end

always @(CS or DTBS_SYNC)
	begin
	case(CS)
		S0:	begin
					if	(DTBS_SYNC) NS <= S1;
					else NS <= S0;
				end
		S1:	begin
					NS <= S2;
				end
		S2:	begin
					NS <= S3;
				end
      S3:	begin
					if	(!DTBS_SYNC) NS <= S0;
					else NS <= S3;
				end
		default:	NS <= S0;
	endcase
	end

	always @(CS)
	begin
	case(CS)
		S0:	begin RDREQ = 0; WR = 0; DTK = 0; end
		S1:	begin RDREQ = 1; WR = 0; DTK = 0; end
		S2:	begin RDREQ = 0; WR = 1; DTK = 0; end
		S3:	begin RDREQ = 0; WR = 0; DTK = 1; end
	endcase
	end
//synthesis attribute KEEP of DTK is "true"

//+++++++++++   A24/D32 data transfer interface   ++++++++++++
//################################################
//##								                     ##
//##  VME command for initialization  and reset ##
//##								                     ##
//################################################

//
//   addr[15:0] map to VME address [17:2]
//

//addr=16'b0, rd version of firmware;
assign	RD_VERSION = FPGA_EN & ( addr[15:0] == 16'b0 ) & bs_lch & write;
assign   v2p_data = RD_VERSION ? {3'b0,GA,VERSION} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1, wr CSR1, rd CSR2/CSR1;
//-------------------------------------------------------------------------
assign	WR_CSR = FPGA_EN & ( addr[15:0] == 16'b1 ) & WR & !write ;
assign	RD_CSR = FPGA_EN & ( addr[15:0] == 16'b1 ) & bs_lch & write;
always@(posedge WR_CSR or posedge clk)
begin
  if(WR_CSR) CSR1<= v2p_data[7:0];
end
assign   v2p_data = RD_CSR ? {8'b0,CSR2,8'b0,CSR1} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10, wr/rd number of once read out event;
//-------------------------------------------------------------------------
assign	WR_ONCERDNUM = FPGA_EN & ( addr[15:0] == 16'b10) & WR & !write;
assign	RD_ONCERDNUM =  FPGA_EN & ( addr[15:0] == 16'b10 ) & bs_lch & write;

always@(posedge WR_ONCERDNUM or posedge clk)
begin
  if(WR_ONCERDNUM) ONCERDNUM<= v2p_data[3:0];
end
assign v2p_data = RD_ONCERDNUM ? {28'b0,ONCERDNUM} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b11, wr/rd number of once read out window;
//-------------------------------------------------------------------------
assign	WR_WINDOW = FPGA_EN & ( addr[15:0] == 16'b11) & WR & !write;
assign	RD_WINDOW =  FPGA_EN & ( addr[15:0] == 16'b11 ) & bs_lch & write;

always@(posedge WR_WINDOW or posedge clk)
begin
  if(WR_WINDOW) WINDOW<= v2p_data[3:0];
end
assign v2p_data = RD_WINDOW ? {28'b0,WINDOW} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b100, wr/rd programming full of CBLT gloabl buffer
//-------------------------------------------------------------------------
assign	WR_PROGFULL = FPGA_EN & ( addr[15:0] == 16'b100) & WR & !write;
assign	RD_PROGFULL =  FPGA_EN & ( addr[15:0] == 16'b100 ) & bs_lch & write;

always@(posedge WR_PROGFULL or posedge clk)
begin
  if(WR_PROGFULL) PROGFULL<= v2p_data[3:0];
end
assign v2p_data = RD_PROGFULL ? {28'b0,PROGFULL} : 32'hzzzzzzzz; 
 
//-------------------------------------------------------------------------
//addr=16'b101, wr/rd programming full-disable oc
//-------------------------------------------------------------------------
assign	WR_PROGFULL_DIS = FPGA_EN & ( addr[15:0] == 16'b101) & WR & !write;
assign	RD_PROGFULL_DIS =  FPGA_EN & ( addr[15:0] == 16'b101 ) & bs_lch & write;

always@(posedge WR_PROGFULL_DIS or posedge clk)
begin
  if(WR_PROGFULL_DIS) PROGFULL_DIS<= v2p_data[3:0];
end
assign v2p_data = RD_PROGFULL_DIS ? {28'b0,PROGFULL_DIS} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b110, wr/rd L1 select and generator
//-------------------------------------------------------------------------
assign	WR_L1 = FPGA_EN & ( addr[15:0] == 16'b110) & WR & !write;
assign	RD_L1 = FPGA_EN & ( addr[15:0] == 16'b110 ) & bs_lch & write;

always@(posedge WR_L1 or posedge clk)
begin
	if(WR_L1)  L1_select <= v2p_data[2:0];
end
assign v2p_data = RD_L1 ? {29'b0,L1_select} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b111, rd data number of one event
//-------------------------------------------------------------------------
assign RD_ONE_EVENT_AMOUNT = FPGA_EN & ( addr[15:0] == 16'b111 ) & bs_lch & write;
assign v2p_data = RD_ONE_EVENT_AMOUNT ? {24'b0,ONE_EVENT_AMOUNT} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1000, rd data number of one event
//-------------------------------------------------------------------------
assign RD_ALL_EVENT_AMOUNT = FPGA_EN & ( addr[15:0] == 16'b1000 ) & bs_lch & write;
assign v2p_data = RD_ALL_EVENT_AMOUNT ? {19'b0,ALL_EVENT_AMOUNT} : 32'hzzzzzzzz; 


//-------------------------------------------------------------------------
//addr=16'b1001, wr/rd CENTER_LATENCY, to find out the latency of L1 for read out;
//-------------------------------------------------------------------------
assign	WR_CENTER_LATENCY = FPGA_EN & ( addr[15:0] == 16'b1001) & WR & !write;
assign	RD_CENTER_LATENCY = FPGA_EN & ( addr[15:0] == 16'b1001 ) & bs_lch & write;

always@(posedge WR_CENTER_LATENCY or posedge clk)
begin
	if(WR_CENTER_LATENCY)  CENTER_LATENCY <= v2p_data[7:0];
end
assign v2p_data = RD_CENTER_LATENCY ? {24'b0,CENTER_LATENCY} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1010, wr/rd run_mode: =0, normal run ; =1, test;
//-------------------------------------------------------------------------
assign	WR_run_mode = FPGA_EN & ( addr[15:0] == 16'b1010) & WR & !write;
assign	RD_run_mode = FPGA_EN & ( addr[15:0] == 16'b1010 ) & bs_lch & write;

always@(posedge WR_run_mode or posedge clk)
begin
	if(WR_run_mode)  run_mode <= v2p_data;
end
assign v2p_data = RD_run_mode ? run_mode : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1011, wr/rd TSF_Latency
//-------------------------------------------------------------------------
assign	WR_TSF_Latency = FPGA_EN & ( addr[15:0] == 16'b1011) & WR & !write;
assign	RD_TSF_Latency = FPGA_EN & ( addr[15:0] == 16'b1011) & bs_lch & write;

always@(posedge WR_TSF_Latency or posedge clk)
begin
	if(WR_TSF_Latency)  TSF_Latency_for_readout <= v2p_data[3:0];
end
assign v2p_data = RD_TSF_Latency ? {28'b0,TSF_Latency_for_readout} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1100, wr/rd TK_Latency
//-------------------------------------------------------------------------
assign	WR_TK_Latency = FPGA_EN & ( addr[15:0] == 16'b1100) & WR & !write;
assign	RD_TK_Latency = FPGA_EN & ( addr[15:0] == 16'b1100) & bs_lch & write;

always@(posedge WR_TK_Latency or posedge clk)
begin
	if(WR_TK_Latency)  TK_Latency_for_readout <= v2p_data[3:0];
end
assign v2p_data = RD_TK_Latency ? {28'b0,TK_Latency_for_readout} : 32'hzzzzzzzz; 


//-------------------------------------------------------------------------
//addr=16'b1101, wr/rd Fiber_Read_Latency
//-------------------------------------------------------------------------
assign	WR_Fiber_Read_Latency = FPGA_EN & ( addr[15:0] == 16'b1101) & WR & !write;
assign	RD_Fiber_Read_Latency = FPGA_EN & ( addr[15:0] == 16'b1101) & bs_lch & write;

always@(posedge WR_Fiber_Read_Latency or posedge clk)
begin
	if(WR_Fiber_Read_Latency)  Fiber_Read_Latency <= v2p_data[7:0];
end
assign v2p_data = RD_Fiber_Read_Latency ? {24'b0,Fiber_Read_Latency} : 32'hzzzzzzzz; 


//-------------------------------------------------------------------------
//addr=16'b1110, wr/rd Fiber_Channel_Set
//-------------------------------------------------------------------------
assign	WR_Fiber_Channel_Set = FPGA_EN & ( addr[15:0] == 16'b1110) & WR & !write;
assign	RD_Fiber_Channel_Set = FPGA_EN & ( addr[15:0] == 16'b1110) & bs_lch & write;

always@(posedge WR_Fiber_Channel_Set or posedge clk)
begin
	if(WR_Fiber_Channel_Set)  Fiber_Channel_Set <= v2p_data[15:0];
end
assign v2p_data = RD_Fiber_Channel_Set ? {16'b0,Fiber_Channel_Set} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1111, rd Fiber_Alignment_Status
//-------------------------------------------------------------------------
assign	RD_Fiber_Channel_Alignment_Status = FPGA_EN & ( addr[15:0] == 16'b1111) & bs_lch & write;
assign v2p_data = RD_Fiber_Channel_Alignment_Status ? Fiber_Channel_Alignment_Status[31:0] : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1_0000, rd Fiber_Fifo_Status
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Status = FPGA_EN & ( addr[15:0] == 16'b10000) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Status ? Fiber_Fifo_Status[31:0] : 32'hzzzzzzzz; 

//#############################
//##								  ##
//##  Fiber fifo count ch9~0 ##
//##								  ##
//#############################
//-------------------------------------------------------------------------
//addr=16'b1_0001, rd Fiber_Fifo_Count0
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count0 = FPGA_EN & ( addr[15:0] == 16'b1_0001) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count0 ? Fiber_Fifo_Count0[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0010, rd Fiber_Fifo_Count1
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count1 = FPGA_EN & ( addr[15:0] == 16'b1_0010) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count1 ? Fiber_Fifo_Count1[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0011, rd Fiber_Fifo_Count2
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count2 = FPGA_EN & ( addr[15:0] == 16'b1_0011) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count2 ? Fiber_Fifo_Count2[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0100, rd Fiber_Fifo_Count3
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count3 = FPGA_EN & ( addr[15:0] == 16'b1_0100) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count3 ? Fiber_Fifo_Count3[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0101, rd Fiber_Fifo_Count4
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count4 = FPGA_EN & ( addr[15:0] == 16'b1_0101) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count4 ? Fiber_Fifo_Count4[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0110, rd Fiber_Fifo_Count5
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count5 = FPGA_EN & ( addr[15:0] == 16'b1_0110) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count5 ? Fiber_Fifo_Count5[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_0111, rd Fiber_Fifo_Count6
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count6 = FPGA_EN & ( addr[15:0] == 16'b1_0111) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count6 ? Fiber_Fifo_Count6[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1000, rd Fiber_Fifo_Count7
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count7 = FPGA_EN & ( addr[15:0] == 16'b1_1000) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count7 ? Fiber_Fifo_Count7[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1001, rd Fiber_Fifo_Count8
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count8 = FPGA_EN & ( addr[15:0] == 16'b1_1001) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count8 ? Fiber_Fifo_Count8[31:0] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1010, rd Fiber_Fifo_Count8
//-------------------------------------------------------------------------
assign	RD_Fiber_Fifo_Count9 = FPGA_EN & ( addr[15:0] == 16'b1_1010) & bs_lch & write;
assign v2p_data = RD_Fiber_Fifo_Count9 ? Fiber_Fifo_Count9[31:0] : 32'hzzzzzzzz; 

//#############################
//##								  ##
//##    hit_preset[319:0]    ##
//##								  ##
//#############################
//-------------------------------------------------------------------------
//addr=16'b1_1011, Hit_PreSet[0]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[0] = FPGA_EN & ( addr[15:0] == 16'b1_1011) & WR & !write;
assign	RD_Hit_PreSet[0] = FPGA_EN & ( addr[15:0] == 16'b1_1011) & bs_lch & write;

always@(posedge WR_Hit_PreSet[0] or posedge clk)
begin
	if(WR_Hit_PreSet[0])  Hit_PreSet[31:0] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[0] ? Hit_PreSet[31:0] : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b1_1100, Hit_PreSet[1]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[1] = FPGA_EN & ( addr[15:0] == 16'b1_1100) & WR & !write;
assign	RD_Hit_PreSet[1] = FPGA_EN & ( addr[15:0] == 16'b1_1100) & bs_lch & write;

always@(posedge WR_Hit_PreSet[1] or posedge clk)
begin
	if(WR_Hit_PreSet[1])  Hit_PreSet[63:32] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[1] ? Hit_PreSet[63:32] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1101, Hit_PreSet[2]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[2] = FPGA_EN & ( addr[15:0] == 16'b1_1101) & WR & !write;
assign	RD_Hit_PreSet[2] = FPGA_EN & ( addr[15:0] == 16'b1_1101) & bs_lch & write;

always@(posedge WR_Hit_PreSet[2] or posedge clk)
begin
	if(WR_Hit_PreSet[2])  Hit_PreSet[95:64] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[2] ? Hit_PreSet[95:64] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1110, Hit_PreSet[3]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[3] = FPGA_EN & ( addr[15:0] == 16'b1_1110) & WR & !write;
assign	RD_Hit_PreSet[3] = FPGA_EN & ( addr[15:0] == 16'b1_1110) & bs_lch & write;

always@(posedge WR_Hit_PreSet[3] or posedge clk)
begin
	if(WR_Hit_PreSet[3])  Hit_PreSet[127:96] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[3] ? Hit_PreSet[127:96] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b1_1111, Hit_PreSet[4]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[4] = FPGA_EN & ( addr[15:0] == 16'b1_1111) & WR & !write;
assign	RD_Hit_PreSet[4] = FPGA_EN & ( addr[15:0] == 16'b1_1111) & bs_lch & write;

always@(posedge WR_Hit_PreSet[4] or posedge clk)
begin
	if(WR_Hit_PreSet[4])  Hit_PreSet[159:128] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[4] ? Hit_PreSet[159:128] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b10_0000, Hit_PreSet[5]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[5] = FPGA_EN & ( addr[15:0] == 16'b10_0000) & WR & !write;
assign	RD_Hit_PreSet[5] = FPGA_EN & ( addr[15:0] == 16'b10_0000) & bs_lch & write;

always@(posedge WR_Hit_PreSet[5] or posedge clk)
begin
	if(WR_Hit_PreSet[5])  Hit_PreSet[191:160] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[5] ? Hit_PreSet[191:160] : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_0001, Hit_PreSet[6]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[6] = FPGA_EN & ( addr[15:0] == 16'b10_0001) & WR & !write;
assign	RD_Hit_PreSet[6] = FPGA_EN & ( addr[15:0] == 16'b10_0001) & bs_lch & write;

always@(posedge WR_Hit_PreSet[6] or posedge clk)
begin
	if(WR_Hit_PreSet[6])  Hit_PreSet[223:192] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[6] ? Hit_PreSet[223:192] : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b10_0010, Hit_PreSet[7]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[7] = FPGA_EN & ( addr[15:0] == 16'b10_0010) & WR & !write;
assign	RD_Hit_PreSet[7] = FPGA_EN & ( addr[15:0] == 16'b10_0010) & bs_lch & write;

always@(posedge WR_Hit_PreSet[7] or posedge clk)
begin
	if(WR_Hit_PreSet[7])  Hit_PreSet[255:224] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[7] ? Hit_PreSet[255:224] : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_0011, Hit_PreSet[8]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[8] = FPGA_EN & ( addr[15:0] == 16'b10_0011) & WR & !write;
assign	RD_Hit_PreSet[8] = FPGA_EN & ( addr[15:0] == 16'b10_0011) & bs_lch & write;

always@(posedge WR_Hit_PreSet[8] or posedge clk)
begin
	if(WR_Hit_PreSet[8])  Hit_PreSet[287:256] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[8] ? Hit_PreSet[287:256] : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_0100, Hit_PreSet[9]
//-------------------------------------------------------------------------
assign	WR_Hit_PreSet[9] = FPGA_EN & ( addr[15:0] == 16'b10_0100) & WR & !write;
assign	RD_Hit_PreSet[9] = FPGA_EN & ( addr[15:0] == 16'b10_0100) & bs_lch & write;

always@(posedge WR_Hit_PreSet[9] or posedge clk)
begin
	if(WR_Hit_PreSet[9])  Hit_PreSet[319:288] <= v2p_data[31:0];
end

assign v2p_data = RD_Hit_PreSet[9] ? Hit_PreSet[319:288] : 32'hzzzzzzzz; 

//////////////////////////
//      backup
//////////////////////////

//-------------------------------------------------------------------------
//addr=16'b10_0101, backup[0]
//-------------------------------------------------------------------------
assign	WR_backup[0] = FPGA_EN & ( addr[15:0] == 16'b10_0101) & WR & !write;
assign	RD_backup[0] = FPGA_EN & ( addr[15:0] == 16'b10_0101) & bs_lch & write;

always@(posedge WR_backup[0] or posedge clk)
begin
	if(WR_backup[0])  backup0 <= v2p_data[31:0];
end

assign v2p_data = RD_backup[0] ? backup0 : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_0110, backup[1]
//-------------------------------------------------------------------------
assign	WR_backup[1] = FPGA_EN & ( addr[15:0] == 16'b10_0110) & WR & !write;
assign	RD_backup[1] = FPGA_EN & ( addr[15:0] == 16'b10_0110) & bs_lch & write;

always@(posedge WR_backup[1] or posedge clk)
begin
	if(WR_backup[1])  backup1 <= v2p_data[31:0];
end

assign v2p_data = RD_backup[1] ? backup1 : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_0111, backup[2]
//-------------------------------------------------------------------------
assign	WR_backup[2] = FPGA_EN & ( addr[15:0] == 16'b10_0111) & WR & !write;
assign	RD_backup[2] = FPGA_EN & ( addr[15:0] == 16'b10_0111) & bs_lch & write;

always@(posedge WR_backup[2] or posedge clk)
begin
	if(WR_backup[2])  backup2 <= v2p_data[31:0];
end

assign v2p_data = RD_backup[2] ? backup2 : 32'hzzzzzzzz; 
//-------------------------------------------------------------------------
//addr=16'b10_1000, backup[3]
//-------------------------------------------------------------------------
assign	WR_backup[3] = FPGA_EN & ( addr[15:0] == 16'b10_1000) & WR & !write;
assign	RD_backup[3] = FPGA_EN & ( addr[15:0] == 16'b10_1000) & bs_lch & write;

always@(posedge WR_backup[3] or posedge clk)
begin
	if(WR_backup[3])  backup3 <= v2p_data[31:0];
end

assign v2p_data = RD_backup[3] ? backup3 : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b10_1001, backup[4]
//-------------------------------------------------------------------------
assign	WR_backup[4] = FPGA_EN & ( addr[15:0] == 16'b10_1001) & WR & !write;
assign	RD_backup[4] = FPGA_EN & ( addr[15:0] == 16'b10_1001) & bs_lch & write;

always@(posedge WR_backup[4] or posedge clk)
begin
	if(WR_backup[4])  backup4 <= v2p_data[31:0];
end

assign v2p_data = RD_backup[4] ? backup4 : 32'hzzzzzzzz; 

//#############################
//##								  ##
//##         Global set      ##
//##								  ##
//#############################

//-------------------------------------------------------------------------
//addr=16'b11_1101, rd select of section;
//-------------------------------------------------------------------------
assign	RD_Sector_select = FPGA_EN & ( addr[15:0] == 16'b11_1101 ) & bs_lch & write;
assign   v2p_data = RD_Sector_select ? {29'b0,Sector_select} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr=16'b11_1110, wr/rd RESET all register as initiation.
//-------------------------------------------------------------------------
assign	WR_CMDRST = FPGA_EN & ( addr[15:0] == 16'b11_1110) & WR & !write;
always@(posedge clk)
begin
  if(!WR_CMDRST) 
    begin 
	   CMD_RST <= 1'b1;
    end
  else
    begin
	   CMD_RST <= 1'b0;
    end
end

//-------------------------------------------------------------------------
//addr=16'b11_1111, wr/rd CLEAN all register and ready to do initialization .
//-------------------------------------------------------------------------
assign	WR_CMDCLR = FPGA_EN & ( addr[15:0] == 16'b11_1111) & WR & !write;
always@(posedge clk)
begin
  if(!WR_CMDCLR) 
    begin 
	   CMD_CLR <= 1'b1;
    end
  else
    begin
	   CMD_CLR <= 1'b0;
    end
end


//#############################
//##								  ##
//##  VME command for test   ##
//##								  ##
//#############################

//-------------------------------------------------------------------------
//addr=16'b100_0001, generator 1 L1
//-------------------------------------------------------------------------
assign	WR_L1_GEN = FPGA_EN & ( addr[15:0] == 16'b100_0001) & WR & !write ;
assign	RD_L1_GEN = FPGA_EN & ( addr[15:0] == 16'b100_0001) & WR & !write ;
always@(posedge clk)
begin
  if(!WR_L1_GEN) 
    begin 
	   L1_gen <= 1'b0;
    end
  else
    begin
	   L1_gen <= 1'b1;
    end
end
assign v2p_data = RD_L1_GEN ? {31'b0,L1_gen} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr= 16'b100_0010, Mode set of Track Finder Test; 
//-------------------------------------------------------------------------
assign	WR_TF = FPGA_EN & ( addr[15:0] == 16'b100_0010) & WR & !write ;
assign	RD_TF = FPGA_EN & ( addr[15:0] == 16'b100_0010 ) & bs_lch & write;

always@(posedge WR_TF or posedge clk)
begin
  if(WR_TF) 
     begin
	    testdata_send <= v2p_data[0];
	    loop <= v2p_data[1];
		 single_board_testdata <= v2p_data[2];
     end
end

assign v2p_data = RD_TF ? {29'b0,single_board_testdata,loop,testdata_send} : 32'hzzzzzzzz; 

//-------------------------------------------------------------------------
//addr= 16'b100_0011, tx_gen, generate prbs data to tx of MGT; 
//-------------------------------------------------------------------------
assign	WR_TXGEN_RST = FPGA_EN & ( addr[15:0] == 16'b100_0011) & WR & !write ;
assign	RD_TXGEN_RST = FPGA_EN & ( addr[15:0] == 16'b100_0011 ) & bs_lch & write;

always@(posedge WR_TXGEN_RST or posedge clk)
begin
  if(WR_TXGEN_RST) 
     begin
	    reset_txgen <= v2p_data[0];
     end
end

assign v2p_data = RD_TXGEN_RST ? {31'b0,reset_txgen} : 32'hzzzzzzzz; 


//#######################################
//##								            ##
//##  VME command for Block Transmit   ##
//##								            ##
//#######################################

//+++++++++++   BLK transfer interface   ++++++++++++
assign	WR_RAM = BLK_EN & WR & !write ;
assign   RD_RAM = BLK_EN & bs_lch & write;

endmodule
