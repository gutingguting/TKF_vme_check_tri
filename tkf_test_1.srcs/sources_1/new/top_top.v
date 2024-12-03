`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:35:03 08/06/06
// Design Name:    
// Module Name:    top_top
// Project Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
//	Revision 0.1 06.11.20 MGT_top added 
// Revision 0.2 06.12.5  VME_top added
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
//if you find the end of the variable has the symbol like "v2p", it must be the variables
// from the firmware in the sp3 FPGA in the old board! It has the complictation in the process
// of porting-----wanghx
module top_top(
					   clk200p,clk200n,
						// refclkp_t,refclkn_t,refclkp_b,refclkn_b,
						//mgt refclk do not use in this test case!
                //   txn0,txn1,txn2,txn3,txn4,txn5,txn6,txn7,txn8,txn9,
                //   txp0,txp1,txp2,txp3,txp4,txp5,txp6,txp7,txp8,txp9,
                //   rxn0,rxn1,rxn2,rxn3,rxn4,rxn5,rxn6,rxn7,rxn8,rxn9,
                //   rxp0,rxp1,rxp2,rxp3,rxp4,rxp5,rxp6,rxp7,rxp8,rxp9,
					//no constrations information such like LOC in the top_top.ucf!   
						// Jump_Reset,
						// sync_led,
//                  err_led,
						// fuerr_led, 
						// ch_aliegned_led,
						// FPGA_LTK_P,FPGA_LTK_N,FPGA_STK_P,FPGA_STK_N
			         berr_in
						,GA 
			         ,iack,iackin,iackout
			         ,sysreset,OE245
						,L1_IN,CHK_IN,RST_IN,FRST_IN,TSYNC_IN,CRSV_IN
						,FULL,RERR,SRSV,SRSV2,FUERR
						// ,FULL_LED, RERR_LED
						,up_neighbour_in,down_neighbour_in,up_neighbour_out,down_neighbour_out
						,
//						G,iackout,ILOUT,test_29,tf_LA,tf_out,DATA
//add sp3 gpio by wanghx
					addr,am,Lword,as,ds,wr,Reload,berro,dtack,vmedata
// don't use 
// OE245(from v2p to sp3, finnaly use to output oe245 in sp3)!
/*berro: sp3 output to the VME; berr_in: v2p input from VME; berr_o_v2p is connection between 
	sp3 and v2p!*/
						);
//add sp3 wire type by wanghx
	input 	[27:1] addr;
	input   [5:0]  am;
	input 		   as;
	input   [1:0]  ds;
	input		   wr,Lword,Reload;
	output  	   dtack,berro,OE245;
	inout	[31:0] vmedata; 


	input         clk200p,clk200n;

    // output        txn0,txn1,txn2,txn3,txn4,txn5,txn6,txn7,txn8,txn9;
    // output        txp0,txp1,txp2,txp3,txp4,txp5,txp6,txp7,txp8,txp9;
    // input         rxn0,rxn1,rxn2,rxn3,rxn4,rxn5,rxn6,rxn7,rxn8,rxn9;
    // input         rxp0,rxp1,rxp2,rxp3,rxp4,rxp5,rxp6,rxp7,rxp8,rxp9;

	wire        txn0,txn1,txn2,txn3,txn4,txn5,txn6,txn7,txn8,txn9;
    wire        txp0,txp1,txp2,txp3,txp4,txp5,txp6,txp7,txp8,txp9;
    wire        rxn0,rxn1,rxn2,rxn3,rxn4,rxn5,rxn6,rxn7,rxn8,rxn9;
    wire        rxp0,rxp1,rxp2,rxp3,rxp4,rxp5,rxp6,rxp7,rxp8,rxp9;


    // input         Jump_Reset;
	// output [9:0] sync_led;

    wire        fuerr_led;
	wire        ch_aliegned_led;
	// output [15:0]	TEST;

	wire  [15:0]	TEST;

    input berr_in;
    // input ds_p,ds_n;
    input [4:0] GA;
	// input [15:0] addr;
    input iack;
    output iackout;
    input iackin;
    // inout [31:0] v2p_data;
	//changed by wanghx, Conflict between sp3 and v2p. So change the name in the top_top.v
	//Use the name like "v2p_data_sp3/v2p_data_v2p" to show the data where come from!
    input sysreset;
    
    input L1_IN,CHK_IN,RST_IN,FRST_IN,TSYNC_IN,CRSV_IN;
    
    output FULL,RERR,SRSV,SRSV2,FUERR;
	//  output FULL_LED, RERR_LED;
	wire FULL_LED,RERR_LED;
	

//    output [63:0] MD;
///////////////////////////////////////////////////////////////
// Track 
    wire [15:0]	FPGA_LTK_P,FPGA_LTK_N,FPGA_STK_P,FPGA_STK_N;
//long track &short track finder!
///////////////////////////////////////////////////////////////
// neighbour link
    input [46:0] up_neighbour_in;
    input [41:0] down_neighbour_in;
    output [41:0] up_neighbour_out;
    output [46:0] down_neighbour_out;
/////////////////////////////////////////////////

    reg [15:0] counter;
    wire [15:0] TF_S,TF_L;

    wire   [9:0] txn_out,txp_out,rxn_in,rxp_in;
	 wire   [9:0]	err_led;
	 wire   [31:0] FiberData[9:0];
	 wire   dtk1;
	 wire   [4:0]GA_inv;
	 wire   clk40,clk40_2x,clk40_3x,lock40,clk40_i;
	 wire   OE245_1;
	 wire [2:0] L1_select;
	 wire [2:0] trkcount;
	 wire       L1,tf_test_en,L1_vme;
	 wire 		loop,testdata_send,wr_ram,rd_ram;
    wire        ds_in;
	 reg  [2:0]  ds_tmp;

    wire [46:0] up_neighbour_in;
    wire [41:0] down_neighbour_in;
    reg  [46:0] up_neighbour_in_data;
	 reg  [46:0] up_neighbour_in_tmp[1:0];
    reg  [41:0] down_neighbour_in_data;
    reg  [41:0] down_neighbour_in_tmp[1:0];

    wire [41:0] up_neighbour_out;
    wire [46:0] down_neighbour_out;
    wire [41:0] up_neighbour_out_data;
    wire [46:0] down_neighbour_out_data;

	 wire [319:0] Testdata;
	 wire [319:0] hit_data;
	 wire [319:0] Hit_PreSet;
	 wire [7:0] CSR1,CSR2;
	 wire [7:0]  ONE_EVENT_AMOUNT;
	 wire [12:0] ALL_EVENT_AMOUNT;
	wire [3:0] ONCERDNUM;
	wire WR_WINDOW,RD_WINDOW;
	wire [3:0] WINDOW;
	wire [7:0] CENTER_LATENCY;
	wire  [3:0] PROGFULL;
	wire  [3:0] PROGFULL_DIS;
	wire   CMD_RST;
	wire   CMD_CLR;
	wire   reset_txgen;
	wire [1:0]  tx_cbs;
	wire  [9:0] cbs_flag;
	wire        cbs_flags;
	wire single_board_testdata;

	wire [63:0] TSF;
	wire [4:0] Sector_select;
	wire [31:0] run_mode;
	wire [3:0] 	TSF_Latency_for_readout,TK_Latency_for_readout;
	wire Fiber_Read_EN;
	wire [7:0] Fiber_Read_Latency;
	wire [15:0]Fiber_Channel_Set;
	wire [31:0]Fiber_Fifo_Status,Fiber_Channel_Alignment_Status;
   wire[31:0] Fiber_Fifo_Count9, Fiber_Fifo_Count8, Fiber_Fifo_Count7, Fiber_Fifo_Count6, Fiber_Fifo_Count5;
   wire[31:0] Fiber_Fifo_Count4, Fiber_Fifo_Count3, Fiber_Fifo_Count2, Fiber_Fifo_Count1, Fiber_Fifo_Count0;						  

	wire hitdelay_test;

	 wire   [31:0] aligned_data[9:0];
	 wire RERR_DAQ, SRSV_DAQ;

//################################################################
//
// version number can be readout to check firmware version.
//
//		0000 0000_0000 0000_0000 0000 
//     y	      m		    d		  v
//
//parameter VERSION = 24'h706056;
parameter VERSION = 24'h801291;
//
//
//################################################################

assign FULL_LED = !FULL;
assign RERR_LED = !RERR;
assign RERR = !lock40;
assign SRSV = 0;
assign SRSV2 = 0;

assign GA_inv[0] = ~GA[0];assign GA_inv[1] = ~GA[1];assign GA_inv[2] = ~GA[2];
assign GA_inv[3] = ~GA[3];assign GA_inv[4] = ~GA[4];
assign trigger_cdc = 1'b0;
assign txn9=txn_out[9];assign txn8=txn_out[8]; 
assign txn7=txn_out[7];assign txn6=txn_out[6];assign txn5=txn_out[5];assign txn4=txn_out[4];
assign txn3=txn_out[3];assign txn2=txn_out[2];assign txn1=txn_out[1];assign txn0=txn_out[0];

assign txp9=txp_out[9];assign txp8=txp_out[8]; 
assign txp7=txp_out[7];assign txp6=txp_out[6];assign txp5=txp_out[5];assign txp4=txp_out[4];
assign txp3=txp_out[3];assign txp2=txp_out[2];assign txp1=txp_out[1];assign txp0=txp_out[0];

assign rxn_in[9]=rxn9;assign rxn_in[8]=rxn8; 
assign rxn_in[7]=rxn7;assign rxn_in[6]=rxn6;assign rxn_in[5]=rxn5;assign rxn_in[4]=rxn4;
assign rxn_in[3]=rxn3;assign rxn_in[2]=rxn2;assign rxn_in[1]=rxn1;assign rxn_in[0]=rxn0;

assign rxp_in[9]=rxp9;assign rxp_in[8]=rxp8; 
assign rxp_in[7]=rxp7;assign rxp_in[6]=rxp6;assign rxp_in[5]=rxp5;assign rxp_in[4]=rxp4;
assign rxp_in[3]=rxp3;assign rxp_in[2]=rxp2;assign rxp_in[1]=rxp1;assign rxp_in[0]=rxp0;


//IBUFGDS #(
//      .DIFF_TERM("FALSE"),    // Differential Termination (Virtex-4 only)
//      .IBUF_DELAY_VALUE("0"), // Specify the amount of added input delay for the buffer, "0"-"16" (Spartan-3E only)
//      .IOSTANDARD("LVDS_25_DT")  // Specify the input I/O standard
//   ) buf_clk40 (
//      .O(clk40),  // Clock buffer output
//      .I(clk40p),  // Diff_p clock buffer input (connect directly to top-level port)
//      .IB(clk40n) // Diff_n clock buffer input (connect directly to top-level port)
//   );

/*
	add sp3/config
	by wanghx
	14.11.2024
*/ 
wire fryby;
wire faddr;
wire fce;
wire foe;
wire freset;
wire fwe;
wire as_v2p;
wire [17:2] addr_v2p;
wire OE245_v2p;
wire [31:0] v2p_data;
wire iack_o_v2p; //output by v2p, sp3 receive.
wire dtack_o_v2p;
wire berr_o_v2p;
wire CBLT_EN;
wire MCST_EN;
wire FPGA_EN;
wire BLK_EN;
wire write_sp3;// it means that this varity come from the sp3 frimware！
wire CBLT_LED_v2p;// output by v2p
// The variable that below the line is declaration for not used pin in the sp3 firmware!
wire pdata;
wire init_b;
wire dclk;
wire prog_b;
wire done;
wire [7:0] flashdata;
wire AddrWrRdEq_dic;
wire prog_dic;

Sp3_Top sp3(
				.clk(clk40_i), // no clk for about 40Mhz, need to devide from the 125Mhz in TRI-core
				.adcmp(),
				.addr(addr[27:1]),
				.am(am[5:0]),
				.Lword(Lword),
				.as(as),
				.ds(ds[1:0]),
				.wr(wr),
				.Reload(Reload),
				.berro(berro),
				.dtack(dtack),
				.fryby(fryby),
				.faddr(faddr),
				.fce(fce),
				.foe(foe), 
				.freset(freset),
				.fwe(fwe),
				.OE245(OE245),
				.pdata(pdata),
				.init_b(init_b),
				.dclk(dclk),
				.prog_b(prog_b),
				.done(done),
				.flashdata(flashdata),
				.vmedata(vmedata[31:0]),
				.v2p_data(v2p_data),
				.v2p_iack(iack_o_v2p),
				.v2p_oe245(OE245_v2p),
				.v2p_dtack(dtack_o_v2p),
				.v2p_berr(berr_o_v2p),
				.CBLT_EN(CBLT_EN),
				.MCST_EN(MCST_EN),
				.FPGA_EN(FPGA_EN),
				.BLK_EN(BLK_EN),
				.ds_v2p(ds_in),
				// .ds_v2p_n(ds_n),
				.add_v2p(addr_v2p),
				.as_v2p(as_v2p),
				.wr_v2p(write_sp3),
				.AddrWrRdEq_v2p(CBLT_LED_v2p),
				.AddrWrRdEq_dic(AddrWrRdEq_dic),
				.prog_dic(prog_dic)			
			);


clk_40 clk40_gen(
                 	  .clk200p(clk200p),
					  .clk200n(clk200n),
					  .reset(!CMD_RST),
					  .lock40(lock40),
					  .clk40(clk40), //clk_40's oppsite phase
					  .clk40_2x(clk40_2x),
					  .clk40_3x(clk40_3x),
					  .clk40_i(clk40_i) //40Mhz
					  );

// synthesis attribute KEEP of clk40 is "TRUE"
// ds = !ds0 && !ds1, it is effective when ds=1;

// IBUFDS #(
//       .DIFF_TERM("false")   // Differential Termination (Virtex-4 only)
//     //   .IBUF_DELAY_VALUE("0"), // Specify the amount of added input delay for the buffer, "0"-"16" (Spartan-3E only)
//     //   .IOSTANDARD("LVDS_25_DT")  // Specify the input I/O standard
//    ) buf1 (
//       .O(ds_in),  // Clock buffer output
//       .I(ds_p),  // Diff_p clock buffer input (connect directly to top-level port)
//       .IB(ds_n) // Diff_n clock buffer input (connect directly to top-level port)
//    );

// ds delay one clk...
always@(posedge clk40)
begin
  	ds_tmp[0] <= ds_in;
  	ds_tmp[1] <= ds_tmp[0];
	ds_tmp[2] <= ds_tmp[1];
end
assign ds_v2p_use = ds_tmp[1] & ds_tmp[0];
// assign ds = ds_tmp[1] & ds_tmp[0];

System_Command_Control INST_System_Command_Control
				(
				  .clk(clk40),
//				  .reset(Jump_Reset),
				  .reset(!CMD_CLR),//VME commond : CMD_CLR = 0; reset=1 valid;
				  .RST_IN(RST_IN),
				  .FRST_IN(FRST_IN),
				  .TSYNC_IN(TSYNC_IN),
				  .CRSV_IN(CRSV_IN),
				  .RST(RST),
				  .FRST(FRST),
				  .TSYNC(TSYNC),
				  .CRSV(CRSV),
				  .Fiber_Read_Latency(Fiber_Read_Latency),
				  .Fiber_Read_EN(Fiber_Read_EN),
              .FRST_PRE(FRST_PRE)
				);

data_trans DataTrans1(
						.VERSION(VERSION),
//						.clk(clk40),
						.clk(clk40_i),
						.ds(ds_v2p_use), 
						// .ds(ds), changed by wanghx
						.reset(!sysreset||!berr_in), 
						.iack(iack), 
						.addr(addr_v2p[17:2]), 
						// .addr(addr[15:0]), changed by wanghx
						.v2p_data(v2p_data),
						.write(write_sp3),
						.dtk_0(dtk_0), 
						.FPGA_EN(FPGA_EN), 
						.BLK_EN(BLK_EN),
						.GA(GA_inv),
						.ONE_EVENT_AMOUNT(ONE_EVENT_AMOUNT),
						.ALL_EVENT_AMOUNT(ALL_EVENT_AMOUNT),
						.CSR1(CSR1),
						.CSR2(CSR2),
						.ONCERDNUM(ONCERDNUM),
						.WINDOW(WINDOW),
						.CENTER_LATENCY(CENTER_LATENCY),
						.PROGFULL(PROGFULL),
						.PROGFULL_DIS(PROGFULL_DIS),
						.CMD_RST(CMD_RST),
						.CMD_CLR(CMD_CLR),
						.L1_gen(L1_vme),
						.L1_select(L1_select),
						.loop(loop),
						.testdata_send(testdata_send),
						.single_board_testdata(single_board_testdata),
						.WR_RAM(wr_ram),
						.RD_RAM(rd_ram),
						.reset_txgen(reset_txgen),
						.run_mode(run_mode),
						.Sector_select(Sector_select),
						.TSF_Latency_for_readout(TSF_Latency_for_readout),
						.TK_Latency_for_readout(TK_Latency_for_readout),
						.Fiber_Read_Latency(Fiber_Read_Latency),
						.Fiber_Channel_Set(Fiber_Channel_Set),
						.Fiber_Channel_Alignment_Status(Fiber_Channel_Alignment_Status),
						.Fiber_Fifo_Status(Fiber_Fifo_Status),
						.Fiber_Fifo_Count0(Fiber_Fifo_Count0),
						.Fiber_Fifo_Count1(Fiber_Fifo_Count1),
						.Fiber_Fifo_Count2(Fiber_Fifo_Count2),
						.Fiber_Fifo_Count3(Fiber_Fifo_Count3),
						.Fiber_Fifo_Count4(Fiber_Fifo_Count4),
						.Fiber_Fifo_Count5(Fiber_Fifo_Count5),
						.Fiber_Fifo_Count6(Fiber_Fifo_Count6),
						.Fiber_Fifo_Count7(Fiber_Fifo_Count7),
						.Fiber_Fifo_Count8(Fiber_Fifo_Count8),
						.Fiber_Fifo_Count9(Fiber_Fifo_Count9),
						.Hit_PreSet(Hit_PreSet)

					  );
L1_gen INST_L1_gen(
                .clk(clk40),
					 .L1_IN(L1_IN),
					 .L1_VME(L1_vme),
					 .Trkcount(trkcount),//[2:0]
					 .L1_select(L1_select),
					 .L1(L1)
					 );
assign trkcount[0]= (TF_L != 16'b0) ? 1: 0;
 
DAQ_top daq_top_v1(
					.gclkp(clk40),
//					.gclkp2(clk40_2x),			//80MHz
					.gclkp2(clk40_3x),			//120MHz
					.d_320in(hit_data),
					.ADDR(addr_v2p[9:2]), .GA(GA_inv),.DS(ds_v2p_use),.WRITE(write_sp3),.AS(as_v2p),.SYSRESET(sysreset),
					// .ADDR(addr[7:0]), .GA(GA_inv),.DS(ds),.WRITE(write),.AS(as),.SYSRESET(sysreset), 
					//changed by wanghx 15.11.2024 because of the as signal!
					.IACK(iack),.IACKIN(iackin),.BERRIN(berr_in),
					.L1(L1),.CHK(CHK_IN),.RST(RST),.CRSV(CRSV),	
					.DTACK2(dtk_1),.BERROUT(berr_1),.IACKOUT(iackout),
					.FULL(FULL),.RERR(RERR_DAQ),.SRSV(SRSV_DAQ),.oe245out(OE245_1),
					.FPGA_EN(FPGA_EN),.CBLT_EN(CBLT_EN),.MCST_EN(MCST_EN),
					.DATA(v2p_data),
					.ONE_EVENT_AMOUNT(ONE_EVENT_AMOUNT),
					.ALL_EVENT_AMOUNT(ALL_EVENT_AMOUNT),
					.CSR1(CSR1),
					.CSR2(CSR2),
					.ONCERDNUM(ONCERDNUM),
					.WINDOW(WINDOW),
					.CENTER_LATENCY(CENTER_LATENCY),
					.PROGFULL(PROGFULL),
					.PROGFULL_DIS(PROGFULL_DIS),
					.CMD_RST(CMD_RST),
					.CMD_CLR(CMD_CLR),
					.LTK(TF_L),
					.STK(TF_S),
					.RUN_MODE(run_mode),
					.TSF(TSF),
					.N7v(TSF_Latency_for_readout),
					.N8v(TK_Latency_for_readout),
					.CHECKex(CHECKex),
					.CBLT_LED(CBLT_LED_v2p)
						);

assign dtack_o_v2p = dtk_0 || dtk_1;
// assign dtack_o = dtk_0 || dtk_1; changed by wanghx
assign iack_o_v2p = iack;
// assign iack_o = iack;  changed by wanghx 
assign berr_o_v2p = berr_1;
// assign berr_o = berr_1; changed by wanghx
assign OE245_v2p = OE245_1;
// assign OE245 = OE245_1; changed by wanghx

// synthesis attribute KEEP of dtack_o is "TRUE"
wire cb_dout_aligned_o;


// MGT_top mgt_trans(
//                   .clk40(clk40),
// 						.refclkp_t(refclkp_t),
// 						.refclkn_t(refclkn_t),
// 						.refclkp_b(refclkp_b),
// 						.refclkn_b(refclkn_b),
//                   .txn(txn_out),
//                   .txp(txp_out),
//                   .rxn(rxn_in),
//                   .rxp(rxp_in),
// //						.reset(Jump_Reset),
// 						.reset(!CMD_CLR), //VME commond : CMD_CLR = 0; reset=1 valid;
// 						.FRST(FRST),
// 						.FRST_PRE(FRST_PRE),
// 						.Fiber_Read_EN(Fiber_Read_EN),
// 						.FUERR(FUERR),
// 						.cbs_flag(cbs_flag),
// 						.cbs_flags(cbs_flags),
// 						.reset_txgen(reset_txgen),
// 						.tx_cbs(tx_cbs),
// 						.err_led(err_led),
// 						.sync_led(sync_led),
// 						.count_led(count_led),
// 						.cb_dout_aligned(cb_dout_aligned_o),
// 						.cb_afifo_rden(cb_afifo_rden),
// 						.Fiber_Channel_Set(Fiber_Channel_Set),
// 						.Fiber_Channel_Alignment_Status(Fiber_Channel_Alignment_Status),
// 						.Fiber_Fifo_Status(Fiber_Fifo_Status),
// 						.FiberData0(FiberData[0]),
// 						.FiberData1(FiberData[1]),
// 						.FiberData2(FiberData[2]),
// 						.FiberData3(FiberData[3]),
// 						.FiberData4(FiberData[4]),
// 						.FiberData5(FiberData[5]),
// 						.FiberData6(FiberData[6]),
// 						.FiberData7(FiberData[7]),
// 						.FiberData8(FiberData[8]),
// 						.FiberData9(FiberData[9]),
// 						.aligned_data0(aligned_data[0]),
// 						.aligned_data1(aligned_data[1]),
// 						.aligned_data2(aligned_data[2]),
// 						.aligned_data3(aligned_data[3]),
// 						.aligned_data4(aligned_data[4]),
// 						.aligned_data5(aligned_data[5]),
// 						.aligned_data6(aligned_data[6]),
// 						.aligned_data7(aligned_data[7]),
// 						.aligned_data8(aligned_data[8]),
// 						.aligned_data9(aligned_data[9]),
// 						.Fiber_Fifo_Count0(Fiber_Fifo_Count0),
// 						.Fiber_Fifo_Count1(Fiber_Fifo_Count1),
// 						.Fiber_Fifo_Count2(Fiber_Fifo_Count2),
// 						.Fiber_Fifo_Count3(Fiber_Fifo_Count3),
// 						.Fiber_Fifo_Count4(Fiber_Fifo_Count4),
// 						.Fiber_Fifo_Count5(Fiber_Fifo_Count5),
// 						.Fiber_Fifo_Count6(Fiber_Fifo_Count6),
// 						.Fiber_Fifo_Count7(Fiber_Fifo_Count7),
// 						.Fiber_Fifo_Count8(Fiber_Fifo_Count8),
// 						.Fiber_Fifo_Count9(Fiber_Fifo_Count9)
						
// 						);


assign ch_aliegned_led = !cbs_flags;
assign fuerr_led = !FUERR;

obufds_16 short_track(
                      .di(~TF_S),
							 .do_p(FPGA_STK_P),
							 .do_n(FPGA_STK_N)
							 );

obufds_16 long_track(
                      .di(~TF_L),
							 .do_p(FPGA_LTK_P),
							 .do_n(FPGA_LTK_N)
							 );
                  

TrackFinder_top INST_TrackFinder_top(
							.clk(clk40), 
							.reset(1'b0), 
							.GA(GA_inv), 
							.TF_en(1'b1),
							.Long_Track(TF_L), 
							.Short_Track(TF_S),
							.hit_in(hit_data|Hit_PreSet),
							.up_neighbour_in(up_neighbour_in_data), 
							.down_neighbour_in(down_neighbour_in_data),
							.up_neighbour_out(up_neighbour_out_data), 
							.down_neighbour_out(down_neighbour_out_data),
						   .TSF_ReadOut(TSF),
							.Sector_select(Sector_select),
							.hitdelay_test(hitdelay_test)
							);

assign hit_data = testdata_send ? Testdata:{FiberData[9],FiberData[8],FiberData[7],FiberData[6],FiberData[5],FiberData[4],FiberData[3],FiberData[2],FiberData[1],FiberData[0]};

always@(posedge clk40)
begin
  if(single_board_testdata)
     up_neighbour_in_data	<= 47'b0;     
  else
     up_neighbour_in_data	<= up_neighbour_in_tmp[1];
	  up_neighbour_in_tmp[1]<= up_neighbour_in_tmp[0];
	  up_neighbour_in_tmp[0]<= ~up_neighbour_in;
end

always@(posedge clk40)
begin
  if(single_board_testdata)
     down_neighbour_in_data	<= 42'b0;     
  else
     down_neighbour_in_data	<=down_neighbour_in_tmp[1];
     down_neighbour_in_tmp[1]	<=down_neighbour_in_tmp[0];
	  down_neighbour_in_tmp[0]	<=~down_neighbour_in;
end

assign up_neighbour_out = ~up_neighbour_out_data;
assign down_neighbour_out = ~down_neighbour_out_data;


testram_control testram_module (
		.wr_ram(wr_ram), 
		.rd_ram(rd_ram), 
		.reset(TSYNC),
		.loop(loop), 
		.clk40(clk40), 
		.addr(addr_v2p[17:2]), 
		// .addr(addr[15:0]), changed by wanghx
		.testdata_send(testdata_send), 
		.v2p_data(v2p_data), 
		.data_o(Testdata)
	);

//PCB signals test

//always@(posedge clk40)
//begin
//  counter = counter + 1;
//end
////assign MD[63:48] = counter;
////assign MD[47:32] = counter;
////assign MD[31:16] = counter;
////assign MD[15:0] = counter;
//assign TF_S = counter;
//assign TF_L = counter;
////assign ILOUT = {counter[8:0],counter,counter,counter,counter,counter};

//ddr_interface ddr_int1(											 
//                       .ddr_i(ddr_i),
//							  .clk40(clk40), 
//							  .data32_i(data32_i),  
//							  .rst(Jump_Reset), 
//							  .CE(1'b1)
//							  );
//
//assign TEST[9:0] = cbs_flag;
assign TEST[15] = up_neighbour_out_data[0];
assign TEST[14] = down_neighbour_out_data[0];
assign TEST[13] = up_neighbour_in_data[0];
assign TEST[12] = down_neighbour_in_data[0];
//assign TEST[13] = cb_dout_aligned;
//assign TEST[12] = cbs_flags;

assign TEST[11]=iackout;
assign TEST[10]=dtack_o_v2p;
// assign TEST[10]=dtack_o; changed by wanghx
assign TEST[9]=dtk_1;
assign TEST[8]=OE245_1;
assign TEST[7] = iackin;

//wanghx add
reg cb_afifo_rden;

assign TEST[6] = aligned_data[9][1];
assign TEST[5] = FiberData[9][1];
assign TEST[4]	= cb_afifo_rden;
assign TEST[3]	= FRST;
assign TEST[2]	= FUERR;
assign TEST[1]	= Fiber_Read_EN;
assign TEST[0]	= cbs_flags;




endmodule