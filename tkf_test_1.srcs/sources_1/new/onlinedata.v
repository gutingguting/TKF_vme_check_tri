`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:25:09 12/06/06
// Design Name:    
// Module Name:    onlinedata
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

module onlinedataram(clk1a,clk1b,clk2b,GAV,L1,DSx,ASx,reset,N3,N3c,N4,N6,N7,N8,rot,DATA_MODE,ltk,stk,tsf,FULLx,empty,berrinx,s5x,we1a,en2b,CHECKx,clearL1,addr1bx,addr2b,dina,dout2b,din_31);

input clk1a,clk1b,clk2b,L1,ASx,reset,we1a,en2b,CHECKx,clearL1,berrinx,s5x;
input DSx;
input [4:0]GAV;
input [7:0] addr1bx;
input [13:0]addr2b;
input [319:0] dina;
//input [3:0] datacounter;
input [31:0] din_31;
input [9:0] N3;
input [3:0] N3c;
input [13:0] N4;
input [10:0] N6;
input [3:0] N7,N8;

input rot;
input [7:0] DATA_MODE;
input [15:0] ltk;
input [15:0] stk;
input [63:0] tsf;

output FULLx,empty;
output [31:0] dout2b;
/*reg [31:0] dout2b;
wire [31:0] dout31;

assign  dout2b=dout31;*/
wire  en1b,we2a;
reg en1bf=0,we2af=0;
//reg s3=1;
reg [4:0] select=5'b11111;
reg[9:0] countl1=0;
reg[7:0] addr1a=0,addr1b=0,addr1btsf=0,addr1btk=0;
reg [13:0] addr2a=14'h0000,addr2ax=14'h0000;
reg [7:0] trgn=0;

reg FULLx=0;
wire clrx;
//reg [127:0] ramo_d[511:0];
//reg [127:0] tempr;
//reg [12:0] tempad1=0;
//reg[2:0]tempad2=0;
//reg [15:0] doutb;
//reg[13:0] i=0;
//&&&&&&&&&&&&&&&&&&&&77
wire [31:0] dout1b1,dout1b2,dout1b3,dout1b4,dout1b5,dout1b6,dout1b7,dout1b8,dout1b9,dout1ba,dout1bb,dout1bc,dout1bd;
wire [31:0] dout1be;

wire [31:0] douttsf1,douttsf2,douttsf3;
wire [31:0] doutltk,doutstk;

//wire [23:0] dout1b1,dout1b2,dout1b3,dout1b4,dout1b5,dout1b6,dout1b7,dout1b8,dout1b9,dout1ba,dout1bb,dout1bc,dout1bd;
//wire [7:0] dout1be;
//wire [23:0] douttsf1,douttsf2,douttsf3;
//wire [15:0] doutltk,doutstk;
//wire [3:0] dataram;
reg [31:0] temphead=0,temphead2=0;
reg [31:0] tempram=0;

reg [1:0] checkcount=0;
reg we2acheck=0;
wire we2aflag;
wire clrem;
reg [13:0]addr2afirst;
reg empty=0, countempty=0;

assign we2aflag=we2acheck|we2a;

assign clrx=reset|clearL1;
//assign clrx=1'b0;
//assign clrem=clrx|!berrinx|!s5x;
assign clrem=clrx;
//&&&&&&&&&&&&&&&
// fiforam fiforam1(
//  	   .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[23:0]),
//		.doutb(dout1b1),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam2(  
// 	   .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[47:24]),
//		.doutb(dout1b2),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam3(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[71:48]),
//		.doutb(dout1b3),
//		.enb(en1b),
//		.wea(we1a)
//		);
//		
//fiforam fiforam4(  
// 	   .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[95:72]),
//		.doutb(dout1b4),
//		.enb(en1b),
//		.wea(we1a)
//		);
//	
//fiforam fiforam5(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[119:96]),
//		.doutb(dout1b5),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam6(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[143:120]),
//		.doutb(dout1b6),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam7(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[167:144]),
//		.doutb(dout1b7),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam8(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[191:168]),
//		.doutb(dout1b8),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforam9(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[215:192]),
//		.doutb(dout1b9),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforama(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[239:216]),
//		.doutb(dout1ba),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforamb(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[263:240]),
//		.doutb(dout1bb),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforamc(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[287:264]),
//		.doutb(dout1bc),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforamd(  
// 	  .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[311:288]),
//		.doutb(dout1bd),
//		.enb(en1b),
//		.wea(we1a)
//		);
//
//						
//fifo_8_256 fiforame(  
// 	   .addra(addr1a),
//		.addrb(addr1b),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(dina[319:312]),
//		.doutb(dout1be),
//		.enb(en1b),
//		.wea(we1a)
//			);
///*ram_32_20480 fiforam7(  
// 	   .addra(addr2a),
//		.addrb(addr2b),
//		.clka(clk1b),
//		.clkb(clk2b),
//		.dina(tempram),
//		.doutb(dout2b),
//		.enb(en2b),
//		.wea(we2a)
//		 );*/
//
//fifo_16_256 fiforamtrack1(
//   	.addra(addr1a),
//		.addrb(addr1btk),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(ltk[15:0]),
//		.doutb(doutltk),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fifo_16_256 fiforamtrack2(
//   	.addra(addr1a),
//		.addrb(addr1btk),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(stk[15:0]),
//		.doutb(doutstk),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fiforam fiforamtsf1(
//		.addra(addr1a),
//		.addrb(addr1btsf),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(tsf[23:0]),
//		.doutb(douttsf1),
//		.enb(en1b),
//		.wea(we1a)
//		);
//
//fiforam fiforamtsf2(
//		.addra(addr1a),
//		.addrb(addr1btsf),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(tsf[47:24]),
//		.doutb(douttsf2),
//		.enb(en1b),
//		.wea(we1a)
//		);
//fifo_16_256 fiforamtsf3(
//   	.addra(addr1a),
//		.addrb(addr1btsf),
//		.clka(clk1a),
//		.clkb(clk1b),
//		.dina(tsf[63:48]),
//		.doutb(douttsf3[15:0]),
//		.enb(en1b),
//		.wea(we1a)
//		);
//assign douttsf3[23:16] =0;

ram_32_256 ram_32_256hit1(
  	   .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[23:0]}),
		.doutb(dout1b1),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hit2(  
 	   .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[47:24]}),
		.doutb(dout1b2),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hit3(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[71:48]}),
		.doutb(dout1b3),
		.enb(en1b),
		.wea(we1a)
		);
		
ram_32_256 ram_32_256hit4(  
 	   .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[95:72]}),
		.doutb(dout1b4),
		.enb(en1b),
		.wea(we1a)
		);
	
ram_32_256 ram_32_256hit5(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[119:96]}),
		.doutb(dout1b5),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hit6(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[143:120]}),
		.doutb(dout1b6),
		.enb(en1b),
		.wea(we1a)
		);

ram_32_256 ram_32_256hit7(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[167:144]}),
		.doutb(dout1b7),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hit8(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[191:168]}),
		.doutb(dout1b8),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hit9(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[215:192]}),
		.doutb(dout1b9),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hita(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[239:216]}),
		.doutb(dout1ba),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hitb(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[263:240]}),
		.doutb(dout1bb),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hitc(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[287:264]}),
		.doutb(dout1bc),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256hitd(  
 	  .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,dina[311:288]}),
		.doutb(dout1bd),
		.enb(en1b),
		.wea(we1a)
		);

						
ram_32_256 ram_32_256hite(  
 	   .addra(addr1a),
		.addrb(addr1b),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({24'b0,dina[319:312]}),
		.doutb(dout1be),
		.enb(en1b),
		.wea(we1a)
			);

ram_32_256 ram_32_256track1(
   	.addra(addr1a),
		.addrb(addr1btk),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({16'b0,ltk[15:0]}),
		.doutb(doutltk),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256track2(
   	.addra(addr1a),
		.addrb(addr1btk),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({16'b0,stk[15:0]}),
		.doutb(doutstk),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256tsf1(
		.addra(addr1a),
		.addrb(addr1btsf),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,tsf[23:0]}),
		.doutb(douttsf1),
		.enb(en1b),
		.wea(we1a)
		);

ram_32_256 ram_32_256tsf2(
		.addra(addr1a),
		.addrb(addr1btsf),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({8'b0,tsf[47:24]}),
		.doutb(douttsf2),
		.enb(en1b),
		.wea(we1a)
		);
ram_32_256 ram_32_256tsf3(
   	.addra(addr1a),
		.addrb(addr1btsf),
		.clka(clk1a),
		.clkb(clk1b),
		.dina({16'b0,tsf[63:48]}),
		.doutb(douttsf3),
		.enb(en1b),
		.wea(we1a)
		);

ram_32_16384 fiforamf(  
 	   .addra(addr2a),
		.addrb(addr2b),
		.clka(clk1b),
		.clkb(clk2b),
		.dina(tempram),
		.doutb(dout2b),
		.enb(en2b),
		.wea(we2aflag)
		 );

/*ram_4_256 acram_4_256(
	.addra(addrr1x),
	.addrb(addrr1),
	.clka(clk1a),
	.clkb(clk1a),
	.dina(datacounter),
	.doutb(dataram),
	.enb(enramr),
	.wea(enramw));	*/


always @ (posedge clk1a or posedge clrx)
 begin
   if(clrx) 
	  begin
	  FULLx<=0;
	  end
	else
	 begin
	  if(empty==0)
	   begin
       if (addr2a>(addr2b+100))
	      begin 
		     if(((addr2a-addr2b)>=N4)&&(L1==1))	 FULLx<=1;
		     else if((addr2a-addr2b)<=(N4-N6))	  FULLx<=0;
		    end
		  else if ((addr2a+100)<addr2b)
	       begin 
		     if(((16384-addr2b+addr2a)>=N4)&&(L1==1))	 FULLx<=1;
		     else if((16384-addr2b+addr2a)<=(N4-N6))	 FULLx<=0;
		    end
			else 	   FULLx<=0;
		 end
		
	  else 
	   begin   FULLx<=0; end
	 end
 end

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
always @ (posedge clk1a or posedge clrem)
 begin
   if(clrem) 
	  begin
	  empty<=0;
	
	  end
	else
	  begin
	 
		if(FULLx==0)
		     begin
			  
             	if ((addr2ax==addr2b)&&(DSx==0))
	                begin 
			       
						  empty<=1;
		     
		              end
					else if(addr2ax!=addr2b)
					     begin 	 empty<=0;	 end
				
				 end
		 else 
		    begin
			    empty<=0; 
				
			  end	  
		end
 end						  	  
//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


always @ (posedge clk1a or posedge clrx)
 begin
   if(clrx) 
	  begin
	  addr1a<=0;
	  end
	else
	  begin
       if (we1a==1)
	      begin 
		     if(addr1a!=255)	 addr1a<=addr1a+1;
		     if(addr1a==255)	 addr1a<=0;
		    end
		end
 end



 	
//always @ (posedge clk1a or posedge clrx )
always @ (posedge clk1b or posedge clrx )
  begin 
   if(clrx)
    begin
	   en1bf<=0;
      we2af<=0;
	//	enramrf<=0;
	 end

	else
	 begin
	if(L1)
	  begin
	    if(countl1<N3)
		    begin
		      en1bf<=1;
	         we2af<=1;
        //    enramrf<=1;
			 end
		 else
	       begin
	  	        en1bf<=0;
              we2af<=0;
	      //     enramrf<=0;
	        end
	   end 
	else
	  begin
	  	en1bf<=0;
      we2af<=0;
	//	enramrf<=0;
	  end
	end
 end
  BUF buffer1( .O(en1b),
              .I(en1bf));
  
  BUF buffer2( .O(we2a),
              .I(we2af));
 // BUF buffer3( .O(enramr),
           //   .I(enramrf));

//set the parameters when data is being moved to global RAM
always @ (posedge clk1b or posedge clrx )
  begin
   if(clrx)
	  begin
	      countl1<=0;
			select<=5'b11111 ;
			addr1b<=0;
	//		addrr1<=0;
			addr2ax<=0;
			addr2a<=0;
	  end
	 
	else
     begin 
       if(we2a==1)
	  	    begin
			     
	          if(select==5'b11111)
				     begin 
					    select<=5'b11110;
//						 addr1b<=addr1bx;
//		             addrr1<=addrr1x;	
						 if(addr2ax!=16383) addr2ax<=addr2ax+1;
	                if(addr2ax==16383) addr2ax<=0;
				       addr2a<=addr2ax;
						 addr2afirst<=addr2ax;
					  end
		        else  if(select==5'b11110)
				     begin 
					    select<=0;
//						 addr1b<=addr1bx;
//		             addrr1<=addrr1x;	
						 if(addr2ax!=16383) addr2ax<=addr2ax+1;
	                if(addr2ax==16383) addr2ax<=0;
				       addr2a<=addr2ax;
					//	 addr2afirst<=addr2ax;
					  end
				 
				  else
		           begin
			          if(rot)
						    begin
					           if(countl1<N3)
					              begin 
										  countl1<=countl1+1;
									     if(addr2ax!=16383) addr2ax<=addr2ax+1;
			                       if(addr2ax==16383) addr2ax<=0;
										  addr2a<=addr2ax;
						              if(select==5'b10001)
										     begin 
											     if (addr1b!=255)addr1b<=addr1b+1;
										        else addr1b <=0;
											 //    if (addrr1!=255)addrr1<=addrr1+1;
											//	  else addrr1<=0; 

												end
					                 if (select==5'b10010)  
									        begin 
						                    select<=5'b00000;
				                    
						                  end
				                    else select<=select+1;
					   	         end
							   end
							else if(!rot)
							    begin
										if(countl1<N3)
						              begin 
											  countl1<=countl1+1;
										     if(addr2ax!=16383) addr2ax<=addr2ax+1;
				                       if(addr2ax==16383) addr2ax<=0;
											  addr2a<=addr2ax;
							              if(select==5'b00001)
											     begin 
												     if (addr1b!=255)addr1b<=addr1b+1;
											        else addr1b <=0;
												 //    if (addrr1!=255)addrr1<=addrr1+1;
												//	  else addrr1<=0; 

													end
						                 if (select==5'b00010)  
										        begin 
							                    select<=5'b00000;
				                    
							                  end
					                    else select<=select+1;
						   	         end
									 end
						 
			          /*else 
			             begin
				             
				             s3<=0; 
				          end*/
			         end
           end
	    /*else if(L1==0)  s3<=1;
	    else s3<=0;*/
	 else if(we2acheck==1) addr2a<=addr2afirst;
						 
	 else if(L1==0)
		 begin  
		   countl1<=0;
			select<=5'b11111 ;
			addr1b<=(addr1bx+2)-N3c;
			
		//	addrr1<=(addr1bx+15)-N3c;	
			
		   //if(addrr1x>=1) addrr1<=addrr1x-1;	
			//else 	addrr1<=addrr1x+255;
		  end
  end
	    
end	

always @ (posedge clk1b or posedge clrx )
  begin
   if(clrx)
	  begin
	     
			addr1btsf<=0;
			addr1btk<=0;
		
	  end
	 
	else
     begin 	
	     addr1btsf<=addr1b+N7;
		  addr1btk<=addr1b+N8;   
	  end
	 end
//when L1 comes, data in FIFO	will be written to global RAM	 		

always @ (posedge clk1b or posedge clrx)
begin 
   if(clrx)
	  begin
	    tempram[31:0]<=0;
	    temphead[31:0]<=0;
		 temphead2[31:0]<=0;
	  end
	else
	   begin
        if(we2a&&rot)
           begin
				   case (select)
				    5'B00000 : begin if(countl1<(N3-1)) begin tempram[23:0] <= dout1b1[23:0];tempram[31:24] <= 1;end end
					 5'B00001 : begin tempram[23:0] <= dout1b2[23:0];tempram[31:24] <= 1;end	
					 5'B00010 : begin tempram[23:0] <= dout1b3[23:0];tempram[31:24] <= 1;end
					 5'B00011 : begin tempram[23:0] <= dout1b4[23:0];tempram[31:24] <= 1;end
					 5'B00100 : begin tempram[23:0] <= dout1b5[23:0];tempram[31:24] <= 1;end
					 5'B00101 : begin tempram[23:0] <= dout1b6[23:0];tempram[31:24] <= 1;end
					 5'B00110 : begin tempram[23:0] <= dout1b7[23:0];tempram[31:24] <= 1;end
					 5'B00111 : begin tempram[23:0] <= dout1b8[23:0];tempram[31:24] <= 1;end
					 5'B01000 : begin tempram[23:0] <= dout1b9[23:0];tempram[31:24] <= 1;end
					 5'B01001 : begin tempram[23:0] <= dout1ba[23:0];tempram[31:24] <= 1;end	
					 5'B01010 : begin tempram[23:0] <= dout1bb[23:0];tempram[31:24] <= 1;end
					 5'B01011 : begin tempram[23:0] <= dout1bc[23:0];tempram[31:24] <= 1;end
					 5'B01100 : begin tempram[23:0] <= dout1bd[23:0];tempram[31:24] <= 1;end
					 5'B01101 : begin tempram[7:0] <= dout1be[7:0]; tempram[31:8] <= 24'h10000; end
		 			 5'B01110 : begin tempram[23:0] <= douttsf1[23:0];tempram[31:24] <= 0;end	
					 5'B01111 : begin tempram[23:0] <= douttsf2[23:0];tempram[31:24] <= 0;end
					 5'B10000 : begin tempram[23:0] <= douttsf3[23:0];tempram[31:24] <= 0;end
					 5'B10001 : begin tempram[15:0] <= doutltk[15:0];tempram[31:16] <= 16'h200;end
					 5'B10010 : begin tempram[15:0] <= doutstk[15:0]; tempram[31:16] <= 16'h300; end

					 5'B11110 : begin tempram[31:0] <=temphead2[31:0]; 	  end
					 5'B11111 : begin tempram[31:0] <=temphead[31:0]; 	  end
					 //default: 
					endcase
      	 end
       else if(we2a&&!rot)
           begin
				   case (select)
				    5'B00000 : begin if(countl1<(N3-1)) begin tempram[23:0] <= douttsf1[23:0];tempram[31:24] <= 0;end end
					 5'B00001 : begin tempram[23:0] <= douttsf2[23:0];tempram[31:24] <= 0;end	
					 5'B00010 : begin tempram[23:0] <= douttsf3[23:0];tempram[31:24] <= 0;end
					
		 			 5'B11110 : begin tempram[31:0] <=temphead2[31:0]; 	  end
					 5'B11111 : begin tempram[31:0] <=temphead[31:0]; 	  end
					 //default: 
					endcase
      	  end
       else 
			 begin
			     if(CHECKx==1) 
				     begin 
					    if(checkcount==0)
						    begin
							 	checkcount<=1;
					    		we2acheck<=1;
					    		if(temphead[7:0]==255) temphead[9:0]<=10'b1011111111; 
						 		else   temphead[9:0]<=10'b1111111111;
							 end
						 else if(checkcount==1)
						     begin
							    checkcount<=2; 
								 tempram[31:0] <=temphead[31:0]; 
							  end
						 else if(checkcount==2)
						     begin
							    checkcount<=3; 
						 
							   end
						 else 
						     we2acheck<=0;
				     end
				  else 
				     begin
			      	temphead[31:27] <=GAV[4:0];
						temphead[26] <=1'b0;
					//	temphead[31:27] <=5'b01011;
				  		temphead[25:16]<=(N3+2);
						temphead[9:8]<=2'b00;
				  		temphead[7:0]<=trgn-1;

						temphead2[31:30] <=2'b11;
						temphead2[29:28] <=2'b10;


				  
					  	temphead2[27:24] <=(GAV[4:0]-4);
					


				  		temphead2[23:14]<=(N3+1);
						temphead2[13:8]<=(2*N3c+1);

					  //
						temphead2[7:3]<={4'b0000,rot};
				  		temphead2[2:0]<=DATA_MODE[2:0];
						//
						checkcount<=0; 
					  end
				  //if (trgn!=255) begin temphead[7:0]<=trgn; end
				  //if (trgn==255) begin temphead[7:0]<=0;	 end
		      end
	end

end

// counting L1
wire clr;
assign clr=	reset||CHECKx||clearL1;
always @ (posedge L1 or posedge clr)
 begin
   if(clr)
	  begin
	    	trgn <= 0;
	  end
	 
	else

     begin 
        if (trgn!=255) trgn<=trgn+1 ;
	     if (trgn==255)	trgn <= 0;
	  end
   
 end
/*always @ (posedge clk1b)
 begin 
  if (!reset)
	  begin
		addr2a<=0;
	
	  end
  else 
	 begin
     if(en1b&&we2a)
      begin
	    if(addr2a!=20479) addr2a<=addr2a+1;
	    if(addr2a==20479) addr2a<=0;
	   end
     end
	end
    

always @ (posedge clk1a)
 begin 
   if (!reset)
	  begin
		addr1a<=0;
	
	  end
	else 
	 begin
	  if(we1a)
		begin
	     
		  if(addr1a!=255)	addr1a<=addr1a+1;
		  if(addr1a==255)	addr1a<=0;
		end
	 end
 end*/
/* begin 
   if (!reset)
	  begin
		addr1a<=0;
		tempr <= 0;
	  end
	else 
	 begin
	  if(wr)
		begin
	     ramo_d[adda]<= dina;
		  if(adda!=511)	adda<=adda+1;
		  if(adda==511)	adda<=0;
		end
	 end
 end */

 /*always @ (posedge clkb)
  begin 
    if (re)
	  begin
		tempr<=ramo_d[addb[12:0]];
		case(addb[15:13])
		 3'B000 : doutb <= tempr[15:0];
		 3'B001 : doutb <= tempr[31:16];
		 3'B010 : doutb <= tempr[47:32];
		 3'B011 : doutb <= tempr[63:48];
		 3'B100 : doutb <= tempr[79:64];
		 3'B101 : doutb <= tempr[95:80];
		 3'B110 : doutb <= tempr[111:96];
		 3'B111 : doutb <= tempr[127:112]; 
		 default :doutb <= 16'Hxxxx;
		endcase
	end

	  // tempad1<= addb[12:0];
 end   */
	
 





endmodule
