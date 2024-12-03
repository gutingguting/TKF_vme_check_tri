`timescale 1ns / 1ps
module Sp3_Top(
				clk,

				adcmp,addr,am,Lword,as,ds,wr,
				Reload,
				berro,dtack,

            fryby,faddr,fce,foe,freset,fwe, 
            OE245, 
            pdata,init_b,dclk,prog_b,done, 
            flashdata,
            vmedata,

				v2p_data,v2p_iack,v2p_oe245,v2p_dtack,v2p_berr,

				CBLT_EN,MCST_EN,FPGA_EN,BLK_EN,
				ds_v2p,
				add_v2p,as_v2p,wr_v2p,

				AddrWrRdEq_v2p,
				AddrWrRdEq_dic,
				prog_dic			
	);
	input Reload;
	input [23:19] adcmp;
	input [27:1] addr;
	input [5:0] am;
	input as;
	input clk;
	input done;
	input [1:0]ds;
	input fryby;
	input init_b;
	input wr,Lword;
	input v2p_oe245,v2p_iack,v2p_dtack,v2p_berr;

	input AddrWrRdEq_v2p;



	output ds_v2p,as_v2p,wr_v2p;
//	output [9:2] add_v2p;
	output [17:2] add_v2p;
	output berro;
	output dclk;
	output dtack;
	output [21:0] faddr;
	output fce;
	output foe;
	output freset;
	output fwe;
	output OE245;
	output pdata;
	output prog_b;
	output CBLT_EN,MCST_EN,FPGA_EN,BLK_EN;

	output wire AddrWrRdEq_dic;
	output wire prog_dic;


	inout [7:0] flashdata;
	inout [31:0] vmedata;
	inout [31:0] v2p_data;
	

   
   wire sp3_en;
   wire v2p_en;
	wire ds_v2p;
   wire wr_inv;

   wire [15:0] VME2CFG;
   wire [15:0] CFG2VME;
   wire [7:0] FLASH2CFG;
   wire [7:0] CFG2FLASH;

   wire RLoad_cons1;
	wire RLoad_real;
	wire fryby_cons1;
	wire fryby_real;

	wire OE245_SP3_V2P;
	wire [31:0]vme2v2p;
	wire [31:0]v2p2vme;
	wire [31:0]FromVme;
	wire [31:0]ToVme;

	wire V2pAndSp3En;

	assign V2pAndSp3En = sp3_en || v2p_en;

	wire dtack_1,berr_1;
//	reg  [27:1] addr_lch;
	reg [27:1] addr_lch;
	reg Lword_lch;

	//assign fryby_test = fryby;
	assign wr_v2p = wr;

	assign add_v2p = addr_lch[17:2]; 						
	assign ds_v2p = (!ds[0]) && (!ds[1]);				
	// synthesis attribute KEEP of ds_v2p is "TRUE";
	assign as_v2p = as;
	
	assign OE245 = (CBLT_EN == 1'b1)?v2p_oe245:OE245_SP3_V2P;

	assign dtack = dtack_1 || (v2p_dtack && done); 
	assign berro = berr_1 || (v2p_berr && done);	 

	always@(negedge as)
	begin
	  addr_lch <= addr;
	  Lword_lch <= Lword;  
	end

	   GND gnd_1 (.G(berr_1));

	//    OBUFDS #(
	//       .IOSTANDARD("LVDS_25") // Specify the output I/O standard
	//    ) OBUFDS1 (
	//       .O(ds_v2p_p),     // Diff_p output (connect directly to top-level port)
	//       .OB(ds_v2p_n),   // Diff_n output (connect directly to top-level port)
	//       .I(ds_v2p)      // Buffer input 
	//    );

 

/*	assign ds_v2p_p = ds_v2p;
	assign ds_v2p_n = ds_v2p;*/

	v2p_CbltAndCfgDisp_dic CbltAndCfgdoneDic (
						.clk(clk),
						.done(done),
						.prog_dic(prog_dic), 
						.AddrEqIn(AddrWrRdEq_v2p), 
						.AddrEqOut(AddrWrRdEq_dic)
						);
	
	  
   bidir8 bi08_1 (.cplden(sp3_en), 
                  .ctrl(wr), 
                  .DataIn(CFG2FLASH[7:0]), 
                  .DataOut(FLASH2CFG[7:0]), 
                  .DataInout(flashdata[7:0]));
   bidir32 Bi32_vme (.en(V2pAndSp3En),
						 .ctrl(wr_inv), 
                   .DataIn(ToVme[31:0]), 
                   .DataOut(FromVme[31:0]), 
                   .DataInout(vmedata[31:0]));

   bidir32 Bi32_v2p (.en(v2p_en),
						 .ctrl(wr), 
                   .DataIn(vme2v2p[31:0]), 
                   .DataOut(v2p2vme[31:0]), 
                   .DataInout(v2p_data[31:0]));

	DataChanSel DataSel_1 (.ds(ds[1:0]),
								.v2pen(v2p_en),
								.sp3en(sp3_en),
								.cblten(CBLT_EN),
								.mcsten(MCST_EN),
								.vmedin(FromVme[31:0]),
								.vmedout(ToVme[31:0]), 
								.sp3din(CFG2VME[15:0]),
								.sp3dout(VME2CFG[15:0]),
								.v2pdin(v2p2vme[31:0]),
								.v2pdout(vme2v2p[31:0]));

   INV InvWr (.I(wr), 
             .O(wr_inv));

   set1or0 SetReload1 (.in1(Reload), 
                     .cons_1(RLoad_cons1), 
                     .eq_in1(RLoad_real));

   set1or0 SetReload2 (.in1(fryby), 
                     .cons_1(fryby_cons1), 
                     .eq_in1(fryby_real));

   Sp3_CfgFPGA CfgFpga (.as(as), 
                      .chipen(sp3_en), 
                      .clk(clk), 
                      .datain(VME2CFG[15:0]), 
                      .done(done), 
                      .ds0(ds[0]), 
                      .ds1(ds[1]), 
                      .fdatai(FLASH2CFG[7:0]), 
                      .fryby(fryby_real), 
                      .init_b(init_b), 
                      .Laddr(addr[3:1]), 
                      .reload(RLoad_real),// RLoad_cons1	//RLoad_real
                      .wr(wr), 
                      .dataout(CFG2VME[15:0]), 
                      .dclk(dclk), 
                      .dtack(dtack_1), 
                      .faddr(faddr[21:0]), 
                      .fce(fce), 
                      .fdatao(CFG2FLASH[7:0]), 
                      .foe(foe), 
                      .freset(freset), 
                      .fwe(fwe), 
                      .pdata(pdata), 
							 .prog_dic(),
                      .prog_b(prog_b)

							 );

   Sp3_v2p_interface Sp3_interface (.done(done),
											 .addr(addr_lch[7:1]),//(addr[7:1]), 
                                  .am(am[5:0]), 
                                  .bs_dip(adcmp[23:19]), 
                                  .ds(ds[1:0]), 
                                  .haddr(addr_lch[27:18]),//(addr[27:18]), 
                                  .iack(v2p_iack), 
                                  .Lword(Lword_lch),//(Lword), 
                                  .wr(wr), 
                                  .CBLT_EN(CBLT_EN), 
                                  .FPGA_EN(FPGA_EN), 
                                  .MCST_EN(MCST_EN),
											 .BLK_EN(BLK_EN), 
                                  .oe(OE245_SP3_V2P),
                                  .sp3_en(sp3_en), 
                                  .v2p_en(v2p_en));
endmodule