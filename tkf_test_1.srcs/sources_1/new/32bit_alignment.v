`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:  Trigger,IHEP
// Engineer: XU Hao
//
// Create Date:    15:34:27 05/16/05
// Design Name:    MGT
// Module Name:    align_comma_32
// Project Name:   
// Target Device:  xc2vp40
// Tool versions:  ise7.1
// Description:	 properly align 32bit wide data. 
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:


//The following example code illustrates one way to create the logic to 
//properly align 32-bit wide data with a comma in bits [31:24] For brevity, 
//most status bits are not included in this example design;
//however, these should be shifted in the same manner as RXDATA and RXCHARISK.
//Note that when using a 40-bit data path (8B/10B bypassed), 
//a similar realignment scheme may be used, 
//but it cannot rely on RXCHARISCOMMA for comma detection.
//
/*********************************************************************
*
* XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION ¡°AS IS¡±
* AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
* SOLUTIONS FOR XILINX DEVICES. BY PROVIDING THIS DESIGN, CODE,
* OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
* APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
* THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
* AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
* FOR YOUR IMPLEMENTATION. XILINX EXPRESSLY DISCLAIMS ANY
* WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
* IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
* REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
* INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
* FOR A PARTICULAR PURPOSE.
*
* (c) Copyright 2002 Xilinx Inc.
* All rights reserved.
*
*********************************************************************/
// 
////////////////////////////////////////////////////////////////////////////////

// Virtex-II Pro RocketIO comma alignment module
//
// This module reads RXDATA[31:0] from a RocketIO transceiver
// and copies it to
// its output, realigning it if necessary so that commas
// are aligned to the MSB position
// [31:24]. The module assumes ALIGN_COMMA_MSB is TRUE,
// so that the comma
// is already aligned to [31:24] or [15:8].
//
// Outputs
//
// aligned_data[31:0] -- Properly aligned 32-bit ALIGNED_DATA
// sync -- Indicator that aligned_data is properly aligned
// aligned_rxisk[3:0] - properly aligned 4 bit RXCHARISK
// Inputs - These are all RocketIO inputs or outputs
// as indicated:
//
// usrclk2 -- RXUSRCLK2
// rxreset -- RXRESET
// rxisk[3:0] RXCHARISK[3:0]
// rxdata[31:0] RXDATA[31:0] -- (commas aligned to
// [31:24] or [15:8])
// rxrealign -- RXREALIGN
// rxcommadet -- RXCOMMADET
// rxchariscomma3 -- RXCHARISCOMMA[3]
// rxchariscomma1 -- RXCHARISCOMMA[1]
//

module align_comma_32(usrclk2, rxreset, rxisk, rxdata, rxrealign, rxcommadet, 
                         rxchariscomma3, rxchariscomma1, aligned_data, 
                         sync, aligned_rxisk);
    input usrclk2;
    input rxreset;
    input [3:0] rxisk;
    input [31:0] rxdata;
    input rxrealign;
    input rxcommadet;
    input rxchariscomma3;
    input rxchariscomma1;
    output [31:0] aligned_data;
    output sync;
    output [3:0] aligned_rxisk;

	 reg [31:0] aligned_data;
	 reg sync;

	 reg [15:0] rxdata_reg;
	 reg [1:0] rxisk_reg;
	 reg [3:0] aligned_rxisk;
	 reg byte_sync;

	 reg [3:0] wait_to_sync;
	 reg count;

// This process maintains wait_to_sync and count,
// which are used only to
// maintain output sync; this provides some idea
// of when the output is properly
// aligned, with the comma in aligned_data[31:24]. The
// counter is set to a high value
// whenever the elastic buffer is reinitialized;
// that is, upon asserted RXRESET or
// RXREALIGN. Count-down is enabled whenever a
// comma is known to have
// come through the comma detection circuit,
// that is, upon an asserted RXREALIGN
// or RXCOMMADET.
	 always @ ( posedge usrclk2 )

	    begin
		 	 if ( rxreset )
			 		begin
			      	wait_to_sync <= 4'b1111;
						count <= 1'b0;
			 		end
			 else if ( rxrealign )
					begin
						wait_to_sync <= 4'b1111;
						count <= 1'b1;
					end
			 else
					begin
						if ( count && ( wait_to_sync != 4'b0000 ) )
							wait_to_sync <= wait_to_sync - 4'b0001;
						if ( rxcommadet )
							count <= 1'b1;
					end
		 end
// This process maintains output sync, which indicates
// when outgoing aligned_data
// should be properly aligned, with the comma in aligned_data[31:24].
// Output aligned_data is
// considered to be in sync when a comma is seen on
// rxdata (as indicated
// by rxchariscomma3 or 1) after the counter wait_to_sync
// has reached 0, indicating
// that commas seen by the comma detection circuit
// have had time to propagate to
// aligned_data after initialization of the elastic buffer.
	 always @ ( posedge usrclk2 )

			begin
				if ( rxreset | rxrealign )
					sync <= 1'b0;
				else if ( ( wait_to_sync == 4'b0000 ) &
					( rxchariscomma3 | rxchariscomma1 ) )
					sync <= 1'b1;
			end
// This process generates aligned_data with commas aligned in [31:24],
// assuming that incoming commas are aligned to [31:24] or [15:8].
// Here, you could add code to use ENPCOMMAALIGN and
// ENMCOMMAALIGN to enable a move back into the byte_sync=0 state.
	 always @ ( posedge usrclk2 or posedge rxreset )

	 		begin
				if ( rxreset )
					begin
						rxdata_reg <= 16'h0000;
						aligned_data <= 32'h0000_0000;
						rxisk_reg <= 2'b00;
						aligned_rxisk <= 4'b0000;
						byte_sync <= 1'b0;
					end
				else
					begin
						rxdata_reg[15:0] <= rxdata[15:0];
						rxisk_reg[1:0] <= rxisk[1:0];
						if ( rxchariscomma3 )
							begin
								aligned_data[31:0] <= rxdata[31:0];
								aligned_rxisk[3:0] <= rxisk[3:0];
								byte_sync <= 1'b0;
							end
						else
							if ( rxchariscomma1 | byte_sync )
								begin
									aligned_data[31:0] <= { rxdata_reg[15:0], rxdata[31:16]};
									aligned_rxisk[3:0] <= { rxisk_reg[1:0], rxisk[3:2] };
									byte_sync <= 1'b1;
								end
							else
								begin
									aligned_data[31:0] <= rxdata[31:0];
									aligned_rxisk <= rxisk;
								end
					end
			end
	endmodule // align_comma_32

