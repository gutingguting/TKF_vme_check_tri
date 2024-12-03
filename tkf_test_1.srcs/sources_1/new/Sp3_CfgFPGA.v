`timescale 1ns / 1ps
//#######################################################################################################
//									  --------------program timming---------------------
//#######################################################################################################

//prog_b:	~~~~~|_|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

//init_b:	~~~~~|_______________________|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//dclk:		______________________________|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|_|~|____	

//data: 		-----------------------------|0|-|0|-|0|-|0|-|0|-|0|-|0|-|0|-|0|-|0|-|0|-|0|-------------

//done:		_____________________________________________________________________________|~~~~~~~~~~~	

//########################################################################################################

//########################################################################################################
//								----------------------NOTE:--------------------------
//########################################################################################################
/*+--------+----------+--------+*/
/*| 16M bit|	16M bit|	32M bit|*/
/*+--------+----------+--------+*/
/*| 1d9600;|	159600;|	244800 |*/ 
/*| 1d9602;|	159602;|	244802 |*/ 
/*| 080000;|	000000;|	000000 |*/ 
/*+--------+----------+--------+*/

//########################################################################################################
//								----------------------Address being used--------------------
//########################################################################################################
/*
wr/rd			addr		data		function
------------------------------------------------
WrA24D16		0x0000 	0x????	reset the address
WrA24D16		0x0002	0x???? 	clear the memory
WrA24D16		0x0004	0x????	read/write data to FlashMemory
WrA24D16		0x0006	0x????	configure FPGA from VME bus
WrA24D16		0x0008	0x????	configure FPGA from FlashMemory
WrA24D16		0x000a	0x000?	swich on/off "reload" mask; "0":reload enable; "1":reload disable(default)
*/
//########################################################################################################



`define ProgramMarkA0 22'h244800	/* 1d9600;	159600;	244800 */ 
`define ProgramMarkA2 22'h244802	/* 1d9602;	159602;	244802 */ 
`define StartAddr 22'h000000 		/* 080000;	000000;	000000 */ 

module Sp3_CfgFPGA(clk,ds0,ds1,wr,as,Laddr,dtack,fdatai,fdatao,pdata,datain,dataout,reload,
			faddr,fce,foe,fwe,freset,fryby,prog_b,init_b,done,dclk,chipen,prog_dic);	//
////////////////////////////////////////////////////////

input reload;
input chipen;
input clk,ds0,ds1,wr,as;

input [3:1]Laddr;
input [7:0]fdatai; 	//fdatai: from flash
input fryby,init_b,done; 
input [15:0]datain;

output dtack;
output [7:0]fdatao;//,pdata;//fdatao: to flash; pdata: to FPGA	
output pdata; 
output [21:0]faddr;
output fce,foe,fwe,freset;
output prog_b,dclk;

output [15:0]dataout;

output prog_dic;
reg prog_dic;

reg [1:0]initcnt=2'b00;
reg [1:0]cmdcnt=2'b00;
reg [4:0]erasecount=5'b0;
reg [4:0]tfcount=5'h00;
reg [9:0]tfwcount=10'b0;

reg f2fen='b0;
reg beginprg='b0;

