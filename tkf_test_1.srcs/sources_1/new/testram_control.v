`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    08:54:45 01/09/07
// Design Name:    
// Module Name:    testram_control
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
module testram_control(clk40, wr_ram, rd_ram, loop, testdata_send, reset, 
                          addr, v2p_data, data_o);
    input clk40;
    input wr_ram;
    input rd_ram;
    input loop;
    input testdata_send;
    input reset;
    input [15:0] addr;
    inout [31:0] v2p_data;
//    input [31:0] v2p_data;
    output [319:0] data_o;

reg [31:0] data_bus;
wire [31:0] data_i;
wire        clk_w,clk_r;
wire [11:0] add_w,add_r;
//reg [3:0]  w_select,r_select;
reg  [11:0]  add_wr_counter,add_rd_counter;
reg  [11:0] add_send_counter;
wire [9:0]  wea,rea;
reg  [9:0]  wr_req,rd_req,rea_send;
wire [31:0] do[9:0];

assign data_i = v2p_data;
assign v2p_data = data_bus;
//assign data_bus= rea[0]&&rd_ram?do[0]:32'hzzzzzzzz;
//assign data_bus= rea[1]&&rd_ram?do[1]:32'hzzzzzzzz;
//assign data_bus= rea[2]&&rd_ram?do[2]:32'hzzzzzzzz;
//assign data_bus= rea[3]&&rd_ram?do[3]:32'hzzzzzzzz;
//assign data_bus= rea[4]&&rd_ram?do[4]:32'hzzzzzzzz;
//assign data_bus= rea[5]&&rd_ram?do[5]:32'hzzzzzzzz;
//assign data_bus= rea[6]&&rd_ram?do[6]:32'hzzzzzzzz;
//assign data_bus= rea[7]&&rd_ram?do[7]:32'hzzzzzzzz;
//assign data_bus= rea[8]&&rd_ram?do[8]:32'hzzzzzzzz;
//assign data_bus= rea[9]&&rd_ram?do[9]:32'hzzzzzzzz;

always @(rd_ram or rd_req or do[0] or do[1] or do[2] or do[3] or do[4] or do[5] or do[6] or do[7] or do[8] or do[9])
begin
  if(!rd_ram)
    data_bus = 32'hzzzzzzzz;
  else
    begin
		case (rd_req )
         10'b00_0000_0000: data_bus = 32'hzzzzzzzz;

         10'b00_0000_0001: data_bus = do[0];
         10'b00_0000_0010: data_bus = do[1];
         10'b00_0000_0100: data_bus = do[2];
         10'b00_0000_1000: data_bus = do[3];
         10'b00_0001_0000: data_bus = do[4];
         10'b00_0010_0000: data_bus = do[5];
         10'b00_0100_0000: data_bus = do[6];
         10'b00_1000_0000: data_bus = do[7];
         10'b01_0000_0000: data_bus = do[8];
         10'b10_0000_0000: data_bus = do[9];
			default: data_bus = 32'hzzzzzzzz;
      endcase
    end
end

assign clk_w = wr_ram;
assign clk_r = (testdata_send==1)? clk40:rd_ram;
assign add_w = add_wr_counter;
assign add_r = (testdata_send==1)? add_send_counter:add_rd_counter;
assign wea = wr_req;
assign rea = (testdata_send==1)? rea_send:rd_req;

assign data_o = {do[9],do[8],do[7],do[6],do[5],do[4],do[3],do[2],do[1],do[0]};
//address counter of writing ram from vme;
always@(negedge wr_ram or posedge reset)
begin
  if(reset)
    add_wr_counter<=12'b0;
  else if(testdata_send)
    add_wr_counter<=12'b0;
  else 
    begin
	   if(add_wr_counter<12'h9ff)
         add_wr_counter <= add_wr_counter + 1;
      else
         add_wr_counter<=12'b0;
    end
end
//address counter of reading ram to vme;
always@(negedge rd_ram or posedge reset)
begin
  if(reset)
    add_rd_counter<=12'b0;
  else if(testdata_send)
    add_rd_counter<=12'b0;
  else 
  	 begin
	 	if(add_rd_counter<12'h9ff)
    		add_rd_counter <= add_rd_counter + 1;
      else
         add_rd_counter<=12'b0;
    end
end
//address counter of sending ram to track finder;
always@(negedge clk40)
begin
  if(reset)
    begin
	   add_send_counter<=12'b0;
      rea_send <= 10'b0;
	 end
  else if(!testdata_send)
    begin
	   add_send_counter<=12'b0;
		rea_send <= 10'b0;
	 end
  else
    begin
	   if(loop)
		  begin
		    rea_send <= 10'h3ff;
	       if(add_send_counter<12'h9ff) 
              add_send_counter <= add_send_counter + 1;
          else
		        add_send_counter<=12'b0;
        end
      else
		  begin
			 if(add_send_counter<12'h9ff) 
            begin
				   rea_send <= 10'h3ff;
               add_send_counter <= add_send_counter + 1;
				end
          else
            begin
               rea_send <= 10'b0;
            end
		  end
    end
end

//ram select of writing ram from vme;
//always@(posedge wr_ram or posedge reset)
//begin
//  if(reset)
//    w_select<=4'b0;
//  else if(w_select <4'b1001)
//    w_select <= w_select + 1;
//  else if(w_select ==4'b1001)
//    w_select <= 4'b0;
//end

always@(addr[15:12])
begin
  case(addr[15:12])
    4'b0000: wr_req = 10'b00_0000_0001;
    4'b0001: wr_req = 10'b00_0000_0010;
    4'b0010: wr_req = 10'b00_0000_0100;
    4'b0011: wr_req = 10'b00_0000_1000;
    4'b0100: wr_req = 10'b00_0001_0000;
    4'b0101: wr_req = 10'b00_0010_0000;
    4'b0110: wr_req = 10'b00_0100_0000;
    4'b0111: wr_req = 10'b00_1000_0000;
    4'b1000: wr_req = 10'b01_0000_0000;
    4'b1001: wr_req = 10'b10_0000_0000;

    4'b1010: wr_req = 10'b00_0000_0000;
    4'b1011: wr_req = 10'b00_0000_0000;
    4'b1100: wr_req = 10'b00_0000_0000;
    4'b1101: wr_req = 10'b00_0000_0000;
    4'b1110: wr_req = 10'b00_0000_0000;
    4'b1111: wr_req = 10'b00_0000_0000;
    default:wr_req = 10'b00_0000_0000;
  endcase
end

//ram select of reading ram to vme;
//always@(posedge rd_ram or posedge reset)
//begin
//  if(reset)
//    r_select<=4'b0;
//  else if(r_select <4'b1001)
//    r_select <= r_select + 1;
//  else if(r_select ==4'b1001)
//    r_select <= 4'b0;
//end

always@(addr[15:12])
begin
  case(addr[15:12])
    4'b0000: rd_req = 10'b00_0000_0001;
    4'b0001: rd_req = 10'b00_0000_0010;
    4'b0010: rd_req = 10'b00_0000_0100;
    4'b0011: rd_req = 10'b00_0000_1000;
    4'b0100: rd_req = 10'b00_0001_0000;
    4'b0101: rd_req = 10'b00_0010_0000;
    4'b0110: rd_req = 10'b00_0100_0000;
    4'b0111: rd_req = 10'b00_1000_0000;
    4'b1000: rd_req = 10'b01_0000_0000;
    4'b1001: rd_req = 10'b10_0000_0000;

    4'b1010: rd_req = 10'b00_0000_0000;
    4'b1011: rd_req = 10'b00_0000_0000;
    4'b1100: rd_req = 10'b00_0000_0000;
    4'b1101: rd_req = 10'b00_0000_0000;
    4'b1110: rd_req = 10'b00_0000_0000;
    4'b1111: rd_req = 10'b00_0000_0000;
    default:rd_req = 10'b00_0000_0000;
  endcase
end

ram32_2560 testram0(
                .addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[0]),
	             .enb(rea[0]),
	             .dina(data_i),
	             .doutb(do[0])
                    );
ram32_2560 testram1(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[1]),
	             .enb(rea[1]),
	             .dina(data_i),
	             .doutb(do[1])
                    );
ram32_2560 testram2(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[2]),
	             .enb(rea[2]),
	             .dina(data_i),
	             .doutb(do[2])
                    );
ram32_2560 testram3(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[3]),
	             .enb(rea[3]),
	             .dina(data_i),
	             .doutb(do[3])
                    );
ram32_2560 testram4(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[4]),
	             .enb(rea[4]),
	             .dina(data_i),
	             .doutb(do[4])
                    );
ram32_2560 testram5(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[5]),
	             .enb(rea[5]),
	             .dina(data_i),
	             .doutb(do[5])
                    );
ram32_2560 testram6(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[6]),
	             .enb(rea[6]),
	             .dina(data_i),
	             .doutb(do[6])
                    );
ram32_2560 testram7(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[7]),
	             .enb(rea[7]),
	             .dina(data_i),
	             .doutb(do[7])
                    );		  
ram32_2560 testram8(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[8]),
	             .enb(rea[8]),
	             .dina(data_i),
	             .doutb(do[8])
                    );
ram32_2560 testram9(
                    	.addra(add_w),
	             .addrb(add_r),
	             .clka(clk_w),
	             .clkb(clk_r),
	             .wea(wea[9]),
	             .enb(rea[9]),
	             .dina(data_i),
	             .doutb(do[9])
                    );
endmodule