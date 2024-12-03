`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/19/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector8
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
module Track_Finder_Engine_Sector8(hit_sync,up_neighbour_in, down_neighbour_in, 
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
assign hit9[72:65]=hit[7:0];
//------------------------------------
assign hit9[76:73]=hit[11:8];    //*****************
//------------------------------------
assign hit11[88:81]=hit[23:16];
assign hit13[96:89]=hit[31:24];

//222222222222222222222222222222222
assign hit10[72:65]=hit[39:32];
//------------------------------------
assign hit10[76:73]=hit[43:40];	//*****************
//------------------------------------
assign hit12[88:81]=hit[55:48];
assign hit14[96:89]=hit[63:56];

//333333333333333333333333333333333
assign hit15[104:97]=hit[71:64];
assign hit17[120:113]=hit[79:72];
assign hit19[128:121]=hit[87:80];
assign hit19[136:129]=hit[95:88];

//444444444444444444444444444444444
assign hit16[104:97]=hit[103:96];
assign hit18[120:113]=hit[111:104];
assign hit20[128:121]=hit[119:112];
assign hit20[136:129]=hit[127:120];

//555555555555555555555555555555555
//------------------------------------
assign hit13[100:97]=hit[131:128];	//*****************
//------------------------------------
assign hit15[112:105]=hit[143:136];
assign hit17[128:121]=hit[151:144];
//------------------------------------
assign hit19[140:137]=hit[155:152];	 //*****************
//------------------------------------

//666666666666666666666666666666666
//------------------------------------
assign hit14[100:97]=hit[163:160];	 //*****************
//------------------------------------
assign hit16[112:105]=hit[175:168];
assign hit18[128:121]=hit[183:176];
//------------------------------------
assign hit20[140:137]=hit[187:184];	 //*****************
//------------------------------------

//777777777777777777777777777777777
assign hit37[128:113]=hit[207:192];
assign hit38[128:113]=hit[223:208];
assign hit39[128:113]=hit[239:224];
assign hit40[128:113]=hit[255:240];


//hit_sync
// 11111111111111111111111111111111
assign hit9_sync[72:65]=hit_sync[7:0];
//------------------------------------
assign hit9_sync[76:73]=hit_sync[11:8];    //*****************
//------------------------------------
assign hit11_sync[88:81]=hit_sync[23:16];
assign hit13_sync[96:89]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[72:65]=hit_sync[39:32];
//------------------------------------
assign hit10_sync[76:73]=hit_sync[43:40];	//*****************
//------------------------------------
assign hit12_sync[88:81]=hit_sync[55:48];
assign hit14_sync[96:89]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit15_sync[104:97]=hit_sync[71:64];
assign hit17_sync[120:113]=hit_sync[79:72];
assign hit19_sync[128:121]=hit_sync[87:80];
assign hit19_sync[136:129]=hit_sync[95:88];

//444444444444444444444444444444444
assign hit16_sync[104:97]=hit_sync[103:96];
assign hit18_sync[120:113]=hit_sync[111:104];
assign hit20_sync[128:121]=hit_sync[119:112];
assign hit20_sync[136:129]=hit_sync[127:120];

//555555555555555555555555555555555
//------------------------------------
assign hit13_sync[100:97]=hit_sync[131:128];	//*****************
//------------------------------------
assign hit15_sync[112:105]=hit_sync[143:136];
assign hit17_sync[128:121]=hit_sync[151:144];
//------------------------------------
assign hit19_sync[140:137]=hit_sync[155:152];	 //*****************
//------------------------------------

//666666666666666666666666666666666
//------------------------------------
assign hit14_sync[100:97]=hit_sync[163:160];	 //*****************
//------------------------------------
assign hit16_sync[112:105]=hit_sync[175:168];
assign hit18_sync[128:121]=hit_sync[183:176];
//------------------------------------
assign hit20_sync[140:137]=hit_sync[187:184];	 //*****************
//------------------------------------

//777777777777777777777777777777777
assign hit37_sync[128:113]=hit_sync[207:192];
assign hit38_sync[128:113]=hit_sync[223:208];
assign hit39_sync[128:113]=hit_sync[239:224];
assign hit40_sync[128:113]=hit_sync[255:240];



//up_neighbour_in data assembly
assign hit11[80:77]   = up_neighbour_in[3:0];
assign hit12[80:77]   = up_neighbour_in[7:4];

assign hit13[88:86]   = up_neighbour_in[10:8];
assign hit14[88:87]   = up_neighbour_in[12:11];

assign hit17[112:111] = up_neighbour_in[14:13];

assign hit37[112:111] = up_neighbour_in[16:15];
assign hit39[112:110] = up_neighbour_in[19:17];
assign hit40[112:108] = up_neighbour_in[24:20];

assign TSF3[76:74]    = up_neighbour_in[27:25];
assign TSF4[97:96]    = up_neighbour_in[29:28];
assign TSF10[112:97]  = up_neighbour_in[45:30];


//down_neighbour_in data assembly 
assign hit9[1]     = down_neighbour_in[0];
assign hit10[1]    = down_neighbour_in[1];
assign hit12[1]    = down_neighbour_in[2];

assign hit13[1]    = down_neighbour_in[3];
assign hit14[1]    = down_neighbour_in[4];
assign hit16[2:1]  = down_neighbour_in[6:5];

assign hit17[1]    = down_neighbour_in[7];
assign hit19[1]    = down_neighbour_in[8];
assign hit20[2:1]  = down_neighbour_in[10:9];

assign hit37[1]    = down_neighbour_in[11];
assign hit39[1]    = down_neighbour_in[12];
assign hit40[3:1]  = down_neighbour_in[15:13];

assign TSF3[2:1]   = down_neighbour_in[17:16];
assign TSF4[1]     = down_neighbour_in[18];
assign TSF10[14:1] = down_neighbour_in[32:19];


//up_neighbour_out data assembly
assign up_neighbour_out[2:0]   = hit9_sync[67:65];
assign up_neighbour_out[5:3]   = hit10_sync[67:65];

assign up_neighbour_out[6]     = hit15_sync[97];
assign up_neighbour_out[9:7]   = hit16_sync[99:97];

assign up_neighbour_out[10]    = hit17_sync[113];
assign up_neighbour_out[13:11] = hit19_sync[123:121];
assign up_neighbour_out[17:14] = hit20_sync[124:121];

assign up_neighbour_out[18]    = hit37_sync[113];
assign up_neighbour_out[19]    = hit39_sync[113];
assign up_neighbour_out[22:20] = hit40_sync[115:113] ;

assign up_neighbour_out[25:23] = TSF3_sync[79:77];
assign up_neighbour_out[27:26] = TSF4_sync[99:98];
assign up_neighbour_out[41:28] = TSF10_sync[126:113];

////down_neighbour_out data assembly
assign down_neighbour_out[0]     = hit9_sync[76];

assign down_neighbour_out[1]     = hit13_sync[100];
assign down_neighbour_out[2]     = hit14_sync[100];
assign down_neighbour_out[3]     = hit16_sync[112];

assign down_neighbour_out[5:4]   = hit17_sync[128:127];
assign down_neighbour_out[7:6]   = hit19_sync[140:139];
assign down_neighbour_out[9:8]   = hit20_sync[140:139];

assign down_neighbour_out[11:10] = hit37_sync[128:127];
assign down_neighbour_out[13:12] = hit39_sync[128:127];
assign down_neighbour_out[18:14] = hit40_sync[128:124];

assign down_neighbour_out[22:19] = TSF3_sync[88:85];
assign down_neighbour_out[25:23] = TSF4_sync[112:110];
assign down_neighbour_out[41:26] = TSF10_sync[128:113];

assign down_neighbour_out[46:42] = 0;

//
// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector8 INST_TSF3_Sector8(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[88:77]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector8 INST_TSF4_Sector8(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[112:98]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector8 INST_TSF5_Sector8(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[128:113]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector8 INST_TSF10_Sector8(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[128:113]),
					.clk(clk),
					.en(en)
                );

wire [4:0] float5;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({5'b0,TSF10_sync[128:113],TSF5_sync[128:113],TSF4_sync[112:98],TSF3_sync[88:77]}), 
					.TSF_delay({float5,TSF10[128:113],TSF5[128:113],TSF4[112:98],TSF3[88:77]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{TSF10_sync[128:113],TSF5_sync[128:113],1'b0,TSF4_sync[112:98],4'b0,TSF3_sync[88:77]};

TF_Sector8 INST_TF_Sector8(
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
