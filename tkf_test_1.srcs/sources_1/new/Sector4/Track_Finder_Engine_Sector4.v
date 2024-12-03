`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:27:30 03/19/07
// Design Name:    
// Module Name:    Track_Finder_Engine_Sector4
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
module Track_Finder_Engine_Sector4(hit_sync,up_neighbour_in, down_neighbour_in, 
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
assign hit9[40:33]=hit[7:0];
assign hit11[40:33]=hit[15:8];
assign hit13[48:41]=hit[23:16];
assign hit15[48:41]=hit[31:24];

//222222222222222222222222222222222
assign hit10[40:33]=hit[39:32];
assign hit12[40:33]=hit[47:40];
assign hit14[48:41]=hit[55:48];
assign hit16[48:41]=hit[63:56];

//333333333333333333333333333333333
assign hit17[56:49]=hit[71:64];
assign hit19[56:49]=hit[79:72];
//assign hitxxx =hit[87:80];
//assign hitxxx =hit[95:88];

//444444444444444444444444444444444
assign hit18[56:49]=hit[103:96];
assign hit20[56:49]=hit[111:104];
//assign hitxxx =hit[119:112];
//assign hitxxx =hit[127:120];

//555555555555555555555555555555555
assign hit15[56:49]=hit[135:128];
assign hit17[64:57]=hit[143:136];
assign hit19[64:57]=hit[151:144];
assign hit19[72:65]=hit[159:152];

//666666666666666666666666666666666
assign hit16[56:49]=hit[167:160];
assign hit18[64:57]=hit[175:168];
assign hit20[64:57]=hit[183:176];
assign hit20[72:65]=hit[191:184];

//777777777777777777777777777777777
assign hit37[64:49]=hit[207:192];
assign hit38[64:49]=hit[223:208];
assign hit39[64:49]=hit[239:224];
assign hit40[64:49]=hit[255:240];

//hit_sync
// 11111111111111111111111111111111
assign hit9_sync[40:33]=hit_sync[7:0];
assign hit11_sync[40:33]=hit_sync[15:8];
assign hit13_sync[48:41]=hit_sync[23:16];
assign hit15_sync[48:41]=hit_sync[31:24];

//222222222222222222222222222222222
assign hit10_sync[40:33]=hit_sync[39:32];
assign hit12_sync[40:33]=hit_sync[47:40];
assign hit14_sync[48:41]=hit_sync[55:48];
assign hit16_sync[48:41]=hit_sync[63:56];

//333333333333333333333333333333333
assign hit17_sync[56:49]=hit_sync[71:64];
assign hit19_sync[56:49]=hit_sync[79:72];
//assign hitxxx =hit_sync[87:80];
//assign hitxxx =hit_sync[95:88];

//444444444444444444444444444444444
assign hit18_sync[56:49]=hit_sync[103:96];
assign hit20_sync[56:49]=hit_sync[111:104];
//assign hitxxx =hit_sync[119:112];
//assign hitxxx =hit_sync[127:120];

//555555555555555555555555555555555
assign hit15_sync[56:49]=hit_sync[135:128];
assign hit17_sync[64:57]=hit_sync[143:136];
assign hit19_sync[64:57]=hit_sync[151:144];
assign hit19_sync[72:65]=hit_sync[159:152];

//666666666666666666666666666666666
assign hit16_sync[56:49]=hit_sync[167:160];
assign hit18_sync[64:57]=hit_sync[175:168];
assign hit20_sync[64:57]=hit_sync[183:176];
assign hit20_sync[72:65]=hit_sync[191:184];

//777777777777777777777777777777777
assign hit37_sync[64:49]=hit_sync[207:192];
assign hit38_sync[64:49]=hit_sync[223:208];
assign hit39_sync[64:49]=hit_sync[239:224];
assign hit40_sync[64:49]=hit_sync[255:240];

//up_neighbour_in data assembly
assign hit9[32:29] = up_neighbour_in[3:0];
assign hit10[32:30] = up_neighbour_in[6:4];

assign hit13[40:37] = up_neighbour_in[10:7];
assign hit14[40:38] = up_neighbour_in[13:11];

assign hit17[48] = up_neighbour_in[14];

assign hit37[48:47] = up_neighbour_in[16:15];
//hit39[46]
assign hit39[48:47] = up_neighbour_in[18:17];
//hit40[44]
assign hit40[48:45] = up_neighbour_in[22:19];

assign TSF3[34:30]  = up_neighbour_in[27:23];
assign TSF4[42:40]  = up_neighbour_in[30:28];
assign TSF10[48:33] = up_neighbour_in[46:31];


//down_neighbour_in data assembly 
assign hit11[44:41] = down_neighbour_in[3:0];
assign hit12[45:41] = down_neighbour_in[8:4];

assign hit13[50:49] = down_neighbour_in[10:9];
assign hit14[50:49] = down_neighbour_in[12:11];

assign hit17[65]    = down_neighbour_in[13];

assign hit37[65]    = down_neighbour_in[14];
assign hit39[65]    = down_neighbour_in[15];
assign hit40[67:65] = down_neighbour_in[18:16];

assign TSF3[46:45]  = down_neighbour_in[20:19];
assign TSF4[57:55]  = down_neighbour_in[23:21];
assign TSF10[78:65]  = down_neighbour_in[37:24];


//
//up_neighbour_out data assembly
assign up_neighbour_out[1:0] = hit11_sync[34:33]; 
assign up_neighbour_out[4:2] = hit12_sync[35:33]; 

assign up_neighbour_out[6:5] = hit15_sync[42:41]; 
assign up_neighbour_out[9:7] = hit16_sync[43:41]; 
////hit16[44]-----------------------------------

assign up_neighbour_out[10] = hit17_sync[49];  
assign up_neighbour_out[15:11] = hit19_sync[53:49]; 
assign up_neighbour_out[20:16] = hit20_sync[53:49]; 

assign up_neighbour_out[21] = hit37_sync[49]; 
assign up_neighbour_out[22] = hit39_sync[49];   
assign up_neighbour_out[25:23] = hit40_sync[51:49];  

assign up_neighbour_out[26] = TSF3_sync[35];  
assign up_neighbour_out[27] = TSF4_sync[43];  
assign up_neighbour_out[41:28] = TSF10_sync[62:49];  

////down_neighbour_out data assembly
assign down_neighbour_out[2:0]  = hit9_sync[40:38];
assign down_neighbour_out[4:3]  = hit10_sync[40:39];


assign down_neighbour_out[6:5]  = hit15_sync[56:55];
// hit16-C54-------------------------------------
assign down_neighbour_out[8:7]  = hit16_sync[56:55];

assign down_neighbour_out[9]   = hit17_sync[64];
assign down_neighbour_out[13:10]= hit19_sync[72:69];
assign down_neighbour_out[17:14]= hit20_sync[72:69];


assign down_neighbour_out[19:18]= hit37_sync[64:63];
//hit39-C62--------------------------------------
assign down_neighbour_out[21:20]= hit39_sync[64:63];
assign down_neighbour_out[25:22]= hit40_sync[64:61];

assign down_neighbour_out[29:26]= TSF3_sync[44:41];
assign down_neighbour_out[30]   = TSF4_sync[54];
assign down_neighbour_out[46:31]= TSF10_sync[64:49];
//

// delay 2 clk of hit in local board
hit_delay INST_hit_delay(
								.clk40(clk),
								.hit(hit_sync), 
								.en(en), 
								.hit_delay(hit)
								);


TSF3_Sector4 INST_TSF3_Sector4(
					.hit9(hit9),
					.hit10(hit10),
					.hit11(hit11),
					.hit12(hit12),
					.TSF3_sync(TSF3_sync[44:35]),
					.clk(clk),
					.en(en)
					 );

TSF4_Sector4 INST_TSF4_Sector4(
				   .hit13(hit13),
				   .hit14(hit14),
					.hit15(hit15),
					.hit16(hit16),
				   .TSF4_sync(TSF4_sync[54:43]),
					.clk(clk),
					.en(en)
                );

TSF5_Sector4 INST_TSF5_Sector4(
				   .hit17(hit17),
				   .hit18(hit18),
				   .hit19(hit19),
				   .hit20(hit20),
				   .TSF5_sync(TSF5_sync[64:49]),
					.clk(clk),
					.en(en)
                );

TSF10_Sector4 INST_TSF10_Sector4(
				   .hit37(hit37),
				   .hit38(hit38),
				   .hit39(hit39),
				   .hit40(hit40),
				   .TSF10_sync(TSF10_sync[64:49]),
					.clk(clk),
					.en(en)
                );

wire [9:0] float10;

// delay 2 clk of TSF in local board
// TSF [63:0] 
TSF_delay INST_TSF_delay(
					.TSF({10'b0,TSF10_sync[64:49],TSF5_sync[64:49],TSF4_sync[54:43],TSF3_sync[44:35]}), 
					.TSF_delay({float10,TSF10[64:49],TSF5[64:49],TSF4[54:43],TSF3[44:35]}),
					.clk(clk), 
					.en(en) 
					);

assign TSF=	{TSF10_sync[64:49],TSF5_sync[64:49],4'b0,TSF4_sync[54:43],6'b0,TSF3_sync[44:35]};

TF_Sector4 INST_TF_Sector4(
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
