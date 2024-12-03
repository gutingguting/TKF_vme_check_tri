`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/19/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector5
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
module Track_Finder_Engine_Sector5(hit_sync,up_neighbour_in, down_neighbour_in, 
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
assign hit9[48:41]=hit[7:0];
assign hit11[48:41]=hit[15:8];
assign hit13[56:49]=hit[23:16];
assign hit13[64:57]=hit[31:24];

//222222222222222222222222222222222
assign hit10[48:41]=hit[39:32];
assign hit12[48:41]=hit[47:40];
assign hit14[56:49]=hit[55:48];
assign hit14[64:57]=hit[63:56];

//333333333333333333333333333333333
assign hit15[64:57]=hit[71:64];
assign hit17[72:65]=hit[79:72];
assign hit19[80:73] =hit[87:80];
//assign hitxxx =hit[95:88];

//444444444444444444444444444444444
assign hit16[64:57]=hit[103:96];
assign hit18[72:65]=hit[111:104];
assign hit20[80:73]=hit[119:112];
//assign hitxxx =hit[127:120];

//555555555555555555555555555555555
assign hit11[56:49]=hit[135:128];
assign hit15[72:65]=hit[143:136];
assign hit17[80:73]=hit[151:144];
assign hit19[88:81]=hit[159:152];

//666666666666666666666666666666666
assign hit12[56:49]=hit[167:160];
assign hit16[72:65]=hit[175:168];
assign hit18[80:73]=hit[183:176];
assign hit20[88:81]=hit[191:184];

//777777777777777777777777777777777
assign hit37[80:65]=hit[207:192];
assign hit38[80:65]=hit[223:208];
assign hit39[80:65]=hit[239:224];
assign hit40[80:65]=hit[255:240];

//hit_sync

// 11111111111111111111111111111111
assign hit9_sync[48:41]=hit_sync[7:0];
assign hit11_sync[48:41]=hit_sync[15:8];
assign hit13_sync[56:49]=hit_sync[23:16];
assign hit13_sync[64:57]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[48:41]=hit_sync[39:32];
assign hit12_sync[48:41]=hit_sync[47:40];
assign hit14_sync[56:49]=hit_sync[55:48];
assign hit14_sync[64:57]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit15_sync[64:57]=hit_sync[71:64];
assign hit17_sync[72:65]=hit_sync[79:72];
assign hit19_sync[80:73] =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

//444444444444444444444444444444444
assign hit16_sync[64:57]=hit_sync[103:96];
assign hit18_sync[72:65]=hit_sync[111:104];
assign hit20_sync[80:73]=hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

//555555555555555555555555555555555
assign hit11_sync[56:49]=hit_sync[135:128];
assign hit15_sync[72:65]=hit_sync[143:136];
assign hit17_sync[80:73]=hit_sync[151:144];
assign hit19_sync[88:81]=hit_sync[159:152];

//666666666666666666666666666666666
assign hit12_sync[56:49]=hit_sync[167:160];
assign hit16_sync[72:65]=hit_sync[175:168];
assign hit18_sync[80:73]=hit_sync[183:176];
assign hit20_sync[88:81]=hit_sync[191:184];

//777777777777777777777777777777777
assign hit37_sync[80:65]=hit_sync[207:192];
assign hit38_sync[80:65]=hit_sync[223:208];
assign hit39_sync[80:65]=hit_sync[239:224];
assign hit40_sync[80:65]=hit_sync[255:240];


//up_neighbour_in data assembly
assign hit9[40:38] = up_neighbour_in[2:0];
assign hit10[40:39]= up_neighbour_in[4:3];

assign hit15[56:55]= up_neighbour_in[6:5];
//// hit16-C54-------------------------------------
assign hit16[56:55]= up_neighbour_in[8:7];
//
assign hit17[64]   = up_neighbour_in[9];
assign hit19[72:69]= up_neighbour_in[13:10];
assign hit20[72:69]= up_neighbour_in[17:14];


assign hit37[64:63]= up_neighbour_in[19:18];
////hit39-C62--------------------------------------
assign hit39[64:63]= up_neighbour_in[21:20];
assign hit40[64:61]= up_neighbour_in[25:22];

assign TSF3[44:41] = up_neighbour_in[29:26];
assign TSF4[54]    = up_neighbour_in[30];
assign TSF10[64:49]= up_neighbour_in[46:31];

//down_neighbour_in data assembly 
assign hit9[50:49]  = down_neighbour_in[1:0];
assign hit10[50:49] = down_neighbour_in[3:2];
assign hit12[57]    = down_neighbour_in[4];

assign hit13[66:65] = down_neighbour_in[6:5];
assign hit14[66:65] = down_neighbour_in[8:7];
assign hit16[74:73] = down_neighbour_in[10:9];

assign hit17[81]    = down_neighbour_in[11];
assign hit20[89]    = down_neighbour_in[12];

assign hit37[81]    = down_neighbour_in[13];
assign hit39[81]    = down_neighbour_in[14];
assign hit40[83:81] = down_neighbour_in[17:15];

assign TSF3[57]     = down_neighbour_in[18];
assign TSF10[94:81] = down_neighbour_in[32:19];

//
//up_neighbour_out data assembly

assign up_neighbour_out[3:0]  =hit11_sync[44:41];
assign up_neighbour_out[8:4]  =hit12_sync[45:41];

assign up_neighbour_out[10:9] =hit13_sync[50:49];
assign up_neighbour_out[12:11]=hit14_sync[50:49];

assign up_neighbour_out[13]   =hit17_sync[65];

assign up_neighbour_out[14]   =hit37_sync[65]  ;
assign up_neighbour_out[15]   =hit39_sync[65];
assign up_neighbour_out[18:16]=hit40_sync[67:65];

assign up_neighbour_out[20:19]=TSF3_sync[46:45];
assign up_neighbour_out[23:21]=TSF4_sync[57:55];
assign up_neighbour_out[37:24]=TSF10_sync[78:65];

assign up_neighbour_out[41:38]=0;

////down_neighbour_out data assembly
//
assign down_neighbour_out[0] = hit9_sync[48];
assign down_neighbour_out[1] = hit13_sync[64];
assign down_neighbour_out[2] = hit16_sync[72];

assign down_neighbour_out[4:3] = hit17_sync[80:79];
assign down_neighbour_out[6:5] = hit19_sync[88:87];
assign down_neighbour_out[8:7] = hit20_sync[88:87];

assign down_neighbour_out[10:9] = hit37_sync[80:79];
assign down_neighbour_out[13:11] = hit39_sync[80:78];
assign down_neighbour_out[18:14] = hit40_sync[80:76];

assign down_neighbour_out[23:19] = TSF3_sync[56:52];
assign down_neighbour_out[28:24] = TSF4_sync[72:68];
assign down_neighbour_out[44:29] = TSF10_sync[80:65];
assign down_neighbour_out[46:45] = 0;

// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector5 INST_TSF3_Sector5(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[56:45]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector5 INST_TSF4_Sector5(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[72:55]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector5 INST_TSF5_Sector5(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[80:65]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector5 INST_TSF10_Sector5(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[80:65]),
					.clk(clk),
					.en(en)
                );

wire [1:0] float2;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({2'b0,TSF10_sync[80:65],TSF5_sync[80:65],TSF4_sync[72:55],TSF3_sync[56:45]}), 
					.TSF_delay({float2,TSF10[80:65],TSF5[80:65],TSF4[72:55],TSF3[56:45]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{TSF10_sync[80:65],TSF5_sync[80:65],TSF4_sync[72:55],2'b0,TSF3_sync[56:45]};

TF_Sector5 INST_TF_Sector5(
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
