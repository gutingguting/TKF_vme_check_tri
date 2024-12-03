`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Create Date:    08:59:11 08/04/06
// Module Name:    TrackFinder
//////////////////////////////////////////////////////////////////////////////// 
module TrackFinder_top( clk, reset, GA, TF_en
									,Long_Track, Short_Track
									,hit_in,up_neighbour_in, down_neighbour_in 
                           ,up_neighbour_out, down_neighbour_out
									,TSF_ReadOut,Sector_select
									,hitdelay_test
								 );
    input clk;
    input reset;
	 input [4:0] GA;
	 input TF_en;
	 input [319:0] hit_in;
    input [46:0] up_neighbour_in;
    input [41:0] down_neighbour_in;
    output [41:0] up_neighbour_out;
    output [46:0] down_neighbour_out;
    output [15:0] Long_Track;
	 output [15:0] Short_Track;
	 output [63:0] TSF_ReadOut;
	 output [4:0] Sector_select;

	 output  hitdelay_test;
	 wire    hitdelay_test;

    reg [41:0] up_neighbour_out;
    reg [46:0] down_neighbour_out;
    reg [15:0] Long_Track;
	 reg [15:0] Short_Track;
	 reg [63:0] TSF_ReadOut;

wire [255:0] hit_sync;
reg [191:0] hit_sync_pre;
reg [8:1] en;
wire [15:0] LTK[8:1],STK[8:1];
wire [63:0] TSF[8:1];
wire [41:0] up_neighbour_o[8:1];
wire [46:0] down_neighbour_o[8:1];
reg  [4:0]  Sector_select;

//SL10 signal mapping:
 
//Layer ----37---- 37-4,37-3  hit_in[271:256];  #########   37-2,37-1  hit_in[207:192];  

//Layer ----38---- 38-4,38-3  hit_in[303:288];  #########   38-2,38-1  hit_in[239:224];

//Layer ----39---- 39-4,39-3  hit_in[287:272];	#########   39-2,39-1  hit_in[223:208];

//Layer ----40---- 40-4,40-3  hit_in[319:304];  #########   40-2,40-1  hit_in[255:240];

SL10_Combination INST_SL10_Combination(
									.clk(clk),
									.en(TF_en),
									.hit37_i({hit_in[271:256],hit_in[207:192]}), 
									.hit38_i({hit_in[303:288],hit_in[239:224]}),
									.hit39_i({hit_in[287:272],hit_in[223:208]}), 
									.hit40_i({hit_in[319:304],hit_in[255:240]}), 
									.hit37(hit_sync[207:192]),
									.hit38(hit_sync[223:208]), 
                           .hit39(hit_sync[239:224]),
									.hit40(hit_sync[255:240])
													);
always@(posedge clk)
begin
	if(en)
		begin
			hit_sync_pre[191:0]  <= hit_in[191:0];
		end
end

assign hit_sync[191:0] = hit_sync_pre;

always@(GA or up_neighbour_o[1] or up_neighbour_o[2] or up_neighbour_o[3] or up_neighbour_o[4] 
           or up_neighbour_o[5] or up_neighbour_o[6] or up_neighbour_o[7] or up_neighbour_o[8]
			  or down_neighbour_o[1] or down_neighbour_o[2] or down_neighbour_o[3] or down_neighbour_o[4] 
           or down_neighbour_o[5] or down_neighbour_o[6] or down_neighbour_o[7] or down_neighbour_o[8]
			  or LTK[1] or LTK[2] or LTK[3] or LTK[4] or LTK[5] or LTK[6] or LTK[7] or LTK[8] 
			  or STK[1] or STK[2] or STK[3] or STK[4] or STK[5] or STK[6] or STK[7] or STK[8]
			  or TSF[1] or TSF[2] or TSF[3] or TSF[4] or TSF[5] or TSF[6] or TSF[7] or TSF[8]
			  )
begin									
	case (GA)
		5'h6 : 
			begin 
				up_neighbour_out = up_neighbour_o[1]; 
				down_neighbour_out = down_neighbour_o[1]; 
				Long_Track = LTK[1];
				Short_Track = STK[1];
				en[8:1] = 8'b0000_0001;
				TSF_ReadOut <= TSF[1];
				Sector_select <= 5'h1;
			end
		5'h7 : 
			begin 
				up_neighbour_out = up_neighbour_o[2]; 
				down_neighbour_out = down_neighbour_o[2]; 
				Long_Track = LTK[2];
				Short_Track = STK[2];
				en[8:1] = 8'b0000_0010;
				TSF_ReadOut <= TSF[2];
				Sector_select <= 5'h2;
			end
		5'h8 : 
			begin 
				up_neighbour_out = up_neighbour_o[3]; 
				down_neighbour_out = down_neighbour_o[3]; 
				Long_Track = LTK[3];
				Short_Track = STK[3];
				en[8:1] = 8'b0000_0100;
				TSF_ReadOut <= TSF[3];
				Sector_select <= 5'h3;
			end
		5'h9 : 
			begin 
				up_neighbour_out = up_neighbour_o[4]; 
				down_neighbour_out = down_neighbour_o[4]; 
				Long_Track = LTK[4];
				Short_Track = STK[4];
				en[8:1] = 8'b0000_1000;
				TSF_ReadOut <= TSF[4];
				Sector_select <= 5'h4;
			end
		5'ha :
			begin 
				up_neighbour_out = up_neighbour_o[5]; 
				down_neighbour_out = down_neighbour_o[5]; 
				Long_Track = LTK[5];
				Short_Track = STK[5];
				en[8:1] = 8'b0001_0000;
				TSF_ReadOut <= TSF[5];
				Sector_select <= 5'h5;
			end
		5'hb:
			begin 
				up_neighbour_out = up_neighbour_o[6]; 
				down_neighbour_out = down_neighbour_o[6]; 
				Long_Track = LTK[6];
				Short_Track = STK[6];
				en[8:1] = 8'b0010_0000;
				TSF_ReadOut <= TSF[6];
				Sector_select <= 5'h6;
			end
		5'hc :
			begin 
				up_neighbour_out = up_neighbour_o[7]; 
				down_neighbour_out = down_neighbour_o[7]; 
				Long_Track = LTK[7];
				Short_Track = STK[7];
				en[8:1] = 8'b0100_0000;
				TSF_ReadOut <= TSF[7];
				Sector_select <= 5'h7;
			end
		5'hd : 
			begin 
				up_neighbour_out = up_neighbour_o[8]; 
				down_neighbour_out = down_neighbour_o[8]; 
				Long_Track = LTK[8];
				Short_Track = STK[8];
				en[8:1] = 8'b1000_0000;
				TSF_ReadOut <= TSF[8];
				Sector_select <= 5'h8;
			end
		5'he : 
			begin 
				up_neighbour_out = up_neighbour_o[1]; 
				down_neighbour_out = down_neighbour_o[1]; 
				Long_Track = LTK[1];
				Short_Track = STK[1];
				en[8:1] = 8'b0000_0001;
				TSF_ReadOut <= TSF[1];
				Sector_select <= 5'h1;
			end
		5'hf : 
			begin 
				up_neighbour_out = up_neighbour_o[2]; 
				down_neighbour_out = down_neighbour_o[2]; 
				Long_Track = LTK[2];
				Short_Track = STK[2];
				en[8:1] = 8'b0000_0010;
				TSF_ReadOut <= TSF[2];
				Sector_select <= 5'h2;
			end
		5'h10 : 
			begin 
				up_neighbour_out = up_neighbour_o[3]; 
				down_neighbour_out = down_neighbour_o[3]; 
				Long_Track = LTK[3];
				Short_Track = STK[3];
				en[8:1] = 8'b0000_0100;
				TSF_ReadOut <= TSF[3];
				Sector_select <= 5'h3;
			end
		5'h11 : 
			begin 
				up_neighbour_out = up_neighbour_o[4]; 
				down_neighbour_out = down_neighbour_o[4]; 
				Long_Track = LTK[4];
				Short_Track = STK[4];
				en[8:1] = 8'b0000_1000;
				TSF_ReadOut <= TSF[4];
				Sector_select <= 5'h4;
			end
		5'h12 :
			begin 
				up_neighbour_out = up_neighbour_o[5]; 
				down_neighbour_out = down_neighbour_o[5]; 
				Long_Track = LTK[5];
				Short_Track = STK[5];
				en[8:1] = 8'b0001_0000;
				TSF_ReadOut <= TSF[5];
				Sector_select <= 5'h5;
			end
		5'h13:
			begin 
				up_neighbour_out = up_neighbour_o[6]; 
				down_neighbour_out = down_neighbour_o[6]; 
				Long_Track = LTK[6];
				Short_Track = STK[6];
				en[8:1] = 8'b0010_0000;
				TSF_ReadOut <= TSF[6];
				Sector_select <= 5'h6;
			end
		5'h14 :
			begin 
				up_neighbour_out = up_neighbour_o[7]; 
				down_neighbour_out = down_neighbour_o[7]; 
				Long_Track = LTK[7];
				Short_Track = STK[7];
				en[8:1] = 8'b0100_0000;
				TSF_ReadOut <= TSF[7];
				Sector_select <= 5'h7;
			end
		5'h15 : 
			begin 
				up_neighbour_out = up_neighbour_o[8]; 
				down_neighbour_out = down_neighbour_o[8]; 
				Long_Track = LTK[8];
				Short_Track = STK[8];
				en[8:1] = 8'b1000_0000;
				TSF_ReadOut <= TSF[8];
				Sector_select <= 5'h8;
			end

		default: 
			begin 
				up_neighbour_out =  47'hzzzz_zzzz_zzzz; 
				down_neighbour_out =  42'hzzz_zzzz_zzzz; 
				Long_Track = LTK[1];
				Short_Track = STK[1];
				en[8:1] = 8'b0000_0001;
				TSF_ReadOut <= TSF[1];
				Sector_select <= 5'h0;
			end
	endcase
end


Track_Finder_Engine_Sector1 INST_Track_Finder_Engine_Sector1(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[1]), 
									.down_neighbour_out(down_neighbour_o[1]), 
                           .Short_Track(STK[1]), 
									.Long_Track(LTK[1]), 
									.TSF(TSF[1]),
									.clk(clk), 
									.en(en[1])
									,.hitdelay_test(hitdelay_test)
									);

Track_Finder_Engine_Sector2 INST_Track_Finder_Engine_Sector2(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[2]), 
									.down_neighbour_out(down_neighbour_o[2]), 
                           .Short_Track(STK[2]), 
									.Long_Track(LTK[2]), 
									.TSF(TSF[2]),
									.clk(clk), 
									.en(en[2])
									);
Track_Finder_Engine_Sector3 INST_Track_Finder_Engine_Sector3(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[3]), 
									.down_neighbour_out(down_neighbour_o[3]), 
                           .Short_Track(STK[3]), 
									.Long_Track(LTK[3]), 
									.TSF(TSF[3]),
									.clk(clk), 
									.en(en[3])
									);
Track_Finder_Engine_Sector4 INST_Track_Finder_Engine_Sector4(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[4]), 
									.down_neighbour_out(down_neighbour_o[4]), 
                           .Short_Track(STK[4]), 
									.Long_Track(LTK[4]), 
									.TSF(TSF[4]),
									.clk(clk), 
									.en(en[4])
									);
Track_Finder_Engine_Sector5 INST_Track_Finder_Engine_Sector5(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[5]), 
									.down_neighbour_out(down_neighbour_o[5]), 
                           .Short_Track(STK[5]), 
									.Long_Track(LTK[5]), 
									.TSF(TSF[5]),
									.clk(clk), 
									.en(en[5])
									);
Track_Finder_Engine_Sector6 INST_Track_Finder_Engine_Sector6(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[6]), 
									.down_neighbour_out(down_neighbour_o[6]), 
                           .Short_Track(STK[6]), 
									.Long_Track(LTK[6]), 
									.TSF(TSF[6]),
									.clk(clk), 
									.en(en[6])
									);
Track_Finder_Engine_Sector7 INST_Track_Finder_Engine_Sector7(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[7]), 
									.down_neighbour_out(down_neighbour_o[7]), 
                           .Short_Track(STK[7]), 
									.Long_Track(LTK[7]), 
									.TSF(TSF[7]),
									.clk(clk), 
									.en(en[7])
									);
Track_Finder_Engine_Sector8 INST_Track_Finder_Engine_Sector8(
									.hit_sync(hit_sync), 
									.up_neighbour_in(up_neighbour_in), 
									.down_neighbour_in(down_neighbour_in), 
                           .up_neighbour_out(up_neighbour_o[8]), 
									.down_neighbour_out(down_neighbour_o[8]), 
                           .Short_Track(STK[8]), 
									.Long_Track(LTK[8]), 
									.TSF(TSF[8]),
									.clk(clk), 
									.en(en[8])
									);



endmodule