reg dtack='b0;
reg [7:0]fdatao;
reg [7:0]fdataitmp;
//reg [7:0]pdata=8'b0;
reg pdata=1'b0;
reg [21:0]faddr=`StartAddr;
reg fce,foe,fwe,freset;
reg prog_b,dclk;
reg [15:0]dataout;

reg [7:0]pwrcfgi=8'h00;
reg [5:0]cfgi=6'h00;
reg cfgicnten=1'b0;





reg [7:0]chkreg;
reg [15:0]datatmp;
reg [24:0]pwrcounti=25'h0000000;	//��ʱ0.8��
reg pwrok='b0;

reg [5:0]vmeprgcnt=6'b0;
reg [5:0]vmecfgcnt=6'b0;
reg vmeprgbegin = 1'b0;
reg progpulse=1'b0;
reg [3:1]addr=7'b0;
reg inwr='b1;
reg [13:0]dtackloc=14'h0000;
reg [3:0]dtklokcnt=4'h0;
reg lock=1'b0;

reg [7:0]dclkcnt=8'h00; 
reg donedly=1'b1;
reg dsa=1'b1;


reg reloadMASK = 1'b1;

reg reload_use = 1'b1;

reg DClkBegin = 1'b0;
reg init_b_conct = 1'b0;



reg v2fen = 1'b0; 
//##################################################################
//									program dictaion
//##################################################################
always @ (posedge clk)
begin
	if ((pwrok == 1)&&(f2fen == 0)&&(addr[3:1]==3'b011)&&(chipen == 1))
		v2fen <= 1'b1;
	else
		v2fen <= 1'b0;
end

always @ (posedge clk)
begin
	prog_dic <= (~f2fen) && (~v2fen);
end

//##################################################################
//									reload MASK
//##################################################################

always @ (reload,reloadMASK)
begin
	reload_use <= reload || reloadMASK;
end

//reg [15:0]datatemp=16'h0000;
//reg [1:0]dsacnt=2'b00;
//reg [3:0]reloadcnt = 4'h0;

//##################################################################
//								dsa <= ds0 | ds1	
//##################################################################
always @ (ds0,ds1,as)
begin
	if (as == 0)
		dsa <= ds0 | ds1;
	else
		dsa <= 1;
end

 

//##################################################################
//							redundancy dclk count//
//##################################################################

always @ (posedge clk)
	begin
		if (done==0)
			begin
				dclkcnt <=8'h00;
				donedly <= 0;
			end
		else if ((done==1)&&(dclkcnt < 8'hff))
			begin
				dclkcnt <= dclkcnt + 1;
				donedly <= 1;
			end
		else if (dclkcnt == 8'hff)
			donedly <= 0;
			
	end
//##################################################################
//							lock the Laddr to addr;//
//##################################################################
always @ (negedge as)
begin
	addr <= Laddr;
end
//##################################################################
////						lock the wr to inwr;//
//##################################################################

always @ (negedge ds0)
begin
	inwr <= wr;
end

//##################################################################
								////////////////////////
/////////////////////////    main program;   //////////////
							  ////////////////////////
//##################################################################
always @ (posedge clk)
begin	

	//////////////////////////////
	//      power on count;     //
	//////////////////////////////
	if (reload_use == 1'b0) //(reload == 1'b0)
		begin
			pwrcounti <= 25'h0000000;
			pwrok <= 1'b0;
		end
	else
		begin
			if (pwrcounti != 25'h1ffffff)
				begin
					pwrcounti <= pwrcounti + 1;
					pwrok <= 0;
				end
			else
				pwrok <= 1;
		end

	//////////////////////////////
	//    main program count;   //
	//////////////////////////////
	if((addr[3:1]==3'b000)&&(chipen == 1'b1))
		begin 
			///////////////////////////////////////////////////////////////////
			// VME initial count	& VME configuration count
			///////////////////////////////////////////////////////////////////
			vmeprgcnt <= 6'h0;
			vmecfgcnt <= 6'b0;
//			v2fcnt <= 20'h00000;	 // to be deleted
			vmeprgbegin <= 0;
			dtackloc <= 14'h0000;
			dtklokcnt <= 4'h0;
			erasecount <= 5'h0;
			/////////////////////
			if ((dsa==0)&&(initcnt==2'b0))//&&(inwr==0)) 
				initcnt <= 2'b01;
			else if (initcnt==2'b01)
				initcnt <= 2'b10;
			else if (initcnt==2'b10)
				initcnt <= 2'b11;
			else if ((dsa==1)&&(initcnt==2'b11))
				initcnt <= 2'b0;
		end
	else if((addr[3:1]==3'b001)&&(chipen == 1'b1))
		begin
			///////////////////////////////////////////////////////////////////
			// VME erase chip count
			///////////////////////////////////////////////////////////////////
			if ((dsa==0)&&(erasecount=='h0)&&(inwr==0))		
			 	erasecount <= 'h1;
			else if((erasecount>0)&&(erasecount<'h1f))					 
				erasecount <= erasecount + 1;
			else if ((erasecount=='h1f)&&(dsa == 1))//&&(fryby==1))
				erasecount <= 5'h0;

		end
	else if ((addr[3:1]==3'b010)&&(chipen == 1'b1))
		begin
			if(inwr==1)
				begin
					///////////////////////////////////////////////////////////////////
					// vme read from flash count 
					///////////////////////////////////////////////////////////////////
					if ((ds0==0)&&(ds1==0)&&(as==0)&&(tfcount==5'h0))
						tfcount <= 5'h1;
					else if ((tfcount > 5'h0) && (tfcount < 5'h1f))
						tfcount <= tfcount + 1;
					else if((dsa==1)&&(tfcount==5'h1f)) //(dsa==1)//
						tfcount <= 5'h00;
				end
			else
				begin
					///////////////////////////////////////////////////////////////////
					//vme write to flash count
					///////////////////////////////////////////////////////////////////
					if ((ds0==0)&&(ds1==0)&&(as==0)&&(tfwcount==10'h000))
						tfwcount <= 'h1;
					else if ((tfwcount > 10'h000) && (tfwcount < 10'h3ff))
						tfwcount <= tfwcount + 1;
					else if(dsa==1)//((dsa==1)&&(tfwcount=='h3ff))
						tfwcount <= 10'h000;
				end
		end
	else if((addr[3:1]==3'b011)&&(chipen == 1'b1))
		begin	
			if (vmeprgbegin == 1'b0)
				begin	
					///////////////////////////////////////////////////////////////////
					// VME configure count 
					///////////////////////////////////////////////////////////////////
					if ((dsa==0)&&(vmeprgcnt == 6'h0)&&(inwr==0))
						begin
							vmeprgcnt <= 6'h1;
							progpulse <= 0;
						end
					else if ((vmeprgcnt > 6'h0)&&(vmeprgcnt < 6'h3f))
						begin
							vmeprgcnt <= vmeprgcnt + 1;
							progpulse <= 1;
						end
					else if (vmeprgcnt == 6'h3f)
						begin
							vmeprgbegin <= 1;
							progpulse <= 0;
						end
				end
			else
				begin
					if((dsa==0)&&(vmecfgcnt=='h0)&&(init_b == 1)&&(inwr==0))
						vmecfgcnt <= 7'b1;
					else if ((vmecfgcnt > 6'h0)&&(vmecfgcnt < 6'h3f))
						vmecfgcnt <= vmecfgcnt + 1;
					else if ((dsa==1)&&(vmecfgcnt == 6'h3f))
						vmecfgcnt <= 7'b0;
				end
			/////////////////////////////////////////
			if (init_b==1'b0)	 // if init_b does not go to high then delay count. 
				begin
					if (dtackloc==14'h0000)
						begin
							dtackloc <= 14'h1;
							lock <= 1;
						end
					else if ((dtackloc>14'h0000)&&(dtackloc<14'h3fff))
						begin
							dtackloc <= dtackloc + 1;
							lock <= 1;
						end
					else if ((dtackloc==14'h3fff)&&(dtklokcnt<4'hf))
						begin
							dtackloc <= 14'h1;
							dtklokcnt <= dtklokcnt + 1;
							lock <= 1;
						end
					else if ((dtackloc==14'h3fff)&&(dtklokcnt==4'hf))
						begin
							lock <= 0;
						end
				end
			else
				lock <= 0;
		end

	else if(((addr[3:1]==3'b100)||(addr[3:1]==3'b101))&&(chipen == 1'b1))
		begin
			if ((dsa==0)&&(cmdcnt==2'b0)&&(inwr==0)) 
				cmdcnt <= 2'b01;
			else if (cmdcnt==2'b01)
				cmdcnt <= 2'b10;
			else if (cmdcnt==2'b10)
				cmdcnt <= 2'b11;
			else if (cmdcnt==2'b11)
				cmdcnt <= 2'b0;
		end
	else if((addr[3:1]==3'b110)&&(chipen == 1'b1)) 
		begin
			if ((dsa==0)&&(cmdcnt==2'b0)&&(inwr==1)) 
				cmdcnt <= 2'b01;
			else if (cmdcnt==2'b01)
				cmdcnt <= 2'b10;
			else if (cmdcnt==2'b10)
				cmdcnt <= 2'b11;
			else if (cmdcnt==2'b11)
				cmdcnt <= 2'b0;
		end
end
//##################################################################
//--------------------------main program--------------------------//
//##################################################################

//===============================================================  OK

//prog_b:	~~~~~~~|___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//init_b:	~~~~~~~|________________________|~~~~~~~~~~~~~~~~~~~~~

//DClkBegin:~~~~~~~|________________________|~~~~~~~~~~~~~~~~~~~~~

//=============================================================== init_b not connect

//prog_b:	~~~~~~~|___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//init_b:	~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//DClkBegin:~~~~~~~|______________________________________________

//===================================================================
// finished cfg but "done" pin not go to high, and "init_b" pin go to low 

//prog_b:	~~~~~~~|___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//init_b:	~~~~~~~|________________________|~~~~~~~~~~~~~~|______

//DClkBegin:~~~~~~~|________________________|~~~~~~~~~~~~~~~~~~~~~

//===================================================================
always @ (posedge clk)
begin
	if (prog_b == 1'b0)
		begin
			DClkBegin <= 1'b0;
			if (init_b == 1'b0)
				init_b_conct <= 1'b1; 
		end
	else
		begin
			if((init_b == 1'b1)&&(init_b_conct == 1'b1))
				DClkBegin <= 1'b1;	
		end 
	//================================================

end

//==================================================================

//##################################################################
//##################################################################
always @ (posedge clk)
begin
	if (pwrok == 0)
		begin
			f2fen <= 1;	 ///////////////////////////////////
			pwrcfgi <= 8'h00;
			prog_b <= 1;
		end
	else
		begin
				if (f2fen == 0)
				begin
					dclk <= donedly & (~dclk);
					if ((addr[3:1]==3'b000)&&(chipen == 1))			//	cpld operation
					//###################################################################################### Address Reset
						begin
 							prog_b <= 1;
							if (initcnt == 'b01)
								faddr <= `StartAddr;						
							else if ((initcnt == 'b10)||(initcnt == 'b11))
								dtack <= 1;
							else 
								dtack <= 0;
						end
					else if ((addr[3:1]==3'b001)&&(chipen == 1))//erase all data from flash memory chip;
					//###################################################################################### Chip erase
						//VME command to erase the flash memory "AA 55 80 AA 55 10"
						begin
							prog_b <= 1;
							freset <= 1;
							foe <= 1;
							fce <= 0;
							/////////////////////////////
							if (erasecount=='h1f) 
								dtack <= 1;
							else
								dtack <= 0;
							/////////////////////////////////
							//flash erase command sequence //
							/////////////////////////////////

							if (erasecount=='h01)
								begin
									fwe <= 1;
									fdatao <= 'haa;	//----------------------aa
								end
							else if(erasecount=='h02) 
								fwe <= 0;
							else if(erasecount=='h05)
								fwe <= 1;
							else if (erasecount=='h06)
								begin
									fwe <= 1;
									fdatao <= 'h55;  //----------------------55
								end
							else if(erasecount=='h07) 
								fwe <= 0;
							else if(erasecount=='h0a)
								fwe <= 1;
							else if (erasecount=='h0b)
								begin
									fwe <= 1;
									fdatao <= 'h80;	//----------------------80
								end
							else if(erasecount=='h0c) 
								fwe <= 0;
							else if(erasecount=='h0f)
								fwe <= 1;
							else if (erasecount=='h10)
								begin
									fwe <= 1;
									fdatao <= 'haa;	//----------------------aa
								end
							else if(erasecount=='h11) 
								fwe <= 0;
							else if(erasecount=='h14)
								fwe <= 1;
							else if (erasecount=='h15)
								begin
									fwe <= 1;
									fdatao <= 'h55;	//----------------------55
								end
							else if(erasecount=='h16) 
								fwe <= 0;
							else if(erasecount=='h19)
								fwe <= 1;
							else if (erasecount=='h1a)
								begin
									fwe <= 1;
									fdatao <= 'h10;	//----------------------10
								end
							else if(erasecount=='h1b) 
								fwe <= 0;
							else if(erasecount=='h1e)
								fwe <= 1;
						end
					else if ((addr[3:1]==3'b010)&&(chipen == 1))////read from or write to flash memory chip;
					//######################################################################################  Read or Write FlashMemory
						begin
							prog_b <= 1;
							freset <= 1;
							if (inwr==1)//VME read from flash memory	
								begin
									//vme read from flash
									fwe <= 1;
									//////////////////////////////////////////
									if (tfcount==5'h1f) 
										dtack <= 1;	
									else
										dtack <= 0;
									//////////////////////////////////////////
									if (tfcount == 5'h02)
										begin
											faddr <= faddr + 1;
									 		fce <= 0;
											foe <= 0;
										end	
									else if (tfcount == 5'h0b)
										datatmp[15:8] <= fdatai;
									else if (tfcount == 5'h0c)
										begin
									 		fce <= 1;
											foe <= 1;
										end
									else if (tfcount == 5'h12)
										begin
											faddr <= faddr + 1;
									 		fce <= 0;
											foe <= 0;
										end
									else if (tfcount == 5'h1b)
										datatmp[7:0] <= fdatai;
									else if (tfcount == 5'h1c)
										begin
									 		fce <= 1;
											foe <= 1;
										end
									else if ((tfcount == 5'h1d)||(tfcount == 5'h1e)||(tfcount == 5'h1f))
										dataout <= datatmp;	
								end
							else	//VME write to falsh memory -- "AA 55 A0 PA PD"
								//vme write to flash--AA,55,A0,PA,PD
								begin
									//write sequence
									foe <= 1;
									///////////////////////////////////////////////////////
									if ((tfwcount==10'h3fe)||(tfwcount==10'h3ff))
										dtack <= 1;
									else
										dtack <= 0;
									////////////////////////////////////////////////////////
									if (tfwcount == 10'h000)
										begin
											fce <= 1'b1;
											fwe <= 1'b1;
										end
									else if (tfwcount == 10'h001)
										begin
											fdatao <= 8'haa; 					//--------------------"AA"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 10'h010)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h021)
										begin
											fdatao <= 'h55; 					//--------------------"55"
											fce <= 0;
											fwe <= 0;
											faddr <= faddr + 1;
										end
									else if (tfwcount == 10'h030)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h041)
										begin
											fdatao <= 'hA0; 					//--------------------"A0"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 10'h050)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h061)
										begin
											fdatao <= datain[15:8];			//--------------------"PA,PD"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 10'h70)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h381)
										begin
											fdatao <= 'haa; 					//--------------------"AA"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 10'h390)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h3a1)
										begin
											fdatao <= 'h55; 					//--------------------"55"
											fce <= 0;
											fwe <= 0;
											faddr <= faddr + 1;
										end
									else if (tfwcount == 10'h3b0)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 10'h3c1)
										begin
											fdatao <= 'hA0; 					//--------------------"A0"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 10'h3d0)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
									else if (tfwcount == 'h3e1)
										begin
											fdatao <= datain[7:0];			//--------------------"PA,PD"
											fce <= 0;
											fwe <= 0;
										end
									else if (tfwcount == 'h3f0)
										begin
											fce <= 1;
										  	fwe <= 1;
										end
								end //end else
						end
					else if ((addr[3:1]==3'b011)&&(chipen == 1))//config FPGA from VME bus;
					//###################################################################################### Configure FPGA from VME bus
						begin
							////////////////////////////////////////////////////
							prog_b <= (~progpulse);
							////////////////////////////////////////////////////
							// 8,9,10,11,12,13,14,15,0,1,2,3,4,5,6,7 bit in turn;
							////////////////////////////////////////////////////
							//////////////give out dtack signal/////////////////
							if (vmeprgbegin == 1'b0)
								dtack <= lock;			
							else
								begin
									if (init_b == 0)
										begin
											dtack <= lock; 
										end
									else
										begin
											if ((vmecfgcnt == 6'h3e)||(vmecfgcnt == 6'h3f))
												dtack <= 1;
											else
												dtack <= 0;
										end
								end
							////////////////////////
							////////////////////////////////////////////////////
							if (done==0)
								begin
									if (vmeprgbegin == 1'b1)
										begin
											//////////////////////////////////
											if (vmecfgcnt == 7'h1) 
												pdata <= datain[8];
											else if (vmecfgcnt == 7'h4)
												pdata <= datain[9];
											else if (vmecfgcnt == 7'h7)
												pdata <= datain[10];
											else if (vmecfgcnt == 7'ha)
												pdata <= datain[11];
											else if (vmecfgcnt == 7'hd)
												pdata <= datain[12];
											else if (vmecfgcnt == 7'h10)
												pdata <= datain[13];
											else if (vmecfgcnt == 7'h13)
												pdata <= datain[14];
											else if (vmecfgcnt == 7'h16)
												pdata <= datain[15];
											else if (vmecfgcnt == 7'h19)
												pdata <= datain[0];
											else if (vmecfgcnt == 7'h1c)
												pdata <= datain[1];
											else if (vmecfgcnt == 7'h1f)
												pdata <= datain[2];
											else if (vmecfgcnt == 7'h22)
												pdata <= datain[3];
											else if (vmecfgcnt == 7'h25)
												pdata <= datain[4];
											else if (vmecfgcnt == 7'h28)
												pdata <= datain[5];
											else if (vmecfgcnt == 7'h2b)
												pdata <= datain[6];
											else if (vmecfgcnt == 7'h2e)
												pdata <= datain[7];
											//////////////////////////////////
											if ((vmecfgcnt == 7'h2)||(vmecfgcnt == 7'h5)||(vmecfgcnt == 7'h8)||(vmecfgcnt == 7'hb))
												dclk <= 1;
											else if ((vmecfgcnt == 7'he)||(vmecfgcnt == 7'h11)||(vmecfgcnt == 7'h14)||(vmecfgcnt == 7'h17))
												dclk <= 1;
											else if ((vmecfgcnt == 7'h1a)||(vmecfgcnt == 7'h1d)||(vmecfgcnt == 7'h20)||(vmecfgcnt == 7'h23))
												dclk <= 1;
											else if ((vmecfgcnt == 7'h26)||(vmecfgcnt == 7'h29)||(vmecfgcnt == 7'h2c)||(vmecfgcnt == 7'h2f))
												dclk <= 1;
											else
												dclk <= 0;
											//////////////////////////////////
										end
								end
							else
								dclk <= donedly & (~dclk);
						end
					else if ((addr[3:1]==3'b100)&&(chipen == 1))//command of config FPGA from flash memory chip;
					//######################################################################################  Configure FPGA from FlashMemory
						begin
							prog_b <= 1;
							if (cmdcnt == 'b01)
								begin
									f2fen <= datain[0];
									pwrcfgi <= 8'h00;
								end
							else if ((cmdcnt == 'b10)||(cmdcnt == 'b11))
								dtack <= 1;
							else 
								dtack <= 0;
						end
					else if ((addr[3:1]==3'b101)&&(chipen == 1)) 
					//###################################################################################### Write Reload Mask to Register
					// Reload Signal Mask Switch >>> write "0" reload enable "1": reload disable
						begin
							if (cmdcnt == 'b01)
								reloadMASK <= | datain;
							else if ((cmdcnt == 'b10)||(cmdcnt == 'b11))
								dtack <= 1;
							else 
								dtack <= 0;
						end
					else if ((addr[3:1]==3'b110)&&(chipen == 1))
						begin
							if (cmdcnt == 'b01)
								begin
									dataout[0] <= done;
									dataout[1] <= fryby;
									dataout[2] <= DClkBegin;
									dataout[15:3] <= 13'h00;
								end
							else if ((cmdcnt == 'b10)||(cmdcnt == 'b11))
								dtack <= 1;
							else 
								dtack <= 0;
 						end
				end // (pwrok == 1)\(reloadcnt == 4'h0) \(f2fen == 0)..
			else // pwrok == 1\reloadcnt == 4'h0\f2fen == 1 
				begin
					/////////////////////////////////////////////////////
					fwe <= 1;
					freset <= 1;
					if (pwrcfgi < 'hff)
						pwrcfgi <= pwrcfgi + 1;

					//===========================================================
					if ((pwrcfgi == 'hff)&&(init_b == 1)&&(faddr < `ProgramMarkA2))
						cfgicnten <= 1'b1;
					else if (faddr >= `ProgramMarkA2)
						cfgicnten <= 1'b0;
					
					if ((cfgicnten == 1'b1)&&(cfgi == 6'h00))
						cfgi <= 6'h01;
					else if ((cfgi > 6'h00)&&(cfgi < 6'h3f))
						cfgi <= cfgi + 1;
					else if (cfgi == 6'h3f)
						cfgi <= 6'h00;

					/////////////////////////////////////////////////////
					if (beginprg == 1)
						begin
							if ((pwrcfgi > 'h40)&&(pwrcfgi < 'h80))
								prog_b <= 0;
							else
								prog_b <= 1;
						end
					else
						prog_b <= 1;
					/////////////////////////////////////////////////////
					if(pwrcfgi == 8'h01)
						begin
							faddr <= `ProgramMarkA2; //'h244802;	 //1d9600
							fce <= 0;
							foe <= 0;
						end
					else if(pwrcfgi == 8'h10)
						chkreg <= fdatai;
					else if(pwrcfgi == 8'h11)
						begin
							fce <= 1;
							foe <= 1;
						end
					else if(pwrcfgi == 8'h30) // if Flash has prged then set eginprg = 1;
						begin
							if(chkreg == 8'h1b)
								begin
									beginprg <= 1;
									dtack <= 1;
								end
							else
								begin
									beginprg <= 0;
									f2fen <= 0;
								end
						end
					else if((pwrcfgi == 'hff)&&(init_b == 0)&&(DClkBegin == 1'b0))
						faddr <= `StartAddr;
					else if((pwrcfgi == 'hff)&&(init_b == 0)&&(DClkBegin == 1'b1))
					//=====================================================================================
					//all cfg data been fed to fpga, but 'done' pin is not go to high, and init_b go to low
					//=====================================================================================
						begin
							dtack <= 1'b0;
							f2fen <= 0;
						end
					else if((pwrcfgi == 'hff)&&(init_b == 1)&&(init_b_conct == 1'b0)) //init_b signal is not connect
						begin
							dtack <= 1'b0;
							f2fen <= 0;
						end
					else if((pwrcfgi == 'hff)&&(init_b == 1)&&(init_b_conct == 1'b1)) 
						/////////////////////////////////////////////////////////////'hff	
						begin
							if ((beginprg == 1)&&(faddr < `ProgramMarkA2)) //1d9602								
								begin
									if ((faddr > `ProgramMarkA0)||(done == 1))		//1d9600
										begin
											f2fen <= 0;
											dtack <= 0;
										end
									/////////////////////////////////////
									if ((cfgi == 8'h16)||(cfgi == 8'h17)||(cfgi == 8'h1a)||(cfgi == 8'h1b)||
										 (cfgi == 8'h1e)||(cfgi == 8'h1f)||(cfgi == 8'h22)||(cfgi == 8'h23)||
										 (cfgi == 8'h26)||(cfgi == 8'h27)||(cfgi == 8'h2a)||(cfgi == 8'h2b)||
										 (cfgi == 8'h2e)||(cfgi == 8'h2f)||(cfgi == 8'h32)||(cfgi == 8'h33))
										dclk <= 1;
									else 
										dclk <= 0;
									//////////////////////////////////////////////////////
									if (cfgi == 6'h00)
										begin
											fce <= 1;
											foe <= 1;
										end
									else if (cfgi == 6'h01)
										begin
											fce <= 0;
											foe <= 0;
										end
									else if (cfgi == 6'h09)
										fdataitmp <= fdatai;
									else if (cfgi == 6'h10)
										begin
											fce <= 1;
											foe <= 1;
										end
									//////////////////////////////////////--------0
									else if (cfgi == 6'h14)
										pdata <= fdataitmp[0];//fdatai;
									//////////////////////////////////////--------1
									else if (cfgi == 6'h18)
										pdata <= fdataitmp[1];//(fdatai>>1);
									//////////////////////////////////////--------2
									else if (cfgi == 6'h1c)
										pdata <= fdataitmp[2];//(fdatai>>2);
									//////////////////////////////////////--------3
									else if (cfgi == 6'h20)
										pdata <= fdataitmp[3];//(fdatai>>3);
									//////////////////////////////////////--------4
									else if (cfgi == 6'h24)
										pdata <= fdataitmp[4];//(fdatai>>4);
									//////////////////////////////////////--------5
									else if (cfgi == 6'h28)
										pdata <= fdataitmp[5];//(fdatai>>5);
									//////////////////////////////////////--------6
									else if (cfgi == 6'h2c)
										pdata <= fdataitmp[6];//(fdatai>>6);
									//////////////////////////////////////--------7
									else if (cfgi == 6'h30)
										pdata <= fdataitmp[7];//(fdatai>>7);
									///////////////////////////////////////////////
									else if (cfgi == 6'h3f)
										begin
											faddr <= faddr + 1;
										end
								end	
						end
				end 
		end  
end
endmodule
