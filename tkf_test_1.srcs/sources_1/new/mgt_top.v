`timescale 1ns / 1ps
module MGT_top
                 (	   clk40,					   
					   refclkp_t,refclkn_t,refclkp_b,refclkn_b,
                  	   txn,
                  txp,
                  rxn,
                  rxp,
						reset,
						FRST,
						FRST_PRE,
						err_led,
						sync_led,
						count_led,
						cbs_flag,
						cbs_flags,
						reset_txgen,
						tx_cbs,
						cb_dout_aligned,
						FiberData0,FiberData1,FiberData2,FiberData3,
						FiberData4,FiberData5,FiberData6,FiberData7,
						FiberData8,FiberData9,
						FUERR,
						Fiber_Read_EN,
						Fiber_Channel_Set,
						Fiber_Channel_Alignment_Status,Fiber_Fifo_Status,
						cb_afifo_rden,
						aligned_data0,aligned_data1,aligned_data2,aligned_data3,
						aligned_data4,aligned_data5,aligned_data6,aligned_data7,
						aligned_data8,aligned_data9
						 ,Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5
						 ,Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0						  
						
						);

    input         clk40;
    input         refclkp_t,refclkn_t,refclkp_b,refclkn_b;
	 input         reset;
	 input         FRST;
	 input 			reset_txgen;
	 input         Fiber_Read_EN;
	 input         FRST_PRE;
	 input  [15:0] Fiber_Channel_Set;

    output [9:0] txn,txp;
	 input  [9:0] rxn,rxp;
	 output [9:0] err_led,sync_led;
	 output        count_led;
	 output [9:0] cbs_flag;
	 output cbs_flags;
	 output [1:0] tx_cbs;
	 output        cb_dout_aligned;
	 output        FUERR;
	 output        cb_afifo_rden;
      
	 output [31:0]	FiberData0,FiberData1,FiberData2,FiberData3;
	 output [31:0]	FiberData4,FiberData5,FiberData6,FiberData7;
	 output [31:0]	FiberData8,FiberData9;

	 output [31:0]	aligned_data0,aligned_data1,aligned_data2,aligned_data3;
	 output [31:0]	aligned_data4,aligned_data5,aligned_data6,aligned_data7;
	 output [31:0]	aligned_data8,aligned_data9;
	 output [31:0]	Fiber_Channel_Alignment_Status,Fiber_Fifo_Status;
    output [31:0] Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5;
	 output [31:0] Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0;						  

	 wire [31:0] FiberData[9:0]; 
	 wire [31:0] aligned_data[9:0];	 
	 wire [9:0]  cbs_flag;
	 reg           cb_afifo_rden;
	 reg  [1:0]    ts;
	 reg  [4:0]    frsup;

    wire [9:0]    rxcharisk_out,rxrealign_out,rxcommadet_out,aligned_sync;   

    wire [3:0]     rxchariscomma_out[9:0];
   
    wire [3:0]     aligned_rxisk[9:0];

    wire [7:0]     bert_error[9:0];

	 wire [3:0]     bert_error_led[9:0];

	 wire [9:0]    sync_led,err_led;

	 wire [47:0]    count[9:0];

    reg            count_led;
    reg            count_max;

//    wire        clk40p,clk40n;
	 wire [1:0]  lb_in;
	 wire        comma_send;
	 wire        lock_rst,lock,lock_b;

	 wire        RXRESET_IN;
    wire        TXRESET_IN;
	 wire        reset_mgt;
    wire [31:0] txdata_in,txdata_in_b;
    wire [3:0]  txcharisk_in,txcharisk_in_b;

	 wire [9:0] enchansync,chbdd,cbd_corcnt;

    wire [3:0]  chbdi[9:0],chbdo[9:0];
	 	 
	 wire [3:0]  m_chbdo,s_chbdo;

    wire [9:0] REFCLK_IN;
	 wire [9:0] rxusrclk;
	 wire [9:0] rxusrclk2;
	 wire        USRCLK,USRCLK2,USRCLK_b,USRCLK2_b;
	 wire        USRCLK_CDC;
	 wire        REFCLK,REFCLK_b;

    wire  [9:0] TXPOLARITY_IN,RXPOLARITY_IN;
    reg         cb_dout_aligned;
	 reg         ch_aligned_err;
	 reg         ch_aligned_timing_err;
    wire        FRST,FUERR;
    wire  [9:0] cb_fifo_empty,cb_fifo_full;
    wire        fifo_empty,fifo_full;
	 wire  [31:0] Fiber_Channel_Alignment_Status, Fiber_Fifo_Status;
wire[31:0] Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5;
wire[31:0] Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0;
    wire  [31:0]  Fiber_Fifo_Count[9:0];						  

assign Fiber_Channel_Alignment_Status = {15'b0,ch_aligned_timing_err,6'b0,cbs_flag[9:0]};
assign Fiber_Fifo_Status = {6'b0,cb_fifo_full[9:0],6'b0,cb_fifo_empty[9:0]};
    
assign FUERR = ch_aligned_err || fifo_empty || fifo_full;
//set polarity, refer to the LOC of rxn,rxp,txn and txp.
//for v2p40 10MGTs
//----------------------
//		0
//		1	  	 
//	T	2		 
//		3		 
//		4
//
//		5
//		6		 
//	B	7		
//		8		 
//    9
//----------------------
assign TXPOLARITY_IN = 10'b0000011111;
assign RXPOLARITY_IN = 10'b0000010000;
//assign TXPOLARITY_IN = 10'b0000000000;
//assign RXPOLARITY_IN = 10'b0000000000;

assign lb_in[1:0] = 2'b00;
//assign TXRESET_IN = 1'b1;
assign TXRESET_IN = reset_mgt;
assign RXRESET_IN = reset_mgt;
assign reset_int = reset;


//this creates a reset from control  
//which can be connected to a external reset button

assign lock_rst = lock & lock_b;
reset_gen resets(
                .clk       (USRCLK2), 
					 .lock      (lock_rst), 
					 .reset     (reset_int), 
					 .reset_out	(reset_mgt)
					 );

//instantiate the MGT REFCLK buffer
clk_gen clocks(
               .refclkp   (refclkp_t), 
					.refclkn   (refclkn_t),
					.reset     (reset_int), 
					.USRCLK_M  (USRCLK), 
					.USRCLK2_M (USRCLK2), 
               .lock      (lock), 
					.refclk_out(REFCLK),
					.USRCLK_CDC (USRCLK_CDC)
					);

clk_gen_b clocks_b(
               .refclkp   (refclkp_b), 
					.refclkn   (refclkn_b),
					.reset     (reset_int), 
					.USRCLK_M  (USRCLK_b), 
					.USRCLK2_M (USRCLK2_b), 
               .lock      (lock_b), 
					.refclk_out(REFCLK_b)
					);
//set refclk ---------------------------------------------------
//top MGTs
assign REFCLK_IN[0] = REFCLK;assign REFCLK_IN[1] = REFCLK;assign REFCLK_IN[2] = REFCLK;
assign REFCLK_IN[3] = REFCLK;assign REFCLK_IN[4] = REFCLK;
//bottom MGTs
assign REFCLK_IN[5] = REFCLK_b;assign REFCLK_IN[6] = REFCLK_b;assign REFCLK_IN[7] = REFCLK_b;
assign REFCLK_IN[8] = REFCLK_b;assign REFCLK_IN[9] = REFCLK_b;

//set usrclk ---------------------------------------------------
//top MGTs
assign rxusrclk[0] = USRCLK;assign rxusrclk[1] = USRCLK;assign rxusrclk[2] = USRCLK;
assign rxusrclk[3] = USRCLK;assign rxusrclk[4] = USRCLK;
//bottom MGTs
assign rxusrclk[5] = USRCLK_b;assign rxusrclk[6] = USRCLK_b;assign rxusrclk[7] = USRCLK_b;
assign rxusrclk[8] = USRCLK_b;assign rxusrclk[9] = USRCLK_b;

//set usrclk2 ---------------------------------------------------
//top MGTs
assign rxusrclk2[0] = USRCLK2;assign rxusrclk2[1] = USRCLK2;assign rxusrclk2[2] = USRCLK2;
assign rxusrclk2[3] = USRCLK2;assign rxusrclk2[4] = USRCLK2;
//bottom MGTs
assign rxusrclk2[5] = USRCLK2_b;assign rxusrclk2[6] = USRCLK2_b;assign rxusrclk2[7] = USRCLK2_b;
assign rxusrclk2[8] = USRCLK2_b;assign rxusrclk2[9] = USRCLK2_b;


always@(posedge USRCLK2)
begin
  if(count[0][22] || count[0][47]== 1)
    begin
     count_led <= 0;
    end
  else
    begin count_led <= 1; end
  if(count[0][47] == 0)
    begin count_max <= 1; end
  else
    begin count_max <= 0; end
end


//channels bond
//assign cbs_flags = (cbs_flag==16'hFFFF)?1:0;
//assign cbs_flags = (cbs_flag==10'h3FF)?1:0;
//assign cbs_flags = (cbs_flag==Fiber_Channel_Set[9:0])?1:0;
assign cbs_flags = (~Fiber_Channel_Set[9]|| cbs_flag[9]) && (~Fiber_Channel_Set[8]|| cbs_flag[8]) 
                    && (~Fiber_Channel_Set[7]|| cbs_flag[7]) && (~Fiber_Channel_Set[6]|| cbs_flag[6]) 
						  && (~Fiber_Channel_Set[5]|| cbs_flag[5]) && (~Fiber_Channel_Set[4]|| cbs_flag[4]) 
						  && (~Fiber_Channel_Set[3]|| cbs_flag[3]) && (~Fiber_Channel_Set[2]|| cbs_flag[2]) 
						  && (~Fiber_Channel_Set[1]|| cbs_flag[1]) && (~Fiber_Channel_Set[0]|| cbs_flag[0]); 

assign fifo_full =     (Fiber_Channel_Set[9]&& cb_fifo_full[9]) || (Fiber_Channel_Set[8]&& cb_fifo_full[8]) 
                    || (Fiber_Channel_Set[7]&& cb_fifo_full[7]) || (Fiber_Channel_Set[6]&& cb_fifo_full[6]) 
						  || (Fiber_Channel_Set[5]&& cb_fifo_full[5]) || (Fiber_Channel_Set[4]&& cb_fifo_full[4]) 
						  || (Fiber_Channel_Set[3]&& cb_fifo_full[3]) || (Fiber_Channel_Set[2]&& cb_fifo_full[2]) 
						  || (Fiber_Channel_Set[1]&& cb_fifo_full[1]) || (Fiber_Channel_Set[0]&& cb_fifo_full[0]); 

assign fifo_empty =    (Fiber_Channel_Set[9]&& cb_fifo_empty[9]) || (Fiber_Channel_Set[8]&& cb_fifo_empty[8]) 
                    || (Fiber_Channel_Set[7]&& cb_fifo_empty[7]) || (Fiber_Channel_Set[6]&& cb_fifo_empty[6]) 
						  || (Fiber_Channel_Set[5]&& cb_fifo_empty[5]) || (Fiber_Channel_Set[4]&& cb_fifo_empty[4]) 
						  || (Fiber_Channel_Set[3]&& cb_fifo_empty[3]) || (Fiber_Channel_Set[2]&& cb_fifo_empty[2]) 
						  || (Fiber_Channel_Set[1]&& cb_fifo_empty[1]) || (Fiber_Channel_Set[0]&& cb_fifo_empty[0]); 


//assign FiberData9=FiberData[9]; 
//assign FiberData8=FiberData[8]; 
//assign FiberData7=FiberData[7];
//assign FiberData6=FiberData[6];
//assign FiberData5=FiberData[5];
//assign FiberData4=FiberData[4];
//assign FiberData3=FiberData[3];
//assign FiberData2=FiberData[2];
//assign FiberData1=FiberData[1];
//assign FiberData0=FiberData[0];
assign Fiber_Fifo_Count9=Fiber_Fifo_Count[9]; 
assign Fiber_Fifo_Count8=Fiber_Fifo_Count[8]; 
assign Fiber_Fifo_Count7=Fiber_Fifo_Count[7];
assign Fiber_Fifo_Count6=Fiber_Fifo_Count[6];
assign Fiber_Fifo_Count5=Fiber_Fifo_Count[5];
assign Fiber_Fifo_Count4=Fiber_Fifo_Count[4];
assign Fiber_Fifo_Count3=Fiber_Fifo_Count[3];
assign Fiber_Fifo_Count2=Fiber_Fifo_Count[2];
assign Fiber_Fifo_Count1=Fiber_Fifo_Count[1];
assign Fiber_Fifo_Count0=Fiber_Fifo_Count[0];

assign FiberData9=((Fiber_Channel_Set[9] && cb_afifo_rden)==1)?FiberData[9]:32'h0;
assign FiberData8=((Fiber_Channel_Set[8] && cb_afifo_rden)==1)?FiberData[8]:32'h0;
assign FiberData7=((Fiber_Channel_Set[7] && cb_afifo_rden)==1)?FiberData[7]:32'h0;
assign FiberData6=((Fiber_Channel_Set[6] && cb_afifo_rden)==1)?FiberData[6]:32'h0;
assign FiberData5=((Fiber_Channel_Set[5] && cb_afifo_rden)==1)?FiberData[5]:32'h0;
assign FiberData4=((Fiber_Channel_Set[4] && cb_afifo_rden)==1)?FiberData[4]:32'h0;
assign FiberData3=((Fiber_Channel_Set[3] && cb_afifo_rden)==1)?FiberData[3]:32'h0;
assign FiberData2=((Fiber_Channel_Set[2] && cb_afifo_rden)==1)?FiberData[2]:32'h0;
assign FiberData1=((Fiber_Channel_Set[1] && cb_afifo_rden)==1)?FiberData[1]:32'h0;
assign FiberData0=((Fiber_Channel_Set[0] && cb_afifo_rden)==1)?FiberData[0]:32'h0;


assign aligned_data9=aligned_data[9]; 
assign aligned_data8=aligned_data[8]; 
assign aligned_data7=aligned_data[7];
assign aligned_data6=aligned_data[6];
assign aligned_data5=aligned_data[5];
assign aligned_data4=aligned_data[4];
assign aligned_data3=aligned_data[3];
assign aligned_data2=aligned_data[2];
assign aligned_data1=aligned_data[1];
assign aligned_data0=aligned_data[0];

always@(negedge clk40)
begin
    if(!cbs_flags)
	   begin 
		  frsup<=5'b0000;
		  cb_dout_aligned <=1'b0;
		end
    else if(cbs_flags)
	   begin
		   if(frsup < 5'b00111)
			   begin frsup <= frsup + 1; end
         else
			   begin 
				  frsup<=5'b0;
				  cb_dout_aligned <=1'b1;
				end
		end
end

always@(negedge clk40)
begin
	if(FRST)
		begin
			cb_afifo_rden <=1'b0;
			ch_aligned_timing_err <= 1'b0;
			ch_aligned_err <= 1'b1;
		end
	else if(Fiber_Read_EN)
		begin
			if(cb_dout_aligned)
				begin
					if(ch_aligned_timing_err==0)
						begin
							cb_afifo_rden <= 1'b1;
							ch_aligned_err <= 1'b0;
						end
					else
						begin
							cb_afifo_rden <= 1'b0;
							ch_aligned_err <= 1'b1;
						end
				end
			else
				begin
					ch_aligned_timing_err <= 1'b1;
					cb_afifo_rden <= 1'b0;
					ch_aligned_err <= 1'b1;
				end
		end
	else
		begin
			cb_afifo_rden <= 1'b0;
			ch_aligned_err <= 1'b1;
		end
end

//TX-data generation:
//this block generates random data to transmit
//the FC95B5B5 is the K28.5 to allow the MGT to align	to this character
wire txgen_enable;
assign comma_send = 1'b0;
//assign txgen_enable = !reset_mgt;
assign txgen_enable = !reset_txgen;
tx_prbs_gen generate_data(
						        .txcharisk     (txcharisk_in), 
								  .txdata        (txdata_in), 
								  .reset         (reset_txgen), 
								  .comma_send    (comma_send), 
								  .enable        (txgen_enable), 
								  .TXUSRCLK2     (USRCLK2),
								  .clk40         (clk40),
								  .tx_cbs		  (tx_cbs[0])
								  );
tx_prbs_gen generate_data_b(
						        .txcharisk     (txcharisk_in_b), 
								  .txdata        (txdata_in_b), 
								  .reset         (reset_txgen), 
								  .comma_send    (comma_send), 
								  .enable        (txgen_enable), 
								  .TXUSRCLK2     (USRCLK2_b),
								  .clk40         (clk40),
								  .tx_cbs		  (tx_cbs[1])
								  );

//synthesis attribute KEEP of txdata_in is "TRUE" 
assign enchansync = 16'b0;

mgt_data_reception mdr0(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[0]),
							 .ENCHANSYNC(enchansync[0]),
						    .CHBONDI(chbdi[0]),
						    .CHBONDO(chbdo[0]),
						    .CHBONDDONE(chbdd[0]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[0]),
							 .rxp_IN(rxp[0]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[0]),
							 .rxusrclk2(rxusrclk2[0]),
                      .txcharisk_in(txcharisk_in),
							 .txdata_in(txdata_in),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[0]),
							 .txusrclk2(rxusrclk2[0]),
							 .txn_OUT(txn[0]),
							 .txp_OUT(txp[0]),
						    .bert_error(bert_error[0]),
							 .sync_led(sync_led[0]),
							 .err_led(err_led[0]),
							 .count(count[0]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[0]),
							 .cb_dout(FiberData[0]), 
							 .cbs_flag(cbs_flag[0]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[0]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[0]),
							 .aligned_data(aligned_data[0]),
							 .cb_fifo_empty(cb_fifo_empty[0]),
							 .cb_fifo_full(cb_fifo_full[0]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[0])
							 );

mgt_data_reception mdr1(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[1]),
							 .ENCHANSYNC(enchansync[1]),
						    .CHBONDI(chbdi[1]),
						    .CHBONDO(chbdo[1]),
						    .CHBONDDONE(chbdd[1]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[1]),
							 .rxp_IN(rxp[1]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[1]),
							 .rxusrclk2(rxusrclk2[1]),
                      .txcharisk_in(txcharisk_in),
							 .txdata_in(txdata_in),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[1]),
							 .txusrclk2(rxusrclk2[1]),
							 .txn_OUT(txn[1]),
							 .txp_OUT(txp[1]),
						    .bert_error(bert_error[1]),
							 .sync_led(sync_led[1]),
							 .err_led(err_led[1]),
							 .count(count[1]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[1]),
							 .cb_dout(FiberData[1]), 
							 .cbs_flag(cbs_flag[1]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[1]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[1]),
							 .aligned_data(aligned_data[1]),
							 .cb_fifo_empty(cb_fifo_empty[1]),
							 .cb_fifo_full(cb_fifo_full[1]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[1])

							   );

mgt_data_reception mdr2(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[2]),
							 .ENCHANSYNC(enchansync[2]),
						    .CHBONDI(chbdi[2]),
						    .CHBONDO(chbdo[2]),
						    .CHBONDDONE(chbdd[2]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[2]),
							 .rxp_IN(rxp[2]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[2]),
							 .rxusrclk2(rxusrclk2[2]),
                      .txcharisk_in(txcharisk_in),
							 .txdata_in(txdata_in),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[2]),
							 .txusrclk2(rxusrclk2[2]),
							 .txn_OUT(txn[2]),
							 .txp_OUT(txp[2]),
						    .bert_error(bert_error[2]),
							 .sync_led(sync_led[2]),
							 .err_led(err_led[2]),
							 .count(count[2]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[2]),
							 .cb_dout(FiberData[2]), 
							 .cbs_flag(cbs_flag[2]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[2]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[2]),
							 .aligned_data(aligned_data[2]),
							 .cb_fifo_empty(cb_fifo_empty[2]),
							 .cb_fifo_full(cb_fifo_full[2]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[2])

							   );
mgt_data_reception mdr3(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[3]),
							 .ENCHANSYNC(enchansync[3]),
						    .CHBONDI(chbdi[3]),
						    .CHBONDO(chbdo[3]),
						    .CHBONDDONE(chbdd[3]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[3]),
							 .rxp_IN(rxp[3]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[3]),
							 .rxusrclk2(rxusrclk2[3]),
                      .txcharisk_in(txcharisk_in),
							 .txdata_in(txdata_in),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[3]),
							 .txusrclk2(rxusrclk2[3]),
							 .txn_OUT(txn[3]),
							 .txp_OUT(txp[3]),
						    .bert_error(bert_error[3]),
							 .sync_led(sync_led[3]),
							 .err_led(err_led[3]),
							 .count(count[3]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[3]),
							 .cb_dout(FiberData[3]), 
							 .cbs_flag(cbs_flag[3]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[3]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[3]),
							 .aligned_data(aligned_data[3]),
							 .cb_fifo_empty(cb_fifo_empty[3]),
							 .cb_fifo_full(cb_fifo_full[3]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[3])

							   );
mgt_data_reception mdr4(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[4]),
							 .ENCHANSYNC(enchansync[4]),
						    .CHBONDI(chbdi[4]),
						    .CHBONDO(chbdo[4]),
						    .CHBONDDONE(chbdd[4]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[4]),
							 .rxp_IN(rxp[4]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[4]),
							 .rxusrclk2(rxusrclk2[4]),
                      .txcharisk_in(txcharisk_in),
							 .txdata_in(txdata_in),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[4]),
							 .txusrclk2(rxusrclk2[4]),
							 .txn_OUT(txn[4]),
							 .txp_OUT(txp[4]),
						    .bert_error(bert_error[4]),
							 .sync_led(sync_led[4]),
							 .err_led(err_led[4]),
							 .count(count[4]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[4]),
							 .cb_dout(FiberData[4]), 
							 .cbs_flag(cbs_flag[4]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[4]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[4]),
							 .aligned_data(aligned_data[4]),
							 .cb_fifo_empty(cb_fifo_empty[4]),
							 .cb_fifo_full(cb_fifo_full[4]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[4])

							   );
mgt_data_reception mdr5(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[5]),
							 .ENCHANSYNC(enchansync[5]),
						    .CHBONDI(chbdi[5]),
						    .CHBONDO(chbdo[5]),
						    .CHBONDDONE(chbdd[5]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[5]),
							 .rxp_IN(rxp[5]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[5]),
							 .rxusrclk2(rxusrclk2[5]),
                      .txcharisk_in(txcharisk_in_b),
							 .txdata_in(txdata_in_b),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[5]),
							 .txusrclk2(rxusrclk2[5]),
							 .txn_OUT(txn[5]),
							 .txp_OUT(txp[5]),
						    .bert_error(bert_error[5]),
							 .sync_led(sync_led[5]),
							 .err_led(err_led[5]),
							 .count(count[5]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[5]),
							 .cb_dout(FiberData[5]), 
							 .cbs_flag(cbs_flag[5]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[5]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[5]),
							 .aligned_data(aligned_data[5]),
							 .cb_fifo_empty(cb_fifo_empty[5]),
							 .cb_fifo_full(cb_fifo_full[5]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[5])

							   );
mgt_data_reception mdr6(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[6]),
							 .ENCHANSYNC(enchansync[6]),
						    .CHBONDI(chbdi[6]),
						    .CHBONDO(chbdo[6]),
						    .CHBONDDONE(chbdd[6]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[6]),
							 .rxp_IN(rxp[6]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[6]),
							 .rxusrclk2(rxusrclk2[6]),
                      .txcharisk_in(txcharisk_in_b),
							 .txdata_in(txdata_in_b),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[6]),
							 .txusrclk2(rxusrclk2[6]),
							 .txn_OUT(txn[6]),
							 .txp_OUT(txp[6]),
						    .bert_error(bert_error[6]),
							 .sync_led(sync_led[6]),
							 .err_led(err_led[6]),
							 .count(count[6]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[6]),
							 .cb_dout(FiberData[6]), 
							 .cbs_flag(cbs_flag[6]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[6]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[6]),
							 .aligned_data(aligned_data[6]),
							 .cb_fifo_empty(cb_fifo_empty[6]),
							 .cb_fifo_full(cb_fifo_full[6]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[6])

							   );
mgt_data_reception mdr7(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[7]),
							 .ENCHANSYNC(enchansync[7]),
						    .CHBONDI(chbdi[7]),
						    .CHBONDO(chbdo[7]),
						    .CHBONDDONE(chbdd[7]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[7]),
							 .rxp_IN(rxp[7]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[7]),
							 .rxusrclk2(rxusrclk2[7]),
                      .txcharisk_in(txcharisk_in_b),
							 .txdata_in(txdata_in_b),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[7]),
							 .txusrclk2(rxusrclk2[7]),
							 .txn_OUT(txn[7]),
							 .txp_OUT(txp[7]),
						    .bert_error(bert_error[7]),
							 .sync_led(sync_led[7]),
							 .err_led(err_led[7]),
							 .count(count[7]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[7]),
							 .cb_dout(FiberData[7]), 
							 .cbs_flag(cbs_flag[7]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[7]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[7]),
							 .aligned_data(aligned_data[7]),
							 .cb_fifo_empty(cb_fifo_empty[7]),
							 .cb_fifo_full(cb_fifo_full[7]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[7])

							   );
mgt_data_reception mdr8(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[8]),
							 .ENCHANSYNC(enchansync[8]),
						    .CHBONDI(chbdi[8]),
						    .CHBONDO(chbdo[8]),
						    .CHBONDDONE(chbdd[8]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[8]),
							 .rxp_IN(rxp[8]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[8]),
							 .rxusrclk2(rxusrclk2[8]),
                      .txcharisk_in(txcharisk_in_b),
							 .txdata_in(txdata_in_b),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[8]),
							 .txusrclk2(rxusrclk2[8]),
							 .txn_OUT(txn[8]),
							 .txp_OUT(txp[8]),
						    .bert_error(bert_error[8]),
							 .sync_led(sync_led[8]),
							 .err_led(err_led[8]),
							 .count(count[8]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[8]),
							 .cb_dout(FiberData[8]), 
							 .cbs_flag(cbs_flag[8]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[8]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[8]),
							 .aligned_data(aligned_data[8]),
							 .cb_fifo_empty(cb_fifo_empty[8]),
							 .cb_fifo_full(cb_fifo_full[8]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[8])

							   );
mgt_data_reception mdr9(
							 .clk40(clk40),
                      .REFCLK_IN(REFCLK_IN[9]),
							 .ENCHANSYNC(enchansync[9]),
						    .CHBONDI(chbdi[9]),
						    .CHBONDO(chbdo[9]),
						    .CHBONDDONE(chbdd[9]), 
                      .lb_in(lb_in),
							 .rxn_IN(rxn[9]),
							 .rxp_IN(rxp[9]),
							 .RXRESET_IN(RXRESET_IN),
							 .rxusrclk(rxusrclk[9]),
							 .rxusrclk2(rxusrclk2[9]),
                      .txcharisk_in(txcharisk_in_b),
							 .txdata_in(txdata_in_b),
							 .TXRESET_IN(TXRESET_IN),
							 .txusrclk(rxusrclk[9]),
							 .txusrclk2(rxusrclk2[9]),
							 .txn_OUT(txn[9]),
							 .txp_OUT(txp[9]),
						    .bert_error(bert_error[9]),
							 .sync_led(sync_led[9]),
							 .err_led(err_led[9]),
							 .count(count[9]),
						    .reset_rx_control(FRST_PRE),
							 .cbd_corcnt(cbd_corcnt[9]),
							 .cb_dout(FiberData[9]), 
							 .cbs_flag(cbs_flag[9]), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .TXPOLARITY_IN(TXPOLARITY_IN[9]),
							 .RXPOLARITY_IN(RXPOLARITY_IN[9]),
							 .aligned_data(aligned_data[9]),
							 .cb_fifo_empty(cb_fifo_empty[9]),
							 .cb_fifo_full(cb_fifo_full[9]),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count[9])

							   );
endmodule
