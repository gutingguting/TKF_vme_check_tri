`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    15:29:49 07/04/05
// Design Name:    
// Module Name:    tx_prbs_gen
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
module tx_prbs_gen(TXUSRCLK2,txcharisk, txdata, reset, comma_send, enable, clk40,tx_cbs);
    output [3:0] txcharisk;
    output [31:0] txdata;
	 output  tx_cbs ;
    input reset;
	 input comma_send;
	 input enable;
    input clk40;
	 input TXUSRCLK2;

	 reg   [3:0]   txcharisk;
	 reg  [31:0]	txdata;
	 reg 				tx_cbs;
	 wire          reset;
	 wire          comma_send;
	 wire          enable;

    reg   [4:0]   clk_count = 5'b0;
	   
    reg   [31:0]  prbs = 32'b1;
	 
	 wire          prbs_enable;
	 reg   [31:0]  tx_int;
	 reg   [3:0]   tx_int_charisk;
	 reg           tx_gen_int;
	 wire          tx_gen_reset;

wire prog_empty;
wire [31:0] 	 data_prbs_fifo;
//parameter  INSERT_IDLE = 7'H7F;
//assign prbs_enable = tx_gen_int && (!comma);
assign prbs_enable = tx_gen_int;
assign tx_gen_reset = reset ;

always@(posedge TXUSRCLK2)
begin
  if(reset)
  	  begin
	    tx_int <= 32'h0001;
		 clk_count <= 5'b0;
		 tx_gen_int <= 1'b0;
		 tx_cbs <= 1'b0;
		 tx_int_charisk <= 4'b0000;
     end
  else if(enable)
	  begin
		 clk_count <= clk_count + 1;
	    if(clk_count < 5'hA)
		   begin
			  tx_int <= 32'HBC95B5B5;
			  tx_int_charisk <= 4'b1000;
			end
       else if(clk_count < 5'h10)
				begin
				  tx_int <= 32'H1C95B5B5;
				  tx_int_charisk <= 4'b1000;
	         end
	    else if(clk_count < 5'h15)
				begin
				  tx_int <= 32'HBC95B5B5;
				  tx_int_charisk <= 4'b1000;
	         end
	    else if(clk_count < 5'h1E)
				begin
				  tx_int <= 32'H7C95B5B5;
				  tx_int_charisk <= 4'b1000;
				  tx_cbs <= 1'b1;	
	         end
		 else 
			   begin
	//			  clk_count <= clk_count + 1;
				  tx_gen_int <= 1'b1;
				end
     end
end
     
//always@(posedge TXUSRCLK2)
//begin
//  if(tx_gen_reset)
//    begin
//	   cnt <= 7'b0;
//	   tc  <= 1'b0;
//      comma <= 1'b0;
//    end
//  else if(tx_gen_int)
//    begin
//	   cnt <= cnt + 1;
//	   if(cnt == INSERT_IDLE)   //to accomodate for the latency of the 8B10B encoder
//		  begin  tc<=1'b1; end
//		else
//		  begin  tc<=1'b0; end
//	 end
//  comma <= tc;
//end

always@(posedge TXUSRCLK2)
   begin
         if(reset)
			  begin
			    txdata <= 32'b1;
				 txcharisk <= 4'b0;
			  end
			else if(comma_send)
           begin
		      txdata <= 32'HBC95B5B5;
		      txcharisk <= 4'b1000;
	 	     end
         else if(!tx_gen_int)
			  begin
			   txdata <= tx_int;
				txcharisk <= tx_int_charisk;
			  end
			else if(prog_empty)
				  begin
				  		txdata <= 32'HBC95B5B5; 
						txcharisk <= 4'b1000;
				  end
         else if(!prog_empty)
				  begin
				  		if(data_prbs_fifo==32'b0)
							begin
						  		txdata<=32'b1;
						  		txcharisk <= 4'b0000;
							end
						else
							begin
								txdata <= data_prbs_fifo;
								txcharisk <= 4'b0000;
							end
				  end
			else
				  begin
				  		txdata <= 32'HBC95B5B5; 
						txcharisk <= 4'b1000;
				  end
           
	end


always@(posedge clk40)
begin
	if(tx_gen_reset)
	  begin
	    prbs <= 32'h0003;
     end
   else if(prbs_enable)
	  begin
	    prbs <= {prbs[30:0],prbs[0]^prbs[10]^prbs[30]^prbs[31]};
//       txcharisk <= 4'b0000;			  
     end
end


afifo_prbs tx_prbs_fifo(
    .din(prbs),
    .rd_clk(TXUSRCLK2),
    .rd_en(!prog_empty),
    .rst(reset),
    .wr_clk(clk40),
    .wr_en(prbs_enable),
    .dout(data_prbs_fifo),
    .empty(empty),
    .full(full),
    .prog_empty(prog_empty)
	 );


endmodule
