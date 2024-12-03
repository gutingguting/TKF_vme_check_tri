`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/19/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector7
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
module Track_Finder_Engine_Sector7(hit_sync,up_neighbour_in, down_neighbour_in, 
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
assign hit9[64:57]=hit[7:0];
assign hit11[72:65]=hit[15:8];
assign hit13[80:73]=hit[23:16];
assign hit15[96:89]=hit[31:24];

//222222222222222222222222222222222
assign hit10[64:57]=hit[39:32];
assign hit12[72:65]=hit[47:40];
assign hit14[80:73]=hit[55:48];
assign hit16[96:89]=hit[63:56];

//333333333333333333333333333333333
assign hit17[104:97]=hit[71:64];
assign hit19[112:105]=hit[79:72];
//assign hit19xxx =hit[87:80];
//assign hitxxx =hit[95:88];

//444444444444444444444444444444444
assign hit18[104:97]=hit[103:96];
assign hit20[112:105]=hit[111:104];
//assign hitxxx=hit[119:112];
//assign hitxxx =hit[127:120];

//555555555555555555555555555555555
assign hit11[80:73]=hit[135:128];
assign hit13[88:81]=hit[143:136];
assign hit17[112:105]=hit[151:144];
assign hit19[120:113]=hit[159:152];

//666666666666666666666666666666666
assign hit12[80:73]=hit[167:160];
assign hit14[88:81]=hit[175:168];
assign hit18[112:105]=hit[183:176];
assign hit20[120:113]=hit[191:184];

//777777777777777777777777777777777
assign hit37[112:97]=hit[207:192];
assign hit38[112:97]=hit[223:208];
assign hit39[112:97]=hit[239:224];
assign hit40[112:97]=hit[255:240];


//hit_sync

// 11111111111111111111111111111111
assign hit9_sync[64:57]=hit_sync[7:0];
assign hit11_sync[72:65]=hit_sync[15:8];
assign hit13_sync[80:73]=hit_sync[23:16];
assign hit15_sync[96:89]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[64:57]=hit_sync[39:32];
assign hit12_sync[72:65]=hit_sync[47:40];
assign hit14_sync[80:73]=hit_sync[55:48];
assign hit16_sync[96:89]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit17_sync[104:97]=hit_sync[71:64];
assign hit19_sync[112:105]=hit_sync[79:72];
//assign hit19xxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

//444444444444444444444444444444444
assign hit18_sync[104:97]=hit_sync[103:96];
assign hit20_sync[112:105]=hit_sync[111:104];
//assign hitxxx=hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

//555555555555555555555555555555555
assign hit11_sync[80:73]=hit_sync[135:128];
assign hit13_sync[88:81]=hit_sync[143:136];
assign hit17_sync[112:105]=hit_sync[151:144];
assign hit19_sync[120:113]=hit_sync[159:152];

//666666666666666666666666666666666
assign hit12_sync[80:73]=hit_sync[167:160];
assign hit14_sync[88:81]=hit_sync[175:168];
assign hit18_sync[112:105]=hit_sync[183:176];
assign hit20_sync[120:113]=hit_sync[191:184];

//777777777777777777777777777777777
assign hit37_sync[112:97]=hit_sync[207:192];
assign hit38_sync[112:97]=hit_sync[223:208];
assign hit39_sync[112:97]=hit_sync[239:224];
assign hit40_sync[112:97]=hit_sync[255:240];


//up_neighbour_in data assembly
assign hit9[56:55]  = up_neighbour_in[1:0];
assign hit10[56]    = up_neighbour_in[2];

assign hit15[88:85] = up_neighbour_in[6:3];
assign hit16[88:84] = up_neighbour_in[11:7];

assign hit17[96:95] = up_neighbour_in[13:12];
assign hit19[104]   = up_neighbour_in[14];
assign hit20[104]   = up_neighbour_in[15];

assign hit37[96:95] = up_neighbour_in[17:16];
assign hit39[96:94] = up_neighbour_in[20:18];
assign hit40[96:92] = up_neighbour_in[25:21];

assign TSF3[64:63]  = up_neighbour_in[27:26];
assign TSF4[84:82]  = up_neighbour_in[30:28];
assign TSF10[96:81] = up_neighbour_in[46:31];

//down_neighbour_in data assembly 
assign hit9[67:65]  = down_neighbour_in [2:0];
assign hit10[67:65] = down_neighbour_in [5:3];

assign hit15[97]    = down_neighbour_in [6];
assign hit16[99:97] = down_neighbour_in [9:7];

assign hit17[113]   = down_neighbour_in [10];
assign hit19[123:121] = down_neighbour_in [13:11];
assign hit20[124:121] = down_neighbour_in [17:14];

assign hit37[113]   = down_neighbour_in [18];
assign hit39[113]   = down_neighbour_in [19];
assign hit40[115:113]   = down_neighbour_in [22:20];

assign TSF3[79:77] = down_neighbour_in[25:23];
assign TSF4[99:98] = down_neighbour_in[27:26];
assign TSF10[126:113] = down_neighbour_in[41:28];

//up_neighbour_out data assembly
assign up_neighbour_out[0]     = hit10_sync[57];
assign up_neighbour_out[1]     = hit12_sync[65];

assign up_neighbour_out[5:2]   = hit13_sync[76:73];
assign up_neighbour_out[10:6]  = hit14_sync[77:73];

assign up_neighbour_out[11]    = hit17_sync[97];
assign up_neighbour_out[13:12] = hit19_sync[106:105];
assign up_neighbour_out[16:14] = hit20_sync[107:105];

assign up_neighbour_out[17]    = hit37_sync[97];
assign up_neighbour_out[18]    = hit39_sync[97];
assign up_neighbour_out[21:19] = hit40_sync[99:97];

assign up_neighbour_out[25:22] = TSF3_sync[68:65];
assign up_neighbour_out[39:26] = TSF10_sync[110:97];

assign up_neighbour_out[41:40] = 0;

////down_neighbour_out data assembly

assign down_neighbour_out[3:0] = hit11_sync[80:77];
assign down_neighbour_out[7:4] = hit12_sync[80:77];

assign down_neighbour_out[10:8] = hit13_sync[88:86];
assign down_neighbour_out[12:11] = hit14_sync[88:87];

assign down_neighbour_out[14:13] = hit17_sync[112:111];

assign down_neighbour_out[16:15] = hit37_sync[112:111];
assign down_neighbour_out[19:17] = hit39_sync[112:110];
assign down_neighbour_out[24:20] = hit40_sync[112:108];

assign down_neighbour_out[27:25] = TSF3_sync[76:74];
assign down_neighbour_out[29:28] = TSF4_sync[97:96];
assign down_neighbour_out[45:30] = TSF10_sync[112:97];

assign down_neighbour_out[46] = 0;

//
// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector7 INST_TSF3_Sector7(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[76:65]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector7 INST_TSF4_Sector7(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[97:85]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector7 INST_TSF5_Sector7(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[112:97]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector7 INST_TSF10_Sector7(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[112:97]),
					.clk(clk),
					.en(en)
                );

wire [6:0] float7;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({7'b0,TSF10_sync[112:97],TSF5_sync[112:97],TSF4_sync[97:85],TSF3_sync[76:65]}), 
					.TSF_delay({float7,TSF10[112:97],TSF5[112:97],TSF4[97:85],TSF3[76:65]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{TSF10_sync[112:97],TSF5_sync[112:97],3'b0,TSF4_sync[97:85],4'b0,TSF3_sync[76:65]};

TF_Sector7 INST_TF_Sector7(
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
