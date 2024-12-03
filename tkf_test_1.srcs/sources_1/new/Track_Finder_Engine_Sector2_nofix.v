`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 02/07/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector2
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
//
//Layer				 9  10  11  12  13  14  15  16  17  18  19  20  37  38  39  40
//
//number of AMP	10  10  11  11  13  13   14 14  16  16  18  18 (16  16  16  16)
//
//
module Track_Finder_Engine_Sector2(hit_sync,up_neighbour_in, down_neighbour_in, 
                                      up_neighbour_out, down_neighbour_out, 
                                      Short_Track, Long_Track, TSF,clk, en);
    input [255:0] hit_sync;
    input [46:0] up_neighbour_in;
    input [41:0] down_neighbour_in;
    output [41:0] up_neighbour_out;
    output [46:0] down_neighbour_out;
    output [15:0] Short_Track;
    output [15:0] Long_Track;
	 output [63:0] TSF;
    input clk;
    input en;

wire [255:0] hit;

wire [76:1] hit9;
wire [76:1] hit10;
wire [88:1] hit11;
wire [88:1] hit12;
wire [100:1] hit13;
wire [100:1] hit14;
wire [112:1] hit15;
wire [112:1] hit16;
wire [128:1] hit17;
wire [128:1] hit18;
wire [140:1] hit19;
wire [140:1] hit20;
wire [128:1] hit37;
wire [128:1] hit38;
wire [128:1] hit39;
wire [128:1] hit40;

wire [88:1]  TSF3;
wire [112:1] TSF4;
wire [128:1] TSF5;
wire [128:1] TSF10;

wire [76:1] hit9_sync;
wire [76:1] hit10_sync;
wire [88:1] hit11_sync;
wire [88:1] hit12_sync;
wire [100:1] hit13_sync;
wire [100:1] hit14_sync;
wire [112:1] hit15_sync;
wire [112:1] hit16_sync;
wire [128:1] hit17_sync;
wire [128:1] hit18_sync;
wire [140:1] hit19_sync;
wire [140:1] hit20_sync;
wire [128:1] hit37_sync;
wire [128:1] hit38_sync;
wire [128:1] hit39_sync;
wire [128:1] hit40_sync;

wire [88:1]  TSF3_sync;
wire [112:1] TSF4_sync;
wire [128:1] TSF5_sync;
wire [128:1] TSF10_sync;

// optical link data assembly..
assign hit9[16:9]=hit[7:0];
assign hit11[16:9]=hit[15:8];
assign hit13[24:17]=hit[23:16];
assign hit15[24:17]=hit[31:24];

assign hit10[16:9]=hit[39:32];
assign hit12[16:9]=hit[47:40];
assign hit14[24:17]=hit[55:48];
assign hit16[24:17]=hit[63:56];

assign hit17[24:17]=hit[71:64];
assign hit19[24:17]=hit[79:72];
//assign hitxxx =hit[87:80];
//assign hitxxx =hit[95:88];

assign hit18[24:17]=hit[103:96];
assign hit20[24:17]=hit[111:104];
//assign hitxxx =hit[119:112];
//assign hitxxx =hit[127:120];

assign hit11[24:17]=hit[135:128];
assign hit15[32:25]=hit[143:136];
assign hit17[32:25]=hit[151:144];
assign hit19[32:25]=hit[159:152];

assign hit12[24:17]=hit[167:160];
assign hit16[32:25]=hit[175:168];
assign hit18[32:25]=hit[183:176];
assign hit20[32:25]=hit[191:184];

assign hit37[32:17]=hit[207:192];
assign hit38[32:17]=hit[223:208];
assign hit39[32:17]=hit[239:224];
assign hit40[32:17]=hit[255:240];

assign hit9_sync[16:9]=hit_sync[7:0];
assign hit11_sync[16:9]=hit_sync[15:8];
assign hit13_sync[24:17]=hit_sync[23:16];
assign hit15_sync[24:17]=hit_sync[31:24];

assign hit10_sync[16:9]=hit_sync[39:32];
assign hit12_sync[16:9]=hit_sync[47:40];
assign hit14_sync[24:17]=hit_sync[55:48];
assign hit16_sync[24:17]=hit_sync[63:56];

assign hit17_sync[24:17]=hit_sync[71:64];
assign hit19_sync[24:17]=hit_sync[79:72];
//assign hitxxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

assign hit18_sync[24:17]=hit_sync[103:96];
assign hit20_sync[24:17]=hit_sync[111:104];
//assign hitxxx =hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

assign hit11_sync[24:17]=hit_sync[135:128];
assign hit15_sync[32:25]=hit_sync[143:136];
assign hit17_sync[32:25]=hit_sync[151:144];
assign hit19_sync[32:25]=hit_sync[159:152];

assign hit12_sync[24:17]=hit_sync[167:160];
assign hit16_sync[32:25]=hit_sync[175:168];
assign hit18_sync[32:25]=hit_sync[183:176];
assign hit20_sync[32:25]=hit_sync[191:184];

assign hit37_sync[32:17]=hit_sync[207:192];
assign hit38_sync[32:17]=hit_sync[223:208];
assign hit39_sync[32:17]=hit_sync[239:224];
assign hit40_sync[32:17]=hit_sync[255:240];

//up_neighbour_in data assembly

assign hit9[8:7]    = up_neighbour_in[1:0];
assign hit10[8:7]   = up_neighbour_in[3:2];

assign hit13[16:14] = up_neighbour_in[6:4];
assign hit14[16:15] = up_neighbour_in[8:7];
assign hit16[16]    = up_neighbour_in[9];

assign hit17[16:15] =	up_neighbour_in[11:10];

assign hit37[16:15] = up_neighbour_in[13:12];
assign hit39[16:14] = up_neighbour_in[16:14];
assign hit40[16:12] = up_neighbour_in[21:17];

assign TSF3[8]      = up_neighbour_in[22];
assign TSF4[16:12]  = up_neighbour_in[27:23];
assign TSF10[16:1]  = up_neighbour_in[43:28];

//down_neighbour_in data assembly 

assign hit9[20:17]  = down_neighbour_in[3:0]; 
assign hit10[20:17] = down_neighbour_in[7:4]; 

assign hit13[27:25] = down_neighbour_in[10:8]; 
assign hit14[27:25] = down_neighbour_in[13:11]; 

//-------------------------------------------
//assign hit17[33]    = down_neighbour_in[12]; 
//-------------------------------------------
//assign hit19[36]
//assign hit20[37]
assign hit19[35:33] = down_neighbour_in[16:14];  
assign hit20[36:33] = down_neighbour_in[20:17]; 

assign hit37[33]    = down_neighbour_in[21]; 
assign hit39[33]    = down_neighbour_in[22]; 
assign hit40[35:33] = down_neighbour_in[25:23];   

assign TSF3[24:23]  = down_neighbour_in[27:26];  
assign TSF10[46:33] = down_neighbour_in[41:28];  

//up_neighbour_out data assembly

assign up_neighbour_out[0]     = hit12_sync[9];

assign up_neighbour_out[2:1]   = hit16_sync[18:17];

assign up_neighbour_out[3]     = hit17_sync[17];
assign up_neighbour_out[5:4]   = hit19_sync[18:17];
assign up_neighbour_out[8:6]   = hit20_sync[19:17];


assign up_neighbour_out[9]     = hit37_sync[17];
assign up_neighbour_out[10]     = hit39_sync[17];
assign up_neighbour_out[13:11] = hit40_sync[19:17];

assign up_neighbour_out[18:14] = TSF3_sync[13:9];
assign up_neighbour_out[32:19] = TSF10_sync[30:17];

assign up_neighbour_out[41:33] = 0;

//
//down_neighbour_out data assembly

assign down_neighbour_out[1:0]  = hit11_sync[24:23];
assign down_neighbour_out[3:2]  = hit12_sync[24:23];

assign down_neighbour_out[6:4]  = hit15_sync[32:30];
assign down_neighbour_out[10:7] = hit16_sync[32:29];

assign down_neighbour_out[12:11]= hit17_sync[32:31];

assign down_neighbour_out[14:13]= hit37_sync[32:31];
assign down_neighbour_out[17:15]= hit39_sync[32:30];
assign down_neighbour_out[22:18]= hit40_sync[32:28];

assign down_neighbour_out[26:23]= TSF3_sync[22:19];
assign down_neighbour_out[30:27]= TSF4_sync[29:26];
assign down_neighbour_out[46:31]= TSF10_sync[32:17];

// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector2 INST_TSF3_Sector2(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[22:9]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector2 INST_TSF4_Sector2(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[29:17]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector2 INST_TSF5_Sector2(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[32:17]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector2 INST_TSF10_Sector2(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[32:17]),
					.clk(clk),
					.en(en)
                );

wire [4:0] float5;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({5'b0,TSF10_sync[32:17],TSF5_sync[32:17],TSF4_sync[29:17],TSF3_sync[22:9]}), 
					.TSF_delay({float5,TSF10[32:17],TSF5[32:17],TSF4[29:17],TSF3[22:9]}),
					.clk(clk), 
					.en(en) 
					);
assign TSF = {TSF10_sync[32:17],TSF5_sync[32:17],3'b0,TSF4_sync[29:17],2'b0,TSF3_sync[22:9]};

TF_Sector2 INST_TF_Sector2(
					.TSF3(TSF3), 
					.TSF4(TSF4), 
					.TSF5(TSF5), 
					.TSF10(TSF10), 
					.LongTrack(Long_Track), 
					.ShortTrack(Short_Track), 
					.clk(clk),
					.en(en)
					);									
									
endmodule
