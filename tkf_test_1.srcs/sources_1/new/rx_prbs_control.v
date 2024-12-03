`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    17:35:05 07/03/05
// Design Name:    
// Module Name:    rx_prbs_control
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
// Mod: Oct10, mod. reset as reset_stat, tx_gen added FC95B5B5 for reset comma.
// 
////////////////////////////////////////////////////////////////////////////////
module rx_prbs_control(aligned_data, rxusrclk2, clk40,enable_check,
                       reset,sync,bert_error,sync_led,
							  err_led,count,rxcharisk3,
							  cb_dout,cbs_flag,cb_afifo_rden
							  ,cb_fifo_full,cb_fifo_empty
							  ,Fiber_Fifo_Count
							  );
    input        [31:0] aligned_data;
    input        rxusrclk2;
	 input        clk40;
	 input        reset;
	 input        sync;
	 input        enable_check;
	 output [7:0] bert_error;
	 output       sync_led;
	 output       err_led;
	 output [47:0] count;
	 output [31:0] Fiber_Fifo_Count;

    output [31:0] cb_dout;
    output        cb_fifo_full,cb_fifo_empty;
	 output       cbs_flag; 
	 input		  cb_afifo_rden;

	 input        rxcharisk3;
	 wire         rxcharisk3;

	 wire [31:0]  aligned_data;
	 wire         rxusrclk2;
	 wire         sync;
	 wire         enable_check;
	 reg          sync_led;
	 reg          err_led;
	 wire  [31:0] act_dout;
	 reg   [31:0] last_dout;
	 wire         reset_stat;

	 reg  [47:0]  count;
// synthesis attribute KEEP of count is "TRUE"
	 wire  [7:0]  bert_error;
// synthesis attribute KEEP of bert_error is "TRUE"
	 reg   [7:0]  err_cnt;
    reg          err;
	 reg          sync_reg;
	 wire  [31:0] cb_dout;
	 wire  [31:0] cb_afifo_dout;
	 wire  [31:0] Fiber_Fifo_Count;
// synthesis attribute KEEP of cb_afifo_dout is "TRUE"
	 wire         cb_afifo_rden;
	 wire         cb_afifo_ainit;

	 wire         wr_clk,rd_clk,check_clk;
	 reg         cb_afifo_wren_int;
	 wire         cb_afifo_wren;
	 reg          cbs_flag;
	 wire   [4:0] rd_data_count,wr_data_count;

parameter ERR_CNT_MAX = 8'hFF;

//align channels 
//assign act_dout = cb_dout;
assign act_dout = aligned_data;
assign bert_error = err_cnt;
assign reset_stat = ((aligned_data == 32'H1C95B5B5 ? 1:0 ) && rxcharisk3) || reset;
//assign reset_stat = (aligned_data == 32'H1C95B5B5 ? 1:0 ) && rxcharisk3;
assign cb_afifo_wren_flag = (aligned_data == 32'H7C95B5B5 ? 1:0 ) && rxcharisk3;
assign cb_afifo_ainit = reset_stat;
assign cb_dout= cb_afifo_dout;
assign cb_afifo_wren = cbs_flag && ~rxcharisk3;
assign wr_clk=rxusrclk2;
assign rd_clk=clk40;
//
//always@(posedge reset or posedge cb_afifo_wren_flag)
//begin
//  if(reset)
//    cb_afifo_wren<=1'b0;
//  else if(cb_afifo_wren_flag)
//    cb_afifo_wren<=1'b1;
//end
//
cb_fifo fifo1 (
    .din(aligned_data),
    .rd_clk(rd_clk),
	 .rd_en(cb_afifo_rden),
    .rst(cb_afifo_ainit),
	 .wr_clk(wr_clk),
    .wr_en(cb_afifo_wren),
    .dout(cb_afifo_dout),
    .full(cb_fifo_full),
	 .empty(cb_fifo_empty),
	 .rd_data_count(rd_data_count),
	 .wr_data_count(wr_data_count)
	 );

assign Fiber_Fifo_Count = {6'b0,cb_afifo_rden, cbs_flag,6'b0, cb_fifo_full, cb_fifo_empty, 3'b0,wr_data_count, 3'b0,rd_data_count};

always@(negedge wr_clk)
begin
	if(reset_stat)
		 begin
 			cb_afifo_wren_int = 1'b0;
			cbs_flag <=1'b0;
	    end
   else if(cb_afifo_wren_flag)
	    begin
		   cb_afifo_wren_int = 1'b1;
			cbs_flag <=1'b1;
       end
	else if(!sync)
		 begin
		   cb_afifo_wren_int = 1'b0;
			cbs_flag <=1'b0;
		 end
	else
		 begin
		   cb_afifo_wren_int = cb_afifo_wren_int;
			cbs_flag <=cbs_flag;
		 end
end
//always@(posedge reset_stat or posedge cb_afifo_wren_flag or negedge sync)
//begin
//	if(reset_stat)
//		 begin
// 			cb_afifo_wren_int = 1'b0;
//			cbs_flag <=1'b0;
//	    end
//	else if(!sync)
//		 begin
//		   cb_afifo_wren_int = 1'b0;
//			cbs_flag <=1'b0;
//		 end
//   else if(cb_afifo_wren_flag)
//	    begin
//		   cb_afifo_wren_int = 1'b1;
//			cbs_flag <=1'b1;
//       end
//end

//always@(negedge wr_clk)
//begin
//  if(reset)
//	  cb_afifo_wren = 1'b0;
//  else if(cb_afifo_wren_int)
//     cb_afifo_wren = ~rxcharisk3;
//end

////checking data
//assign count = num_count;

//INV    inv1 (.I (clk), .O(check_clk));
assign rx_enable_check = enable_check;
//assign rx_enable_check = sync && ~cb_afifo_dout[32];//it is--stop_align_int && rxcharisk3
always@(posedge rxusrclk2 or posedge reset_stat)
begin
	if(reset_stat)
		 begin
		  last_dout <= 32'b1;
//		  count <= 64'b0;
		  err_cnt <= 8'b0;
		  sync_reg <= 1'b0;
		  err_led <= 1'b1;
		  sync_led <= 1'b1;
	    end
   else if(rx_enable_check)
   	 begin
		  sync_reg <= sync;
		  last_dout <= {act_dout[30:0],act_dout[0]^act_dout[10]^act_dout[30]^act_dout[31]};
	     if(sync)
		    begin
		     sync_led <= 1'b0; // synchronuous
			  if(sync_reg)    //check err
			    begin
				 if(rx_enable_check && err)
				   begin
				     if(err_cnt < ERR_CNT_MAX)
					    begin
						   err_cnt <= err_cnt + 1;
						 end
                 else
					    begin
						   err_led <= 1'b0;
						 end
				   end
				 end
          end
        else
		    begin
			   sync_led <= 1'b1;  //not synchronuous
				err_cnt <= 8'b0;
			 end
		 end
end

// detect error
always@(negedge rxusrclk2 or posedge reset_stat)
begin
  if(reset_stat)
   begin
	  err <= 1'b0;
	  count <= 48'b0;
	end
  else if (rx_enable_check)
    begin
		 count <= count + 1;
       if (last_dout == act_dout)
				begin
					 err <= 1'b0;
	         end
		 else
				begin
					 err <= 1'b1;
				end
    end
end



/*
always@(posedge reset or posedge clk)
begin
     if(reset)
	    begin
	     prbs_sinit <= 1;
		  cs <= 2'b00;
		  enable_check <= 0;
		  count <= 48'b0;
       end
     else
	    begin
         case (cs)
	 2'b00:  begin
	 	         if(aligned_data == 32'hFC95B5B5)
			         begin
	                 cs <= 2'b01;
			         end
			      else
			         begin
			           cs <= 2'b00;
	               end
	          end
	 2'b01:  begin
	 	         if(aligned_data == 32'h3C95B5B5)
			         begin
	                 cs <= 2'b10;
                    prbs_sinit <= 0;
						  enable_check <= 1;  
			         end
			      else
			         begin
			           cs <= 2'b00;
                    prbs_sinit <= 1;
	               end
	         end
	 2'b10:  begin
                    prbs_sinit <= 0;
						  enable_check <= 1;   
	         end
      default: begin
	             cs <= 2'b00;
                prbs_sinit <= 1;
					 enable_check <= 0;  
	           end
	      endcase
      end

end
*/

endmodule
