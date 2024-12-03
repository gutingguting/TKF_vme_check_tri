`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 02/07/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector1
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
module Track_Finder_Engine_Sector1(hit_sync,up_neighbour_in, down_neighbour_in, 
                                      up_neighbour_out, down_neighbour_out, 
                                      Short_Track, Long_Track, TSF,clk, en
												  ,hitdelay_test);
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
	 output  hitdelay_test;

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
assign hit9[8:1]=hit[7:0];
assign hit11[8:1]=hit[15:8];
assign hit13[8:1]=hit[23:16];
assign hit15[8:1]=hit[31:24];

assign hit10[8:1]=hit[39:32];
assign hit12[8:1]=hit[47:40];
assign hit14[8:1]=hit[55:48];
assign hit16[8:1]=hit[63:56];

assign hit17[8:1]=hit[71:64];
assign hit19[8:1]=hit[79:72];
//assign hitxxx =hit[87:80];
//assign hitxxx =hit[95:88];

assign hit18[8:1]=hit[103:96];
assign hit20[8:1]=hit[111:104];
//assign hitxxx =hit[119:112];
//assign hitxxx =hit[127:120];

assign hit13[16:9]=hit[135:128];
assign hit15[16:9]=hit[143:136];
assign hit17[16:9]=hit[151:144];
assign hit19[16:9]=hit[159:152];

assign hit14[16:9]=hit[167:160];
assign hit16[16:9]=hit[175:168];
assign hit18[16:9]=hit[183:176];
assign hit20[16:9]=hit[191:184];

assign hit37[16:1]=hit[207:192];
assign hit38[16:1]=hit[223:208];
assign hit39[16:1]=hit[239:224];
assign hit40[16:1]=hit[255:240];

assign hit9_sync[8:1]=hit_sync[7:0];
assign hit11_sync[8:1]=hit_sync[15:8];
assign hit13_sync[8:1]=hit_sync[23:16];
assign hit15_sync[8:1]=hit_sync[31:24];

assign hit10_sync[8:1]=hit_sync[39:32];
assign hit12_sync[8:1]=hit_sync[47:40];
assign hit14_sync[8:1]=hit_sync[55:48];
assign hit16_sync[8:1]=hit_sync[63:56];

assign hit17_sync[8:1]=hit_sync[71:64];
assign hit19_sync[8:1]=hit_sync[79:72];
//assign hitxxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

assign hit18_sync[8:1]=hit_sync[103:96];
assign hit20_sync[8:1]=hit_sync[111:104];
//assign hitxxx =hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

assign hit13_sync[16:9]=hit_sync[135:128];
assign hit15_sync[16:9]=hit_sync[143:136];
assign hit17_sync[16:9]=hit_sync[151:144];
assign hit19_sync[16:9]=hit_sync[159:152];

assign hit14_sync[16:9]=hit_sync[167:160];
assign hit16_sync[16:9]=hit_sync[175:168];
assign hit18_sync[16:9]=hit_sync[183:176];
assign hit20_sync[16:9]=hit_sync[191:184];

assign hit37_sync[16:1]=hit_sync[207:192];
assign hit38_sync[16:1]=hit_sync[223:208];
assign hit39_sync[16:1]=hit_sync[239:224];
assign hit40_sync[16:1]=hit_sync[255:240];

//up_neighbour_in data assembly
assign hit9[76]=up_neighbour_in[0];

assign hit13[100]=up_neighbour_in[1];
assign hit14[100]=up_neighbour_in[2];
assign hit16[112]=up_neighbour_in[3];

assign hit17[128:127]=up_neighbour_in[5:4];
assign hit19[140:139]=up_neighbour_in[7:6];
assign hit20[140:139]=up_neighbour_in[9:8];

assign hit37[128:127]=up_neighbour_in[11:10];
assign hit39[128:127]=up_neighbour_in[13:12];
assign hit40[128:124]=up_neighbour_in[18:14];

assign TSF3[88:85] = up_neighbour_in[22:19];
assign TSF4[112:110] = up_neighbour_in[25:23];
assign TSF10[128:113] = up_neighbour_in[41:26];

//down_neighbour_in data assembly
assign hit12[9]=down_neighbour_in[0];
assign hit16[18:17]=down_neighbour_in[2:1];

assign hit17[17]=down_neighbour_in[3];
assign hit19[18:17]=down_neighbour_in[5:4];
assign hit20[19:17]=down_neighbour_in[8:6];

assign hit37[17]=down_neighbour_in[9];
assign hit39[17]=down_neighbour_in[10];
assign hit40[19:17]=down_neighbour_in[13:11];

assign TSF3[13:9] = down_neighbour_in[18:14];
assign TSF10[30:17] = down_neighbour_in[32:19];

//up_neighbour_out data assembly
assign up_neighbour_out[0]=hit9_sync[1];
assign up_neighbour_out[1]=hit10_sync[1];
assign up_neighbour_out[2]=hit12_sync[1];

assign up_neighbour_out[3]=hit13_sync[1];
assign up_neighbour_out[4]=hit14_sync[1];
assign up_neighbour_out[6:5]=hit16_sync[2:1];

assign up_neighbour_out[7]=hit17_sync[1];
assign up_neighbour_out[8]=hit19_sync[1];
assign up_neighbour_out[10:9]=hit20_sync[2:1];

assign up_neighbour_out[11]=hit37_sync[1];
assign up_neighbour_out[12]=hit39_sync[1];
assign up_neighbour_out[15:13]=hit40_sync[3:1];

assign up_neighbour_out[17:16]=TSF3_sync[2:1];
assign up_neighbour_out[18]=TSF4_sync[1];
assign up_neighbour_out[32:19]=TSF10_sync[14:1];

assign up_neighbour_out[41:33]=0;

//down_neighbour_out data assembly
assign down_neighbour_out[1:0]=hit9_sync[8:7];
assign down_neighbour_out[3:2]=hit10_sync[8:7];

assign down_neighbour_out[6:4]=hit13_sync[16:14];
assign down_neighbour_out[8:7]=hit14_sync[16:15];
assign down_neighbour_out[9]=hit16_sync[16];

assign down_neighbour_out[11:10]=hit17_sync[16:15];

assign down_neighbour_out[13:12]=hit37_sync[16:15];
assign down_neighbour_out[16:14]=hit39_sync[16:14];
assign down_neighbour_out[21:17]=hit40_sync[16:12];

assign down_neighbour_out[22]=TSF3_sync[8];
assign down_neighbour_out[27:23]=TSF4_sync[16:12];
assign down_neighbour_out[43:28]=TSF10_sync[16:1];

assign down_neighbour_out[46:44]=0;

// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector1 INST_TSF3_Sector1(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[8:1]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector1 INST_TSF4_Sector1(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[16:1]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector1 INST_TSF5_Sector1(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[16:1]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector1 INST_TSF10_Sector1(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[16:1]),
					.clk(clk),
					.en(en)
                );

wire [7:0] float8;

// delay 2 clk of TSF in local board
TSF_delay INST_TSF_delay(
					.TSF({8'b0,TSF10_sync[16:1],TSF5_sync[16:1],TSF4_sync[16:1],TSF3_sync[8:1]}), 
					.TSF_delay({float8,TSF10[16:1],TSF5[16:1],TSF4[16:1],TSF3[8:1]}),
					.clk(clk), 
					.en(en) 
					);
assign TSF = {TSF10_sync[16:1],TSF5_sync[16:1],TSF4_sync[16:1],8'b0,TSF3_sync[8:1]};
 
TF_Sector1 INST_TF_Sector1(
					.TSF3(TSF3), 
					.TSF4(TSF4), 
					.TSF5(TSF5), 
					.TSF10(TSF10), 
					.LongTrack(Long_Track), 
					.ShortTrack(Short_Track), 
					.clk(clk),
					.en(en)
					);									
//test *********************************
assign hitdelay_test = hit[0];
//**************************************									
endmodule
