`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/19/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector6
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
module Track_Finder_Engine_Sector6(hit_sync,up_neighbour_in, down_neighbour_in, 
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
assign hit9[56:49]=hit[7:0];
assign hit11[64:57]=hit[15:8];
assign hit13[72:65]=hit[23:16];
assign hit15[80:73]=hit[31:24];

//222222222222222222222222222222222
assign hit10[56:49]=hit[39:32];
assign hit12[64:57]=hit[47:40];
assign hit14[72:65]=hit[55:48];
assign hit16[80:73]=hit[63:56];

//333333333333333333333333333333333
assign hit17[88:81]=hit[71:64];
assign hit19[96:89]=hit[79:72];
//assign hit19xxx =hit[87:80];
//assign hitxxx =hit[95:88];

//444444444444444444444444444444444
assign hit18[88:81]=hit[103:96];
assign hit20[96:89]=hit[111:104];
//assign hitxxx=hit[119:112];
//assign hitxxx =hit[127:120];

//555555555555555555555555555555555
assign hit15[88:81]=hit[135:128];
assign hit17[96:89]=hit[143:136];
assign hit19[104:97]=hit[151:144];
//assign hitxxx=hit[159:152];

//666666666666666666666666666666666
assign hit16[88:81]=hit[167:160];
assign hit18[96:89]=hit[175:168];
assign hit20[104:97]=hit[183:176];
//assign hit20xxx=hit[191:184];

//777777777777777777777777777777777
assign hit37[96:81]=hit[207:192];
assign hit38[96:81]=hit[223:208];
assign hit39[96:81]=hit[239:224];
assign hit40[96:81]=hit[255:240];


//hit_sync

// 11111111111111111111111111111111
assign hit9_sync[56:49]=hit_sync[7:0];
assign hit11_sync[64:57]=hit_sync[15:8];
assign hit13_sync[72:65]=hit_sync[23:16];
assign hit15_sync[80:73]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[56:49]=hit_sync[39:32];
assign hit12_sync[64:57]=hit_sync[47:40];
assign hit14_sync[72:65]=hit_sync[55:48];
assign hit16_sync[80:73]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit17_sync[88:81]=hit_sync[71:64];
assign hit19_sync[96:89]=hit_sync[79:72];
//assign hit19xxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

//444444444444444444444444444444444
assign hit18_sync[88:81]=hit_sync[103:96];
assign hit20_sync[96:89]=hit_sync[111:104];
//assign hitxxx=hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

//555555555555555555555555555555555
assign hit15_sync[88:81]=hit_sync[135:128];
assign hit17_sync[96:89]=hit_sync[143:136];
assign hit19_sync[104:97]=hit_sync[151:144];
//assign hitxxx=hit_sync[159:152];

//666666666666666666666666666666666
assign hit16_sync[88:81]=hit_sync[167:160];
assign hit18_sync[96:89]=hit_sync[175:168];
assign hit20_sync[104:97]=hit_sync[183:176];
//assign hit20xxx=hit_sync[191:184];

//777777777777777777777777777777777
assign hit37_sync[96:81]=hit_sync[207:192];
assign hit38_sync[96:81]=hit_sync[223:208];
assign hit39_sync[96:81]=hit_sync[239:224];
assign hit40_sync[96:81]=hit_sync[255:240];


//up_neighbour_in data assembly
assign hit9[48] = up_neighbour_in[0];

assign hit13[64] = up_neighbour_in[1];
assign hit16[72] = up_neighbour_in[2];

assign hit17[80:79] = up_neighbour_in[4:3];
assign hit19[88:87] = up_neighbour_in[6:5];
assign hit20[88:87] = up_neighbour_in[8:7];

assign hit37[80:79] = up_neighbour_in[10:9];
assign hit39[80:78] = up_neighbour_in[13:11];
assign hit40[80:76] = up_neighbour_in[18:14];

assign TSF3[56:52]  = up_neighbour_in[23:19];
assign TSF4[72:68]  = up_neighbour_in[28:24];
assign TSF10[80:65] = up_neighbour_in[44:29];

//down_neighbour_in data assembly 
assign hit10[57]=down_neighbour_in[0];
assign hit12[65]=down_neighbour_in[1];

assign hit13[76:73]=down_neighbour_in[5:2];
assign hit14[77:73]=down_neighbour_in[10:6];

assign hit17[97]=down_neighbour_in[11];
assign hit19[106:105]=down_neighbour_in[13:12];
assign hit20[107:105]=down_neighbour_in[16:14];

assign hit37[97]=down_neighbour_in[17];
assign hit39[97]=down_neighbour_in[18];
assign hit40[99:97]=down_neighbour_in[21:19];

assign TSF3[68:65]=down_neighbour_in[25:22];
assign TSF10[110:97]=down_neighbour_in[39:26];

//up_neighbour_out data assembly
assign up_neighbour_out[1:0]=hit9_sync[50:49];
assign up_neighbour_out[3:2]=hit10_sync[50:49];
assign up_neighbour_out[4]=hit12_sync[57];

assign up_neighbour_out[6:5]=hit13_sync[66:65];
assign up_neighbour_out[8:7]=hit14_sync[66:65];
assign up_neighbour_out[10:9]=hit16_sync[74:73];

assign up_neighbour_out[11]=hit17_sync[81];
assign up_neighbour_out[12]=hit20_sync[89];

assign up_neighbour_out[13]=hit37_sync[81];
assign up_neighbour_out[14]=hit39_sync[81];
assign up_neighbour_out[17:15]=hit40_sync[83:81];

assign up_neighbour_out[18]=TSF3_sync[57];
assign up_neighbour_out[32:19]=TSF10_sync[94:81];
assign up_neighbour_out[41:33]=0;

////down_neighbour_out data assembly
assign down_neighbour_out[1:0] = hit9_sync[56:55];
assign down_neighbour_out[2]   = hit10_sync[56];

assign down_neighbour_out[6:3] = hit15_sync[88:85];
assign down_neighbour_out[11:7] = hit16_sync[88:84];

assign down_neighbour_out[13:12] = hit17_sync[96:95];
assign down_neighbour_out[14] = hit19_sync[104];
assign down_neighbour_out[15] = hit20_sync[104];

assign down_neighbour_out[17:16] = hit37_sync[96:95];
assign down_neighbour_out[20:18] = hit39_sync[96:94];
assign down_neighbour_out[25:21] = hit40_sync[96:92];

assign down_neighbour_out[27:26] = TSF3_sync[64:63];
assign down_neighbour_out[30:28] = TSF4_sync[84:82];
assign down_neighbour_out[46:31] = TSF10_sync[96:81];

//
// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector6 INST_TSF3_Sector6(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[64:57]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector6 INST_TSF4_Sector6(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[84:73]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector6 INST_TSF5_Sector6(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[96:81]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector6 INST_TSF10_Sector6(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[96:81]),
					.clk(clk),
					.en(en)
                );

wire [11:0] float12;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({12'b0,TSF10_sync[96:81],TSF5_sync[96:81],TSF4_sync[84:73],TSF3_sync[64:57]}), 
					.TSF_delay({float12,TSF10[96:81],TSF5[96:81],TSF4[84:73],TSF3[64:57]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{TSF10_sync[96:81],TSF5_sync[96:81],4'b0,TSF4_sync[84:73],8'b0,TSF3_sync[64:57]};

TF_Sector6 INST_TF_Sector6(
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
