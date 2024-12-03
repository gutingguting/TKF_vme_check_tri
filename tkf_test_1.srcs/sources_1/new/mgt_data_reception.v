`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:22:06 11/14/05
// Design Name:    
// Module Name:    mgt_data_reception
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
module mgt_data_reception(REFCLK_IN,reset_rx_control,lb_in,ENCHANSYNC,CHBONDI,CHBONDO,CHBONDDONE, 
                   rxn_IN,rxp_IN,RXRESET_IN,rxusrclk,rxusrclk2,
                   txcharisk_in,txdata_in,TXRESET_IN,txusrclk,txusrclk2,txn_OUT,txp_OUT,
						 bert_error,sync_led,err_led,count,cbd_corcnt,
                   cb_dout, cbs_flag, cb_afifo_rden,clk40,TXPOLARITY_IN,RXPOLARITY_IN
						 ,aligned_data
						 ,cb_fifo_empty,cb_fifo_full
						 ,Fiber_Fifo_Count
						 
						 );

    input         REFCLK_IN,reset_rx_control,rxn_IN,rxp_IN,RXRESET_IN,rxusrclk,rxusrclk2,TXRESET_IN,txusrclk,txusrclk2;
	 input         ENCHANSYNC;
	 input  [1:0]  lb_in;
	 input  [3:0]  CHBONDI,txcharisk_in;
	 input  [31:0]	txdata_in;
	 input         clk40;
	 output        txn_OUT,txp_OUT;
	 output [7:0]  bert_error;
	 output        sync_led,err_led;
	 output [47:0] count;
	 output [3:0]  CHBONDO;
	 output        CHBONDDONE;
	 output        cbd_corcnt;

	 output [31:0] cb_dout;
	 output        cbs_flag;
	 output [31:0] aligned_data;
	 output        cb_fifo_empty,cb_fifo_full;
	 output [31:0] Fiber_Fifo_Count;       

	 input         cb_afifo_rden;
	 input         TXPOLARITY_IN,RXPOLARITY_IN;

	 wire          TXPOLARITY_IN,RXPOLARITY_IN;

	 wire [31:0] cb_dout;
	 wire [31:0] Fiber_Fifo_Count;

	 wire        cbs_flag,cb_afifo_rden;

    wire          REFCLK_IN,rxn_IN,rxp_IN,RXRESET_IN,rxusrclk,rxusrclk2,TXRESET_IN,txusrclk,txusrclk2;
	 wire   [1:0]  lb_in;
	 wire   [3:0]  txcharisk_in;
	 wire   [31:0]	txdata_in;
	 wire          txn_OUT,txp_OUT;
	 wire   [7:0]  bert_error;
	 wire          sync_led,err_led;
	 wire   [47:0] count;

	 wire   [3:0]  rxchariscomma_out,rxcharisk_out,aligned_rxisk;
	 wire          rxcommadet_out,rxrealign_out,stop_align;
	 wire   [31:0] rxdata_out,aligned_data;
	 wire          aligned_sync;
	 wire          rxusrclk_i,txusrclk_i;
	 wire   [3:0]  CHBONDI;
	 wire   [2:0]  RXCORCNT;


	INV    inv1 (.I (rxusrclk), .O(rxusrclk_i));
	INV    inv2 (.I (txusrclk), .O(txusrclk_i));

//synthesis attribute period of rxusrclk2 is "24ns"
 
         bert_mgt mgt(
                    .REFCLK_IN(REFCLK_IN),
                    .REFCLK2_IN       (1'b0),
   					  .BREFCLK_IN       (1'b0), 
                    .BREFCLK2_IN      (1'b0), 
                    .ENCHANSYNC_IN    (ENCHANSYNC) ,
						  .CHBONDI_IN       (CHBONDI[3:0]),
						  .CHBONDO_OUT      (CHBONDO),
						  .CHBONDDONE_OUT   (CHBONDDONE), 
                    .CONFIGENABLE_IN  (1'b0), 
                    .CONFIGIN_IN      (1'b0), 
                    .ENMCOMMAALIGN_IN (1'b1), 
                    .ENPCOMMAALIGN_IN (1'b1), 
                    .LOOPBACK_IN      (lb_in[1:0]), 
                    .POWERDOWN_IN     (1'b0),
                    .REFCLKSEL_IN     (1'b0), 
                    .RXN_IN           (rxn_IN), 
                    .RXPOLARITY_IN    (RXPOLARITY_IN), 
                    .RXP_IN           (rxp_IN), 
                    .RXRESET_IN       (RXRESET_IN), 
                    .RXUSRCLK_IN      (rxusrclk_i), 
                    .RXUSRCLK2_IN 	  (rxusrclk2),
                    .TXCHARDISPMODE_IN (4'b0000), 
                    .TXCHARDISPVAL_IN  (4'b0000), 
                    .TXCHARISK_IN      (txcharisk_in[3:0]), 
                    .TXDATA_IN         (txdata_in[31:0]), 
                    .TXINHIBIT_IN      (1'b0), 
                    .TXPOLARITY_IN     (TXPOLARITY_IN), 
                    .TXRESET_IN        (TXRESET_IN), 
                    .TXUSRCLK_IN       (txusrclk_i), 
                    .TXUSRCLK2_IN      (txusrclk2),
                    .CONFIGOUT_OUT     (), 
                    .RXBUFSTATUS_OUT   (), 
                    .RXCHARISCOMMA_OUT (rxchariscomma_out), 
                    .RXCHARISK_OUT     (rxcharisk_out), 
                    .RXCOMMADET_OUT    (rxcommadet_out), 
                    .RXDATA_OUT        (rxdata_out), 
                    .RXDISPERR_OUT     (), 
                    .RXLOSSOFSYNC_OUT  (), 
                    .RXNOTINTABLE_OUT  (), 
                    .RXREALIGN_OUT     (rxrealign_out), 
                    .RXRECCLK_OUT      (), 
                    .RXRUNDISP_OUT     (), 
                    .TXBUFERR_OUT      (), 
                    .TXKERR_OUT        (), 
                    .TXN_OUT           (txn_OUT), 
                    .TXP_OUT           (txp_OUT), 
                    .TXRUNDISP_OUT     (),
  						  .TXBYPASS8B10B_IN  (4'b0000),
						  .TXFORCECRCERR_IN  (1'b0),
						  .RXCHECKINGCRC_OUT (),
						  .RXCLKCORCNT_OUT   (RXCORCNT[2:0]),
						  .RXCRCERR_OUT   	()
);

//this block keep rxclkcorcnt for chbd

assign  cbd_corcnt = (RXCORCNT == 3'b101)?1:0;

//this block checks the RXDATA after it has been placed in the FIFO
//if data is not correct error will go high
//this logic is clocked with the local clock route
align_comma_32 aligndata(
                           .usrclk2          (rxusrclk2),
									.rxreset          (RXRESET_IN),
									.rxisk            (rxcharisk_out),
									.rxdata           (rxdata_out),
									.rxrealign        (rxrealign_out),
									.rxcommadet       (rxcommadet_out),
									.rxchariscomma3   (rxchariscomma_out[3]),
									.rxchariscomma1   (rxchariscomma_out[1]),
									.aligned_data     (aligned_data),
									.sync             (aligned_sync),
									.aligned_rxisk    (aligned_rxisk)
									); 


//data_reception rx_data_rec (
//                            .clk80         (rxusrclk2), 
//									 .clk40         (clk40),
//									 .reset_mgt     (reset_mgt), 
//									 .aligned_data  (aligned_data), 
//									 .rxcharisk3    (aligned_rxisk[3]), 
//									 .rxchariscomma3(rxchariscomma_out[3]),
//									 .rxchariscomma1(rxchariscomma_out[1]), 
//                            .rxrealign     (rxrealign_out),
//									 .rxcommadet    (rxcommadet_out), 
//									 .stop_align    (stop_align),
//									 .bert_error    (bert_error),
//									 .sync_led      (sync_led),
//									 .err_led       (err_led),
//									 .count         (count),
//									 .cb_dout(cb_dout), 
//									 .cbs_flag(cbs_flag), 
//									 .cb_afifo_rden(cb_afifo_rden)
//									 );

assign sync_led = aligned_sync;
assign prbs_enable = aligned_sync && (~aligned_rxisk[3]);
rx_prbs_control prbs_check(
						    .aligned_data(aligned_data),
						    .rxusrclk2(rxusrclk2),
							 .clk40(clk40),
							 .reset(reset_rx_control),
							 .sync(aligned_sync),
							 .enable_check(prbs_enable),
							 .bert_error(bert_error),
//							 .sync_led(sync_led),
							 .sync_led(),
							 .err_led(err_led),
							 .count(count),
							 .rxcharisk3(aligned_rxisk[3]),
                      .cb_dout(cb_dout), 
							 .cbs_flag(cbs_flag), 
							 .cb_afifo_rden(cb_afifo_rden),
							 .cb_fifo_empty(cb_fifo_empty),
							 .cb_fifo_full(cb_fifo_full),
							 .Fiber_Fifo_Count(Fiber_Fifo_Count)
							 );



endmodule
