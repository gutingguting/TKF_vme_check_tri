`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Create Date:    14:26:09 12/06/06
////////////////////////////////////////////////////////////////////////////////

module DAQ_top(gclkp,gclkp2,d_320in,ADDR,GA,DS,WRITE,AS,SYSRESET,
           IACK,IACKIN,BERRIN,
//			  SL1P,SL1N,SL2P,SL2N,
			  L1,CHK,RST,CRSV,	
			  DTACK2,BERROUT,IACKOUT,
			  FULL,RERR,SRSV,SPARE2,oe245out,
			  FPGA_EN,CBLT_EN,MCST_EN,DATA
			  ,ONE_EVENT_AMOUNT,ALL_EVENT_AMOUNT
			  ,CSR1,CSR2,ONCERDNUM,WINDOW,CENTER_LATENCY,PROGFULL,PROGFULL_DIS,CMD_RST,CMD_CLR
			  ,RUN_MODE,LTK,STK,TSF
			  ,N7v,N8v,CHECKex
			  ,CBLT_LED
);
			  
			input gclkp,gclkp2,DS,WRITE,AS,SYSRESET,IACK,IACKIN,BERRIN;
			input L1,CHK,RST,CRSV;
			input	FPGA_EN,CBLT_EN,MCST_EN;
			input [4:0]	GA;
			input [7:0] ADDR;
			input [319:0] d_320in; 
			input  [7:0] CSR1;
			input  [3:0] ONCERDNUM;
			input  [3:0] WINDOW;
			input  [7:0] CENTER_LATENCY;
			input  [3:0] PROGFULL;
			input  [3:0] PROGFULL_DIS;
			input   CMD_RST;
			input   CMD_CLR;

			input [31:0] RUN_MODE;
			input [15:0] LTK;
			input [15:0] STK;
			input [63:0] TSF;

			input [3:0] N7v,N8v;

			output [7:0]  CSR2;
			output [7:0]  ONE_EVENT_AMOUNT;
			output [12:0] ALL_EVENT_AMOUNT;


			output DTACK2,BERROUT,IACKOUT,FULL,RERR,SRSV,SPARE2,oe245out;

			inout [31:0] DATA;

			output CHECKex;
			output CBLT_LED;

reg  DTACK2,RERR,SRSV,SPARE2,oe245;
reg  [2:0] EN_F_C;
//reg fpgaen=0;

reg[3:0]	linecout;

wire s1,entc1,entc2;

reg s2;

wire gclk,SL1,SL2;
wire [31:0] DATA1;
wire [31:0] DATA2;
reg  [31:0] DATA3;
wire [3:0] DATA4;
reg [3:0] DATA5;
reg [31:0] DATA6;

reg [31:0] DATATr;
wire [31:0] DATAv;
wire [15:0] DATAw1,DATAw2,DATAw3;
reg t;

wire enram4w;
wire [7:0] addram;
wire ens;


reg liner,linew,ram4r,ram4w,readdr,wraddr;

wire scblt,smcst,scblt2,scblt3;
reg purge,s4,s5;
wire s8,s9;
reg [7:0] CSR2=8'b0;
reg [10:0] addrc;
reg [3:0] cbltcout,mcstcout;
//&&&&&&&&&&&&&&
reg [3:0] CSR2cout, csr3cout;
//&&&&&&&&&&&&&&
reg [13:0] addrline2;
reg [13:0] addrcbltnum,recbltnum;
wire [3:0] selevent;

wire reset,clearL1;

//reg [6:0]N1x=4;
//reg [7:0] N2x=14;
//reg [8:0] N3x=70;
reg [6:0]N1x;
wire [7:0] N2x;
reg [9:0] N3x;
wire [3:0] N3v;
reg  [3:0] N3b;

reg ibout=0;
wire 	IACKOUT ;
reg BERROUT,IACKOUTc,IACKOUTm,IACKOUTcx;


wire testL;
reg [7:0] fifoadd,addfifoin ;

wire [3:0]outx,exoutx;

wire L1a,SYSRESETx,RSTx,CHECKa;

reg L1b;
reg CHECKb;
reg [2:0] countL1b,countCHECKb;

reg tdbegin=0;
wire tdbegin_t;
reg[11:0] countexpL1;
reg expL1;

//reg [13:0] N4x=11200;
reg [13:0] N4x;

wire [3:0] N4v;


reg cyclex=0;
//reg [14:0] N5x=512;
reg [14:0] N5x;
wire [3:0] N5v;
//reg [10:0] N6x=200;
reg [10:0] N6x;
wire [3:0] N6v;

reg [1:0] resetflag;
reg resetx;
reg [1:0] clearL1flag;
reg clearL1x;
wire clr;
assign clr=reset|clearL1;
//assign clr=1'b0;

reg[11:0] countCHECKex;
//reg[7:0] countCHECKex;
reg CHECKex;
reg purgex;
reg [1:0] countpurgex;

reg regL1;
wire regL1x;

reg [11:0] NL1CH=0;
//reg [7:0] NL1CH=0;

reg regclk;

wire emptyx;

reg fnem;
wire ROT;
wire [7:0] DATA_MODE;

wire FULL_RAM;
assign FULL = CSR1[0]?FULL_RAM:0;

//delay fifo
reg [7:0] addra_delay,addrb_delay;
wire [319:0] d_320in_delay;
wire [15:0] LTK_delay;
wire [15:0] STK_delay;
wire [63:0] TSF_delay;
wire [7:0] ADDR_DELAY;
assign ADDR_DELAY = CENTER_LATENCY-16;
wire [95:0] float96;
//delay fifo

assign gclk=gclkp;
assign ONE_EVENT_AMOUNT=N3x[7:0];
assign ALL_EVENT_AMOUNT=recbltnum[12:0];
//assign N2x= CENTER_LATENCY;
assign N2x= CENTER_LATENCY-ADDR_DELAY;
assign N3v= WINDOW;
assign N4v= PROGFULL;
assign N6v= PROGFULL_DIS;
assign selevent = ONCERDNUM;
assign s8=CMD_CLR;
assign s9=CMD_RST;
assign ROT = RUN_MODE[0];
assign DATA_MODE = RUN_MODE[15:8];

BUF setbuffer( .O(reset),
              .I(resetx));
BUF clrbuffer( .O(clearL1),
              .I(clearL1x));

//INV L1in(.O(L1a),
//         .I(L1)
//			);
assign L1a = L1;
// The L1 signal is inverse in L1_gen logic.

INV SYSRESETin(.O(SYSRESETx),
         .I(SYSRESET)
			);
//INV RSTin(.O(RSTx),
//         .I(RST)
//			);
//INV TSYNCin(.O(TSYNCa),
//         .I(TSYNC)
//			);

assign CHECKa = ~CHK;
assign RSTx = RST;

assign DATAw1 = DATA[15:0];
assign DATAw2 = DATA[31:16];

assign DATA = (t==0)?DATATr:32'hzzzzzzzz;


reg [27:0] countL1=0;
reg Lx=0;
reg [7:0] addr1btop=0,addrr1top=0;

//assign gclk=(regclk==1)?gclkp:clkcpld;

always @ (posedge  gclk )
  begin
     
	   RERR<=1'b0;
		SRSV<=1'b0;
		SPARE2<=1'b0;
  end

always @ (posedge gclk)
    begin
	   if(clr)
		  begin
		    countL1b<=0;	
			 L1b<=0;
		  end
     
		else
		  begin
	       if((L1a==1)&&(countL1b==0))
		         begin 
					    countL1b<=1; 
					end
			 else if((countL1b==1)&&(L1a==1)) countL1b<=2;
			 else if((countL1b==2)&&(L1a==1)) countL1b<=3;
			 else if((countL1b==3)&&(L1a==1)) begin  L1b<=1;	countL1b<=4;  end
			 else if(L1a==0)	begin L1b<=0; countL1b<=0; end
			end 
		end			

always @ (posedge gclk)		  //test the  width of	check	,when it's wider than 100ns,then set CHECKb=1
    begin
	   if(clr)
		  begin
		    countCHECKb<=0;	
			 CHECKb<=0;
		  end
		
		else
		  begin
	       if((CHECKa==1)&&(countCHECKb==0))
		         begin 
					    countCHECKb<=1; 
					end
			 else if((countCHECKb==1)&&(CHECKa==1)) countCHECKb<=2;
			 else if((countCHECKb==2)&&(CHECKa==1)) countCHECKb<=3;
			 else if((countCHECKb==3)&&(CHECKa==1)) begin  CHECKb<=1;	countCHECKb<=4;  end
			 else if(CHECKa==0)	begin CHECKb<=0; countCHECKb<=0; end
			end 
		end
					
//always @ (posedge gclk)
always @ (posedge gclkp2)
    begin
	   if(clr)
		  begin
		    countexpL1<=0;	
			 expL1<=0;
		  end
	
		else
		  begin
	       if((L1b==1)&&(countexpL1==12'b0))
		         begin 
					    countexpL1<=1; 
						 expL1<=1;
						 
					end
		    else if((countexpL1>0)&&(countexpL1<NL1CH))
		            countexpL1<=countexpL1+1;
	     	 else if(countexpL1==NL1CH)
			      begin
					   expL1<=0;
		           countexpL1<=countexpL1+1;
					 end
			
		    else if(L1b==0) 
		       begin 
			      countexpL1<=12'b0;	
			      //expL1<=0;
					
			    end
		  end  
	 end	

//
always @ (posedge gclkp2)
    begin
	   if(clr)
		  begin
		    countCHECKex<=0;	
			 CHECKex<=0;
		  end
	
		else
		  begin
	       if((CHECKb==1)&&(countCHECKex==8'b00000000))
		         begin 
					    countCHECKex<=1; 
						 CHECKex<=1;
						 
					end
		    else if((countCHECKex>0)&&(countCHECKex<NL1CH))
		            countCHECKex<=countCHECKex+1;
	     	 else if(countCHECKex==NL1CH)
			      begin
					   CHECKex<=0;
		           countCHECKex<=countCHECKex+1;
					 end
			
		    else if(CHECKb==0)
		       begin 
			      countCHECKex<=0;	
			     // CHECKex<=0;
					
			    end
		  end  
	 end	
//
// Mod. by xuhao
//assign  regL1x=(regL1==1)?testL:expL1;
assign  regL1x= expL1;

// onlinedata module

always@(posedge gclk)
begin
	if(clr)
		begin
			addra_delay <= ADDR_DELAY;
			addrb_delay <= 0;
		end
	else
		begin
			addra_delay <= addra_delay + 1;
			addrb_delay <= addrb_delay + 1;
		end			
end

// ram_256_256 ram_256_256_delay1(  
//  	   .addra(addra_delay),
// 		.addrb(addrb_delay),
// 		.clka(gclk),
// 		.clkb(gclk),
// 		.dina(d_320in[255:0]),
// 		.doutb(d_320in_delay[255:0]),
// 		.enb(1'b1),
// 		.wea(1'b1)
// 		);
ram_256_256_1 ram_256_256_delay1 (
  .clka(gclk),    // input wire clka
  .wea(1'b1),      // input wire [0 : 0] wea
  .addra(addra_delay),  // input wire [7 : 0] addra
  .dina(d_320in[255:0]),    // input wire [255 : 0] dina
  .douta(),  // output wire [255 : 0] douta
  .clkb(gclk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .web(),      // input wire [0 : 0] web
  .addrb(addrb_delay),  // input wire [7 : 0] addrb
  .dinb(),    // input wire [255 : 0] dinb
  .doutb(d_320in_delay[255:0])  // output wire [255 : 0] doutb
);

// ram_256_256_1 ram_256_256_delay2(  
//  	   .addra(addra_delay),
// 		.addrb(addrb_delay),
// 		.clka(gclk),
// 		.clkb(gclk),
// 		.dina({96'b0,LTK[15:0],STK[15:0],TSF[63:0],d_320in[319:256]}),
// 		.doutb({float96[95:0],LTK_delay[15:0],STK_delay[15:0],TSF_delay[63:0],d_320in_delay[319:256]}),
// 		.enb(1'b1),
// 		.wea(1'b1)
// 		);
ram_256_256_1 ram_256_256_delay2 (
  .clka(gclk),    // input wire clka
  .wea(1'b1),      // input wire [0 : 0] wea
  .addra(addra_delay),  // input wire [7 : 0] addra
  .dina({96'b0,LTK[15:0],STK[15:0],TSF[63:0],d_320in[319:256]}),    // input wire [255 : 0] dina
  .douta(),  // output wire [255 : 0] douta
  .clkb(gclk),    // input wire clkb
  .enb(1'b1),      // input wire enb
  .web(),      // input wire [0 : 0] web
  .addrb(addrb_delay),  // input wire [7 : 0] addrb
  .dinb(),    // input wire [255 : 0] dinb
  .doutb({float96[95:0],LTK_delay[15:0],STK_delay[15:0],TSF_delay[63:0],d_320in_delay[319:256]})  // output wire [255 : 0] doutb
);

onlinedataram aconlinedataram (
                      .clk1a(gclk),
							 .clk1b(gclkp2),
//							 .clk1b(gclk),
							 .clk2b(gclk),
							 .GAV(GA),
							 .L1(regL1x),
							//&&&&&&&&&&&&&&&
							//  .scbltx(scblt),
							//  .fnemx(fnem),
							 .DSx(DS),
							//&&&&&&&&&&&&&&&
							 .ASx(AS),
							 .reset(reset),
							 .N3(N3x),
							 .N3c(N3b),
							 .N4(N4x),
							 .N6(N6x),
							 .N7(N7v),
							 .N8(N8v),
							 .rot(ROT),
							 .DATA_MODE(DATA_MODE),
							 .ltk(LTK_delay),
							 .stk(STK_delay),
							 .tsf(TSF_delay),
							 .FULLx(FULL_RAM),
							 .empty(emptyx),
							 .berrinx(BERRIN),
							 .s5x(s5),
							 .we1a(1'b1),							 
							 .en2b(liner),
						//	 .enramw(enram4w),
							 .CHECKx(CHECKex),
							 .clearL1(clearL1),							
							 .addr1bx(fifoadd[7:0]),
						//	 .addrr1x(addram[7:0]),
							 .addr2b(addrline2),
							 .dina(d_320in_delay),
						//	 .datacounter(exoutx),
							 .din_31(DATA6[31:0]),
							 .dout2b(DATA1[31:0]));


always@(posedge gclk or posedge clr)
  begin 
   if(clr==1)
	    begin
		  fifoadd<=0;
		  addfifoin<=0;
		 end
	else
	  begin
		if (addfifoin!=255)addfifoin<=addfifoin+1;
		if(addfifoin==255) addfifoin<=0;
		if(addfifoin>=N2x) fifoadd<=addfifoin-N2x;  //creat  address of  reading fifo 
		else 	 fifoadd<=addfifoin+(256-N2x);

     //fifoadd=addfifoin-N2x;
	  end

  end

always @ (posedge gclk or posedge clr)
   begin 
	  if(clr==1) CSR2[1]<=0;
	  else 	CSR2[1]<=emptyx;
    
	end

//Mod by xuhao, Dec.14

//CBLT,MCST counter
always @ (negedge gclk or posedge clr )
begin
  if(clr==1)
    begin
	     cbltcout<=0;
	     mcstcout<=0;
	 end
  else
	begin 
	     // cblt
		if(scblt&&(CSR1[1]==1)&&( CSR2[0]==0)&&(DS==1))
		  begin
	       if(cbltcout==0)
		        cbltcout<=4'b1;
		    else if(cbltcout<4'b1111)
		        cbltcout<=cbltcout+1;
		    else 
		        cbltcout<=0;
		  end

	     // mcst
		else if(smcst&&(CSR1[7]==1)&&(DS==1))
		  begin
	       if(mcstcout==0)
		        mcstcout<=4'b1;
		    else if(mcstcout<4'b1111)
		        mcstcout<=mcstcout+1;
		    else 
		        mcstcout<=0;
		  end
		else 
		  begin
	        cbltcout<=0;
		     mcstcout<=0;
		  end
	end		 
end

//VME read/write logic
always @ (negedge gclk or posedge clr )
begin
	if(clr==1)
	    begin
			   t<=1;
			   s2<=1;
			   s4<=1;	
				s5<=1; 
				liner<=0;
				linew<=0;
				ram4r<=0;
			   ram4w<=0;
				readdr<=0;
				wraddr<=0;
				DTACK2<=0;
				oe245<=1;
				IACKOUTc<=1;
				IACKOUTm<=1;
		   	DATATr[31:0]<=0;
				DATA3[31:0]<=0;
		    	DATA5[3:0]<=0; 
         	DATA6[31:0]<=0;
				addrline2<=0;
				addrcbltnum<=0;
				CSR2[2]<=0;
				CSR2[0]<=0;	
				fnem<=0;
		 end
	else
		begin 
          if((CSR2[1]==1)&&(scblt==1)&&(CSR1[1]==1)&&(CSR2[0]==0))					
				begin
				   if(CSR1[3]==0)
						begin
					   	CSR2[2]<=1;
					   	CSR2[0]<=1; 
						end
					else if(DS==1)
						begin
					     if(cbltcout>4'b0011)
		                 begin oe245<=0;end	
						  if((WRITE==1)&&(cbltcout<4'b0110)&&(cbltcout>4'b0000))    
	                    begin
		                    DATATr[31:0]<=32'hffffffff;
		  	                 t<=0;
		                 end
						  if(cbltcout<4'b0110)
	                    begin  DTACK2<=0;  end
						  else if(cbltcout==4'b0110)
	                   	begin
								   s4<=0;
		                     DTACK2<=1;
									CSR2[2]<=1;
		                     CSR2[0]<=1;	   
								end
						end	 
				end

		 // cblt  cycle of reading the datum in the global ram
			else if((scblt==1)&&(DS==1)&&(CSR2[1]==0))
				begin
				    if((CSR1[3]==0)&&(CSR1[1]==1)&&(CSR2[0]==0))
				      begin
					     if(addrcbltnum<recbltnum)
					       begin
							   if(cbltcout>4'b0011)
							       begin  oe245<=0;		end
						      if((WRITE==1)&&(cbltcout<4'b0110)&&(cbltcout>4'b0000))    
							      begin
									  liner<=1;
								     DATATr[31:0]<=DATA1[31:0];
								  	  t<=0;
								   end
							   if(cbltcout<4'b0110)
							      begin  DTACK2<=0;  end
								else if(cbltcout==4'b0110)
							      begin
										s4<=0;
							    		DTACK2<=1;
										addrline2<=addrline2+1;
										addrcbltnum<=addrcbltnum+1;
										liner<=0;
//								  	   t<=1;	   
								 	end
						 
							 end
						 else if(addrcbltnum==recbltnum)
							 begin
								 fnem<=1;
								 if(cbltcout>4'b0011)
							         begin  oe245<=0;		end	
							    if((WRITE==1)&&(cbltcout<4'b0110)&&(cbltcout>4'b0000))    
							         begin
   							         liner<=1;
											DATATr[31:0]<=DATA1[31:0];
											t<=0;
								      end
								 if(cbltcout<4'b0110)
							         begin  DTACK2<=0;  end
							    else if(cbltcout==4'b0110)
							         begin
											  s4<=0;
							    	        DTACK2<=1;
									        addrline2<=addrline2+1;
									        addrcbltnum<=addrcbltnum+1;
									        liner<=0;
//								  	        t<=1;	 
  									        CSR2[2]<=1;
										     CSR2[0]<=1;
								 	   end
							end
					  end

			  else if((CSR1[3]==1)&&(CSR1[1]==1)&&(CSR2[0]==0))
				   begin
						  if(addrcbltnum==(recbltnum-1))  fnem<=1;
					     if(addrcbltnum<recbltnum)
					        begin
							      if(cbltcout>4'b0011)
							            begin  oe245<=0;		end		
						         if((WRITE==1)&&(cbltcout<4'b0110)&&(cbltcout>4'b0000))    
							           begin
									          liner<=1;
								             DATATr[31:0]<=DATA1[31:0];
								  	          t<=0;
								        end
					 
					 			 					  
							      if(cbltcout<4'b0110)
							           begin  DTACK2<=0;  end
							      else if(cbltcout==4'b0110)
							           begin
									          s4<=0;
							    	          DTACK2<=1;
										       addrline2<=addrline2+1;
										       addrcbltnum<=addrcbltnum+1;
									        	 liner<=0;
//								  	          t<=1;	   
								 	     end
						 
							   end

							else  if(addrcbltnum==recbltnum)
								  begin
							     	   addrcbltnum<=addrcbltnum+1;
								   end
				         else  if(addrcbltnum==(recbltnum+1))
						               begin	
												 if(cbltcout>4'b0011)
							                        begin  oe245<=0;		end	
							                if((WRITE==1)&&(cbltcout<4'b0110)&&(cbltcout>4'b0000))    
							                    begin
								                    DATATr[31:0]<=32'hffffffff;
								  	                  t<=0;
								                 end
							                 if(cbltcout<4'b0110)
							                    begin  DTACK2<=0;  end
							                 else if(cbltcout==4'b0110)
							                    begin
																   s4<=0;
							    	                      	DTACK2<=1;
										                     addrcbltnum<=addrcbltnum+1;
//								  	                        t<=1;
																	CSR2[2]<=1;
										                     CSR2[0]<=1;	   
								 	              end
						               end 
				       end   
			    end
		  //MCST	 cycle
		   else if((smcst==1)&&(DS==1))
			  	 begin 
				    if(CSR1[7]==1)
					     begin
							  CSR2[4]<=1;
						     if((WRITE==0)&&(mcstcout<4'b0110)&&(mcstcout>4'b0000))    
							      begin
										CSR2[5]<=0;	
										CSR2[2]<=0;
									  	CSR2[0]<=0;
										addrcbltnum<=0;
								   end
							  if(mcstcout<4'b0110)
									begin   DTACK2<=0; end
							  else  if(mcstcout==4'b0110)
								   begin 
									    CSR2[3]<=1;
									    s5<=0;
										 if(CSR1[3]==1) begin  DTACK2<=1'b1;	end
										 else   begin  DTACK2<=1'b0;  end
									end
							end
				    else if((CSR1[7]==0)&&(CSR2[4]==0))
				      begin
				 		 if(CSR1[3]==1)
					   	begin
						      DTACK2<=1'b1;
							end
					    else  
					      begin
						     DTACK2<=1'b0;
						   end
						   s5<=0;
						end
				 end
	else 
		begin
		    if(!DS) begin t<=1;  DTACK2<=0; oe245<=1;end
			 s4<=1;
			 s5<=1; 
			 s2<=1;
			liner<=0;
			linew<=0;
			ram4r<=0;
		   ram4w<=0;
			readdr<=0;
			wraddr<=0;
			CSR2[4]<=0;
			if(BERRIN==0) begin	CSR2[5]<=1; fnem<=0; end
			CSR2[3]<=0;
		end
	end	// end cblt,mcst,a24/d32	  
end // end process


//wire rst_berr;
//wire b_dl;
//reg b_dl1,b_dl2,b_dl3,b_dl4;
//wire berrin_ds = !BERRIN && DS;
//assign rst_berr= reset| AS | DS | b_dl;
//always@(posedge gclk)
//begin
//  b_dl1 <= berrin_ds;
//  b_dl2 <= b_dl1;
//  b_dl3 <= b_dl2;
//  b_dl4 <= b_dl3; 
//end
//
//assign b_dl = b_dl4;

//always @ (  posedge gclk)
//  begin 
//     if(reset==1)
//	    begin 
//		    CSR2[6]<=1;
//		 end
//	  else if( BERROUT==1)
//	     begin
//			  CSR2[6]<=0;
//		  end
//	  else 
//		  CSR2[6]<=1;
//  end
//
wire ds_inv1; 
assign ds_inv1 = !DS;

reg [1:0] cs_berr;
reg berr_stup,berr_sync;
reg ds_dl;
always@(posedge gclk)
begin
  if(ds_inv1)
    ds_dl <= 1'b0;
  else
    ds_dl <= CSR1[5]? DS:(DS&&(~IACKIN));
end
always @ (posedge reset or posedge ds_dl or posedge ds_inv1)
  begin 
     if(reset)
	    begin    berr_stup<=0;  end
     else if(ds_inv1)
	    begin 	 berr_stup<=0;  end
	  else if((scblt3==1)&&(scblt==1)&&(CSR1[3]==1))
	     begin	 berr_stup<=1;  end
  end
always @(posedge gclk)
	berr_sync <= berr_stup;

always@(posedge gclk or posedge reset)
begin
  if(reset)
    begin
	   cs_berr <= 2'b0;
		BERROUT <= 0;
	 end
  else
    begin
	   case(cs_berr)
		    2'b00: 
			   begin
			     if(berr_sync)
				    begin cs_berr <= 2'b01; end
              else
				    begin cs_berr <= 2'b0; BERROUT <= 0;end
				end
			 2'b01:
			   begin
				  cs_berr <= 2'b10;
				end
			 2'b10:
			   begin
				  if(!berr_sync) cs_berr<=2'b11;
				  else
				    begin 
					   cs_berr <= 2'b10;
				      BERROUT <= 1'b1;
                end
				end
			 2'b11:
			   begin
				  	   cs_berr <= 2'b0;
				      BERROUT <= 1'b0;
            end
        default:
		      begin
				  cs_berr <= 2'b0;
				  BERROUT <= 0;
				end  
	  endcase
	end
end       

	     
//always @ (negedge s6 or posedge reset )
//  begin
//    if(reset==1)
//	   begin
//		 N3x <=70 ;
//		 recbltnum<=0;
//		 end
//	  else 
//	    begin
//		   case(N3v[3:0])
//			  4'B0000: begin N3x <=14 ;N3b <=0 ; recbltnum <=15*(selevent[3:0]+1)-1+CSR1[3]; end
//			  4'B0001:  begin N3x <=42 ;N3b <=1 ;recbltnum <=43*(selevent[3:0]+1)-1+CSR1[3];	end
//			  4'B0010: begin N3x <=70 ;N3b <=2 ;recbltnum <=71*(selevent[3:0]+1)-1+CSR1[3];	end
//			  4'B0011: begin N3x <=98 ;N3b <=3 ;recbltnum <=99*(selevent[3:0]+1)-1+CSR1[3];	end
//			  4'B0100: begin N3x <=126 ;N3b <=4 ;recbltnum <=127*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B0101: begin N3x <=154 ;N3b <=5 ;recbltnum <=155*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B0110: begin N3x <=182 ;N3b <=6 ;recbltnum <=183*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B0111: begin N3x <=210 ;N3b <=7 ;recbltnum <=211*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B1000: begin N3x <=238 ;N3b <=8 ;recbltnum <=239*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B1001: begin N3x <=266 ;N3b <=9 ;recbltnum <=267*(selevent[3:0]+1)-1+CSR1[3];end
//			  4'B1010: begin N3x <=294 ;N3b <=10 ;recbltnum <=295*(selevent[3:0]+1)-1+CSR1[3];end
//			  
//			  default:begin 	N3x <=70 ;N3b <=2 ; recbltnum <=71*(selevent[3:0]+1)-1+CSR1[3];  end
//			 endcase
//		  end
//	 end	

always @ (N3v or reset or selevent or CSR1 or ROT )
begin
	if(reset)
		begin
		 N3x <=0 ;
		 N3b <=0	;
		 recbltnum<=0;
		NL1CH<=0;	
		end
	else 
	  begin
	    if(ROT)
		   begin
			 case(N3v[3:0])
			  /*4'B0000: begin N3x <=19 ;N3b <=0 ; NL1CH<=15;recbltnum <=20*(selevent[3:0]+1)-1+CSR1[3]; end
			  4'B0001: begin N3x <=57 ;N3b <=1 ;NL1CH<=30;recbltnum <=58*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0010: begin N3x <=95 ;N3b <=2 ;NL1CH<=55;recbltnum <=96*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0011: begin N3x <=133 ;N3b <=3 ;NL1CH<=70;recbltnum <=134*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0100: begin N3x <=171 ;N3b <=4 ;NL1CH<=90;recbltnum <=172*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0101: begin N3x <=209 ;N3b <=5 ;NL1CH<=110;recbltnum <=210*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0110: begin N3x <=247 ;N3b <=6 ;NL1CH<=130;recbltnum <=248*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0111: begin N3x <=285 ;N3b <=7 ;NL1CH<=145;recbltnum <=286*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1000: begin N3x <=323 ;N3b <=8 ;NL1CH<=165;recbltnum <=324*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1001: begin N3x <=361 ;N3b <=9 ;NL1CH<=185;recbltnum <=362*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1010: begin N3x <=399 ;N3b <=10 ;NL1CH<=200;recbltnum <=400*(selevent[3:0]+1)-1+CSR1[3];end
			  
			  default:begin 	N3x <=95 ;N3b <=2 ; NL1CH<=55;recbltnum <=96*(selevent[3:0]+1)-1+CSR1[3];  end
			 */ 4'B0000: begin N3x <=19 ;N3b <=0 ; NL1CH<=22;recbltnum <=21*(selevent[3:0]+1)-1+CSR1[3]; end
			  4'B0001: begin N3x <=57 ;N3b <=1 ;NL1CH<=60;recbltnum <=59*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0010: begin N3x <=95 ;N3b <=2 ;NL1CH<=100;recbltnum <=97*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0011: begin N3x <=133 ;N3b <=3 ;NL1CH<=140;recbltnum <=135*(selevent[3:0]+1)-1+CSR1[3];	end
			  4'B0100: begin N3x <=171 ;N3b <=4 ;NL1CH<=175;recbltnum <=173*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0101: begin N3x <=209 ;N3b <=5 ;NL1CH<=215;recbltnum <=211*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0110: begin N3x <=247 ;N3b <=6 ;NL1CH<=250;recbltnum <=249*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B0111: begin N3x <=285 ;N3b <=7 ;NL1CH<=290;recbltnum <=287*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1000: begin N3x <=323 ;N3b <=8 ;NL1CH<=330;recbltnum <=325*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1001: begin N3x <=361 ;N3b <=9 ;NL1CH<=365;recbltnum <=363*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1010: begin N3x <=399 ;N3b <=10 ;NL1CH<=405;recbltnum <=401*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1011: begin N3x <=437 ;N3b <=11 ;NL1CH<=440;recbltnum <=439*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1100: begin N3x <=475 ;N3b <=12 ;NL1CH<=480;recbltnum <=477*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1101: begin N3x <=513 ;N3b <=13 ;NL1CH<=520;recbltnum <=515*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1110: begin N3x <=551 ;N3b <=14 ;NL1CH<=555;recbltnum <=553*(selevent[3:0]+1)-1+CSR1[3];end
			  4'B1111: begin N3x <=589 ;N3b <=15 ;NL1CH<=595;recbltnum <=591*(selevent[3:0]+1)-1+CSR1[3];end
			  
			  default:begin 	N3x <=95 ;N3b <=2 ; NL1CH<=100;recbltnum <=97*(selevent[3:0]+1)-1+CSR1[3];  end
			 endcase
		   end
	     else if(!ROT)
	         begin
				   case(N3v[3:0])
				  	/*	4'B0000: begin N3x <=3 ;N3b <=0 ;NL1CH<=3; recbltnum <=4*(selevent[3:0]+1)-1+CSR1[3]; end
				  		4'B0001: begin N3x <=9 ;N3b <=1 ;NL1CH<=6;recbltnum <=10*(selevent[3:0]+1)-1+CSR1[3];	end
				  		4'B0010: begin N3x <=15 ;N3b <=2 ;NL1CH<=9;recbltnum <=16*(selevent[3:0]+1)-1+CSR1[3];	end
						4'B0011: begin N3x <=21 ;N3b <=3 ;NL1CH<=12;recbltnum <=22*(selevent[3:0]+1)-1+CSR1[3];	end
						4'B0100: begin N3x <=27 ;N3b <=4 ;NL1CH<=15;recbltnum <=28*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0101: begin N3x <=33 ;N3b <=5 ;NL1CH<=18;recbltnum <=34*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0110: begin N3x <=39 ;N3b <=6 ;NL1CH<=21;recbltnum <=40*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0111: begin N3x <=45 ;N3b <=7 ;NL1CH<=24;recbltnum <=46*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1000: begin N3x <=51 ;N3b <=8 ;NL1CH<=27;recbltnum <=52*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1001: begin N3x <=57 ;N3b <=9 ;NL1CH<=30;recbltnum <=58*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1010: begin N3x <=63 ;N3b <=10 ;NL1CH<=33;recbltnum <=64*(selevent[3:0]+1)-1+CSR1[3];end
			  
			   		default:begin 	N3x <=15 ;N3b <=2 ;NL1CH<=9; recbltnum <=16*(selevent[3:0]+1)-1+CSR1[3];  end
			 		*/	4'B0000: begin N3x <=3 ;N3b <=0 ;NL1CH<=6; recbltnum <=5*(selevent[3:0]+1)-1+CSR1[3]; end
				  		4'B0001: begin N3x <=9 ;N3b <=1 ;NL1CH<=12;recbltnum <=11*(selevent[3:0]+1)-1+CSR1[3];	end
				  		4'B0010: begin N3x <=15 ;N3b <=2 ;NL1CH<=18;recbltnum <=17*(selevent[3:0]+1)-1+CSR1[3];	end
						4'B0011: begin N3x <=21 ;N3b <=3 ;NL1CH<=24;recbltnum <=23*(selevent[3:0]+1)-1+CSR1[3];	end
						4'B0100: begin N3x <=27 ;N3b <=4 ;NL1CH<=30;recbltnum <=29*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0101: begin N3x <=33 ;N3b <=5 ;NL1CH<=36;recbltnum <=35*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0110: begin N3x <=39 ;N3b <=6 ;NL1CH<=42;recbltnum <=41*(selevent[3:0]+1)-1+CSR1[3];end
						4'B0111: begin N3x <=45 ;N3b <=7 ;NL1CH<=48;recbltnum <=47*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1000: begin N3x <=51 ;N3b <=8 ;NL1CH<=54;recbltnum <=53*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1001: begin N3x <=57 ;N3b <=9 ;NL1CH<=60;recbltnum <=59*(selevent[3:0]+1)-1+CSR1[3];end
						4'B1010: begin N3x <=63 ;N3b <=10 ;NL1CH<=66;recbltnum <=65*(selevent[3:0]+1)-1+CSR1[3];end
					   4'B1011: begin N3x <=69 ;N3b <=11 ;NL1CH<=72;recbltnum <=71*(selevent[3:0]+1)-1+CSR1[3];end
					   4'B1100: begin N3x <=75 ;N3b <=12 ;NL1CH<=78;recbltnum <=77*(selevent[3:0]+1)-1+CSR1[3];end
					   4'B1101: begin N3x <=81 ;N3b <=13 ;NL1CH<=84;recbltnum <=83*(selevent[3:0]+1)-1+CSR1[3];end
					   4'B1110: begin N3x <=87 ;N3b <=14 ;NL1CH<=90;recbltnum <=89*(selevent[3:0]+1)-1+CSR1[3];end
					   4'B1111: begin N3x <=93 ;N3b <=15 ;NL1CH<=96;recbltnum <=95*(selevent[3:0]+1)-1+CSR1[3];end
			  
			   		default:begin 	N3x <=15 ;N3b <=2 ;NL1CH<=18; recbltnum <=17*(selevent[3:0]+1)-1+CSR1[3];  end
			 	

					endcase 
		      end
		 end
end	

//always @ (negedge s7 or posedge reset )
//begin
//    if(reset==1)
//	   begin
//		  N4x <=11200 ;
//		  N5x <=512 ;
//		  N6x <=200;
//		 end
//	  else 
//	    begin
//		   case(N4v[3:0])
//			  4'B0000: begin N4x <=1600 ; end
//			  4'B0001: begin N4x <=3200 ;  end
//			  4'B0010: begin N4x <=4800 ;  end
//			  4'B0011: begin N4x <=6400 ; end
//			  4'B0100: begin N4x <=8000 ;  end
//			  4'B0101: begin N4x <=9600 ;  end
//			  4'B0110: begin N4x <=11200 ;  end
//			  4'B0111: begin N4x <=12800 ;  end
//			  4'B1000: begin N4x <=14400 ;  end
//			  default:begin 	N4x <=11200 ;  end
//			endcase
//			
//			case(N5v[3:0])
//			  4'B0000: begin N5x <=512 ;  end
//			  4'B0001:  begin N5x <=1024 ;  end
//			  4'B0010: begin N5x <=1536 ;  end
//			  4'B0011: begin N5x <=2048 ;  end
//			  4'B0100: begin N5x <=2560 ;  end
//			  4'B0101: begin N5x <=3072 ;  end
//			  4'B0110: begin N5x <=3584 ;  end
//			  4'B0111: begin N5x <=4096 ;  end
//			  4'B1000: begin N5x <=4608 ;  end
//			  4'B1001: begin N5x <=5120 ;  end
//			  4'B1010:  begin N5x <=5632 ;  end
//			  4'B1011: begin N5x <=6144 ;  end
//			  4'B1100: begin N5x <=6656 ;  end
//			  4'B1101: begin N5x <=7168 ;  end
//			  4'B1110: begin N5x <=7680 ;  end
//			  4'B1111: begin N5x <=8192 ;  end
//			  default:begin 	N5x <=512 ;  end
//			 endcase
//			 
//			 case(N6v[3:0])
//			  4'B0000: begin  N6x <=200; end
//			  4'B0001: begin  N6x <=400; end
//			  4'B0010: begin  N6x <=600; end
//			  4'B0011: begin  N6x <=800; end
//			  4'B0100: begin  N6x <=1000; end
//			  4'B0101: begin  N6x <=1200; end
//			  4'B0110: begin  N6x <=1300; end
//			  4'B0111: begin  N6x <=1400; end
//			  4'B1000: begin  N6x <=1500; end
//			  default:begin 	N6x <=200 ;  end
//			 endcase
//		end	
//end	

always @ (N4v or reset )
begin
	if(reset)
		begin
		  N4x <=11200 ;
		end
	else 
	    begin
		   case(N4v[3:0])
			  4'B0000: begin N4x <=1600 ; end
			  4'B0001: begin N4x <=3200 ;  end
			  4'B0010: begin N4x <=4800 ;  end
			  4'B0011: begin N4x <=6400 ; end
			  4'B0100: begin N4x <=8000 ;  end
			  4'B0101: begin N4x <=9600 ;  end
			  4'B0110: begin N4x <=11200 ;  end
			  4'B0111: begin N4x <=12800 ;  end
			  4'B1000: begin N4x <=14400 ;  end
			  default:begin 	N4x <=11200 ;  end
			endcase
      end
end

always @ (N5v or reset )
begin
	if(reset)
		begin
		  N5x <=512 ;
		end
	else 
	    begin
			case(N5v[3:0])
			  4'B0000: begin N5x <=512 ;  end
			  4'B0001:  begin N5x <=1024 ;  end
			  4'B0010: begin N5x <=1536 ;  end
			  4'B0011: begin N5x <=2048 ;  end
			  4'B0100: begin N5x <=2560 ;  end
			  4'B0101: begin N5x <=3072 ;  end
			  4'B0110: begin N5x <=3584 ;  end
			  4'B0111: begin N5x <=4096 ;  end
			  4'B1000: begin N5x <=4608 ;  end
			  4'B1001: begin N5x <=5120 ;  end
			  4'B1010:  begin N5x <=5632 ;  end
			  4'B1011: begin N5x <=6144 ;  end
			  4'B1100: begin N5x <=6656 ;  end
			  4'B1101: begin N5x <=7168 ;  end
			  4'B1110: begin N5x <=7680 ;  end
			  4'B1111: begin N5x <=8192 ;  end
			  default:begin 	N5x <=512 ;  end
			endcase
		end
end

always @ (N6v or reset )
begin
	if(reset)
		begin
		  N6x <=200;
		end
	else 
	    begin
			case(N6v[3:0])
			  4'B0000: begin  N6x <=200; end
			  4'B0001: begin  N6x <=400; end
			  4'B0010: begin  N6x <=600; end
			  4'B0011: begin  N6x <=800; end
			  4'B0100: begin  N6x <=1000; end
			  4'B0101: begin  N6x <=1200; end
			  4'B0110: begin  N6x <=1300; end
			  4'B0111: begin  N6x <=1400; end
			  4'B1000: begin  N6x <=1500; end
			  default:begin 	N6x <=200 ;  end
			endcase
		end	
end	


 always @ (posedge gclk or negedge s8 )
   begin
	   
      if(s8==0) 
		     begin 
			        resetx<=1;
					  resetflag<=1;
				end
	   else 
		   begin
		      if(resetflag==1)	resetflag<=2;
	         else  begin resetx<=0;resetflag<=0;end
	   	 end
    end

always @ (posedge gclk or negedge s9 )
   begin
	   
      if(s9==0) 
		     begin 
			        clearL1x<=1;
					  clearL1flag<=1;
				end
	   else 
		   begin
		      if(clearL1flag==1)	clearL1flag<=2;
	         else  begin clearL1x<=0;clearL1flag<=0;end
	   	 end
    end
always @ (posedge gclk or posedge clr )
begin
   if(clr==1) 
	     begin 
		        purgex<=0;
			end
   else if(DS==0)
	   begin
			  purgex<=CSR2[0];
   	end
end
//A24/D32 read/write cycle
assign s1= IACK && FPGA_EN;
//cblt and mcst
assign scblt= CBLT_EN&&IACK&&((!IACKIN)|CSR1[5]);
assign smcst= MCST_EN&&IACK&&((!IACKIN)|CSR1[5]);
assign CBLT_LED = !scblt;
//a32/d32 
//assign sa32= IACK && !AM5 && !AM4 && AM3 && !AM2 && !AM1 && AM0;
wire 	siackout1,siackout2,siackout3;

assign siackout1=scblt&&(purgex|!CSR1[1])&&(!CSR1[3]);
assign siackout2=smcst&&(CSR2[3]|!CSR1[7])&&(!CSR1[3]);
assign siackout3=	((!IACK&&!IACKIN)|siackout1|siackout2)&&!AS;
assign IACKOUT=(siackout3==1)?0:1;

assign oe245out=(oe245|purgex);

assign scblt2=((CSR2[0])||(!CSR1[1]));
BUF   buf3 (.I (scblt2), .O (scblt3));

endmodule
