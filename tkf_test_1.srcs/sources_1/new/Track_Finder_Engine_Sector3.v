`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/08/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector3
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
module Track_Finder_Engine_Sector3(hit_sync,up_neighbour_in, down_neighbour_in, 
                                      up_neighbour_out, down_neighbour_out, 
                                      Short_Track, Long_Track,TSF, clk, en);
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
// 11111111111111111111111111111111
assign hit9[24:17]=hit[7:0];
assign hit11[32:25]=hit[15:8];
assign hit13[32:25]=hit[23:16];
assign hit15[40:33]=hit[31:24];

//222222222222222222222222222222222
assign hit10[24:17]=hit[39:32];
assign hit12[32:25]=hit[47:40];
assign hit14[32:25]=hit[55:48];
assign hit16[40:33]=hit[63:56];

//333333333333333333333333333333333
assign hit17[40:33]=hit[71:64];
assign hit19[40:33]=hit[79:72];
//assign hitxxx =hit[87:80];
//assign hitxxx =hit[95:88];

//444444444444444444444444444444444
assign hit18[40:33]=hit[103:96];
assign hit20[40:33]=hit[111:104];
//assign hitxxx =hit[119:112];
//assign hitxxx =hit[127:120];

//555555555555555555555555555555555
assign hit9[32:25]=hit[135:128];
assign hit13[40:33]=hit[143:136];
assign hit17[48:41]=hit[151:144];
assign hit19[48:44]=hit[159:155];
assign hit19[42:41]=hit[153:152];
// fix hit19[43]=1
assign hit19[43]=1'b1;

//666666666666666666666666666666666
assign hit10[32:25]=hit[167:160];
assign hit14[40:33]=hit[175:168];
assign hit18[48:41]=hit[183:176];
assign hit20[48:41]=hit[191:184];

//777777777777777777777777777777777
assign hit37[48:33]=hit[207:192];
assign hit38[48:33]=hit[223:208];
assign hit39[48:33]=hit[239:224];
assign hit40[48:33]=hit[255:240];

//hit_sync
// 11111111111111111111111111111111
assign hit9_sync[24:17]=hit_sync[7:0];
assign hit11_sync[32:25]=hit_sync[15:8];
assign hit13_sync[32:25]=hit_sync[23:16];
assign hit15_sync[40:33]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[24:17]=hit_sync[39:32];
assign hit12_sync[32:25]=hit_sync[47:40];
assign hit14_sync[32:25]=hit_sync[55:48];
assign hit16_sync[40:33]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit17_sync[40:33]=hit_sync[71:64];
assign hit19_sync[40:33]=hit_sync[79:72];
//assign hitxxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

//444444444444444444444444444444444
assign hit18_sync[40:33]=hit_sync[103:96];
assign hit20_sync[40:33]=hit_sync[111:104];
//assign hitxxx =hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

//555555555555555555555555555555555
assign hit9_sync[32:25]=hit_sync[135:128];
assign hit13_sync[40:33]=hit_sync[143:136];
assign hit17_sync[48:41]=hit_sync[151:144];
assign hit19_sync[48:41]=hit_sync[159:152];

//666666666666666666666666666666666
assign hit10_sync[32:25]=hit_sync[167:160];
assign hit14_sync[40:33]=hit_sync[175:168];
assign hit18_sync[48:41]=hit_sync[183:176];
assign hit20_sync[48:41]=hit_sync[191:184];

//777777777777777777777777777777777
assign hit37_sync[48:33]=hit_sync[207:192];
assign hit38_sync[48:33]=hit_sync[223:208];
assign hit39_sync[48:33]=hit_sync[239:224];
assign hit40_sync[48:33]=hit_sync[255:240];

//up_neighbour_in data assembly
assign hit11[24:23] = up_neighbour_in[1:0];
assign hit12[24:23] = up_neighbour_in[3:2];

assign hit15[32:30] = up_neighbour_in[6:4];
assign hit16[32:29] = up_neighbour_in[10:7];

assign hit17[32:31] = up_neighbour_in[12:11];

assign hit37[32:31] = up_neighbour_in[14:13];
assign hit39[32:30] = up_neighbour_in[17:15];
assign hit40[32:28] = up_neighbour_in[22:18];

assign TSF3[22:19]  = up_neighbour_in[26:23];
assign TSF4[29:26]  = up_neighbour_in[30:27];
assign TSF10[32:17] = up_neighbour_in[46:31];

//down_neighbour_in data assembly 

assign hit11[34:33] = down_neighbour_in[1:0];
assign hit12[35:33] = down_neighbour_in[4:2];

assign hit15[42:41] = down_neighbour_in[6:5];
assign hit16[43:41] = down_neighbour_in[9:7];
//hit16[44]-----------------------------------
assign hit17[49] = down_neighbour_in[10];
assign hit19[53:49] = down_neighbour_in[15:11];
assign hit20[53:49] = down_neighbour_in[20:16];

assign hit37[49] = down_neighbour_in[21];
assign hit39[49] = down_neighbour_in[22];
assign hit40[51:49] = down_neighbour_in[25:23];

assign TSF3[35] = down_neighbour_in[26];
assign TSF4[43] = down_neighbour_in[27];
assign TSF10[62:49] = down_neighbour_in[41:28];

//up_neighbour_out data assembly
assign up_neighbour_out[3:0] = hit9_sync[20:17]; 
assign up_neighbour_out[7:4] = hit10_sync[20:17]; 

assign up_neighbour_out[10:8] = hit13_sync[27:25]; 
assign up_neighbour_out[13:11]= hit14_sync[27:25]; 

//assign up_neighbour_out[11]  = hit17_sync[33]; 
//assign hit19[36]
//assign hit20[37]
assign up_neighbour_out[16:14] = hit19_sync[35:33];  
assign up_neighbour_out[20:17] = hit20_sync[36:33]; 

assign up_neighbour_out[21] = hit37_sync[33]; 
assign up_neighbour_out[22] = hit39_sync[33]; 
assign up_neighbour_out[25:23] = hit40_sync[35:33];   

assign up_neighbour_out[27:26] = TSF3_sync[24:23];  
assign up_neighbour_out[41:28] = TSF10_sync[46:33];  

//down_neighbour_out data assembly

assign down_neighbour_out[3:0]  = hit9_sync[32:29];
assign down_neighbour_out[6:4]  = hit10_sync[32:30];

assign down_neighbour_out[10:7] = hit13_sync[40:37];
assign down_neighbour_out[13:11]= hit14_sync[40:38];
//hit17_sync[47]------------------------------------
assign down_neighbour_out[14]= hit17_sync[48];

assign down_neighbour_out[16:15]= hit37_sync[48:47];
//hit39_sync[46]
assign down_neighbour_out[18:17]= hit39_sync[48:47];
//hit40_sync[44]
assign down_neighbour_out[22:19]= hit40_sync[48:45];

assign down_neighbour_out[27:23]= TSF3_sync[34:30];
assign down_neighbour_out[30:28]= TSF4_sync[42:40];
assign down_neighbour_out[46:31]= TSF10_sync[48:33];


// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector3 INST_TSF3_Sector3(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[34:23]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector3 INST_TSF4_Sector3(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[42:30]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector3 INST_TSF5_Sector3(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[48:33]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector3 INST_TSF10_Sector3(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[48:33]),
					.clk(clk),
					.en(en)
                );

wire [6:0] float7;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({7'b0,TSF10_sync[48:33],TSF5_sync[48:33],TSF4_sync[42:30],TSF3_sync[34:23]}), 
					.TSF_delay({float7,TSF10[48:33],TSF5[48:33],TSF4[42:30],TSF3[34:23]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{7'b0,TSF10_sync[48:33],TSF5_sync[48:33],3'b0,TSF4_sync[42:30],4'b0,TSF3_sync[34:23]};

TF_Sector3 INST_TF_Sector3(
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
