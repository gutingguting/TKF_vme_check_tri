`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    08:49:20 12/07/06
// Design Name:    
// Module Name:    v2p_interface
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
module Sp3_v2p_interface( 
	done,
	wr,
	haddr,
	addr,
	ds,
	Lword,
	am,
	bs_dip,
	CBLT_EN,
	MCST_EN,
	FPGA_EN,
	BLK_EN,
	sp3_en,
	v2p_en,
	iack,
	oe
	);
	input		done;
	input		wr,Lword,iack;
	input		[1:0]ds;
	input		[27:18]haddr;
	input		[7:1]addr;
	input		[5:0]am;
	input		[23:19]bs_dip;

	output 	sp3_en,v2p_en;
	output	CBLT_EN,MCST_EN,FPGA_EN,BLK_EN,oe;

//	wire bs,bs_sp3,ds_dl,ds_inv;	// bs_v2p,
//	reg bs_lch;
	wire fpga_addrsel,fpga_amsel;
	wire iacksel;
	wire blk_addrsel,blk_amsel;

	assign fpga_addrsel = ((haddr[23:19]==bs_dip)&&(haddr[18] == 1'b0)&&(Lword == 1'b0)&&(addr[1] == 1'b0))?1:0;
	assign fpga_amsel =  ((am==6'h39) || (am==6'h3D))?1:0;
	assign iacksel = (done==1)?iack:0;

		assign FPGA_EN = fpga_addrsel && fpga_amsel && iacksel;

	assign blk_addrsel = ((haddr[23:19]==bs_dip)&&(haddr[18] == 1'b0)&&(Lword == 1'b0))?1:0;
	assign blk_amsel = ((am==6'h3F) || (am==6'h3B))?1:0;

		assign BLK_EN = blk_addrsel && blk_amsel && iacksel;

// synthesis attribute KEEP of fpga_addrsel is "TRUE"
// synthesis attribute KEEP of fpga_amsel is "TRUE"
// synthesis attribute KEEP of iacksel is "TRUE"
// synthesis attribute KEEP of blk_addrsel is "TRUE"
// synthesis attribute KEEP of blk_amsel is "TRUE"
// synthesis attribute KEEP of FPGA_EN is "TRUE"


	assign bs_fpga = ((done==1)?iack:0) && !haddr[18] && ((haddr[23:19]==bs_dip)?1:0);



	//A24/D32 w/r cycle
//	assign FPGA_EN = bs_fpga && ((am==6'h39) || (am==6'h3D)) && !Lword && !addr[1];
	//cblt board select, AM = 0F or 0B for A32:D32 cblt translation
	assign CBLT_EN = ((done==1)?iack:0) && (haddr[27:24] == 4'b0001) && ((am==6'h0F) || (am==6'h0B)) && !Lword && wr;
	// BLOCK TRANSFER ENABLE
//	assign BLK_EN = bs_fpga && ((am==6'h3F) || (am==6'h3B)) && !Lword;
	//mcst board select, AM = 09 or 0D for A32:D32 mcst translation
	assign MCST_EN = ((done==1)?iack:0) && (haddr[27:24] == 4'b0010) && ((am==6'h09) || (am==6'h0D)) && !Lword && !wr;

	// sp3, a24/d16 ==>>  am = 6'h39
	//assign sp3_3n = iack&&((am==6'h39)&&(bs_dip[23:19]==haddr[23:19])&&(haddr[18]==1'b0)&&Lword); 

	//assign sp3_en = ((am==6'h39)&&(bs_dip[23:19]==haddr[23:19])&&(haddr[18]==1'b0)&&Lword);
	assign sp3_en = ((done==1)?iack:1)&&((am==6'h39)?1:0)&&((bs_dip[23:19]==haddr[23:19])?1:0)&&haddr[18]&&((addr[7:4]=='b0000)?1:0)&&Lword;



	//v2p, a24/d32, cblt,mcst  ==>>  ((am==6'h39)||(am==6'h3D)||(am==6'h0F)||(am==6'h0B)||(am==6'h09)||(am==6'h0D))
	//assign v2p_en = am[3]&&am[0]&&(bs_dip[23:19]==haddr[23:19])&&(haddr[18]==1'b1)&&(!Lword);
	assign v2p_en = FPGA_EN || CBLT_EN || MCST_EN || BLK_EN;

 
//	assign oe = (ds[0] || ds[1]) || !sp3_en || !FPGA_EN || !MCST_EN || !BLK_EN;

//	assign oe = !sp3_en;
	assign oe = !(sp3_en || FPGA_EN || MCST_EN || BLK_EN);

endmodule


