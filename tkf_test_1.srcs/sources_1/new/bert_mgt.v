
`timescale 1ns / 1ps

module bert_mgt(    REFCLK_IN,
                    REFCLK2_IN,
                    BREFCLK_IN, 
                    BREFCLK2_IN,
						  ENCHANSYNC_IN,
						  CHBONDI_IN,
						  CHBONDO_OUT,
						  CHBONDDONE_OUT, 
                    CONFIGENABLE_IN, 
                    CONFIGIN_IN, 
                    ENMCOMMAALIGN_IN, 
                    ENPCOMMAALIGN_IN, 
                    LOOPBACK_IN, 
                    POWERDOWN_IN, 
                    REFCLKSEL_IN, 
                    RXN_IN, 
                    RXPOLARITY_IN, 
                    RXP_IN, 
                    RXRESET_IN, 
                    RXUSRCLK_IN, 
                    RXUSRCLK2_IN, 
                    TXCHARDISPMODE_IN, 
                    TXCHARDISPVAL_IN, 
                    TXCHARISK_IN, 
                    TXDATA_IN, 
                    TXINHIBIT_IN, 
                    TXPOLARITY_IN, 
                    TXRESET_IN, 
                    TXUSRCLK_IN, 
                    TXUSRCLK2_IN, 
                    CONFIGOUT_OUT, 
                    RXBUFSTATUS_OUT, 
                    RXCHARISCOMMA_OUT, 
                    RXCHARISK_OUT, 
                    RXCOMMADET_OUT, 
                    RXDATA_OUT, 
                    RXDISPERR_OUT, 
                    RXLOSSOFSYNC_OUT, 
                    RXNOTINTABLE_OUT, 
                    RXREALIGN_OUT, 
                    RXRECCLK_OUT, 
                    RXRUNDISP_OUT, 
                    TXBUFERR_OUT, 
                    TXKERR_OUT, 
                    TXN_OUT, 
                    TXP_OUT, 
                    TXRUNDISP_OUT,

						  TXBYPASS8B10B_IN,
						  TXFORCECRCERR_IN,
						  RXCHECKINGCRC_OUT,
						  RXCLKCORCNT_OUT,
						  RXCRCERR_OUT
);

    input REFCLK_IN;
    input REFCLK2_IN;
    input BREFCLK_IN;
    input BREFCLK2_IN;
    input ENCHANSYNC_IN;
    input [3:0] CHBONDI_IN;
    output[3:0] CHBONDO_OUT;
    output CHBONDDONE_OUT;
    input CONFIGENABLE_IN;
    input CONFIGIN_IN;
    input ENMCOMMAALIGN_IN;
    input ENPCOMMAALIGN_IN;
    input [1:0] LOOPBACK_IN;
    input POWERDOWN_IN;
    input REFCLKSEL_IN;
    input RXN_IN;
    input RXPOLARITY_IN;
    input RXP_IN;
    input RXRESET_IN;
    input RXUSRCLK_IN;
    input RXUSRCLK2_IN;
    input [3:0] TXCHARDISPMODE_IN;
    input [3:0] TXCHARDISPVAL_IN;
    input [3:0] TXCHARISK_IN;
    input [31:0] TXDATA_IN;
    input TXINHIBIT_IN;
    input TXPOLARITY_IN;
    input TXRESET_IN;
    input TXUSRCLK_IN;
    input TXUSRCLK2_IN;
   output CONFIGOUT_OUT;
   output [1:0] RXBUFSTATUS_OUT;
   output [3:0] RXCHARISCOMMA_OUT;
   output [3:0] RXCHARISK_OUT;
   output RXCOMMADET_OUT;
   output [31:0] RXDATA_OUT;
   output [3:0] RXDISPERR_OUT;
   output [1:0] RXLOSSOFSYNC_OUT;
   output [3:0] RXNOTINTABLE_OUT;
   output RXREALIGN_OUT;
   output RXRECCLK_OUT;
   output [3:0] RXRUNDISP_OUT;
   output TXBUFERR_OUT;
   output [3:0] TXKERR_OUT;
   output TXN_OUT;
   output TXP_OUT;
   output [3:0] TXRUNDISP_OUT;
   
	input  [3:0] TXBYPASS8B10B_IN;
   input  TXFORCECRCERR_IN;
   output RXCHECKINGCRC_OUT;
   output [2:0] RXCLKCORCNT_OUT;
   output RXCRCERR_OUT;


//   wire [3:0] GND;
//   wire GND1;
//   wire [1:0] GND2;
//   wire [15:0] GND3;
//   
//   assign GND = 4'b0000;
//   assign GND1 = 0;
//   assign GND2 = 2'b00;
//   assign GND3 = 16'b0000000000000000;
   GT_CUSTOM GT_CUSTOM_INST (.BREFCLK(BREFCLK_IN), 
                             .BREFCLK2(BREFCLK2_IN), 
                             .CHBONDI(CHBONDI_IN[3:0]), 
                             .CONFIGENABLE(CONFIGENABLE_IN), 
                             .CONFIGIN(CONFIGIN_IN), 
                             .ENCHANSYNC(ENCHANSYNC_IN), 
                             .ENMCOMMAALIGN(ENMCOMMAALIGN_IN), 
                             .ENPCOMMAALIGN(ENPCOMMAALIGN_IN), 
                             .LOOPBACK(LOOPBACK_IN[1:0]), 
                             .POWERDOWN(POWERDOWN_IN), 
                             .REFCLK(REFCLK_IN), 
                             .REFCLKSEL(REFCLKSEL_IN), 
                             .REFCLK2(REFCLK2_IN), 
                             .RXN(RXN_IN), 
                             .RXP(RXP_IN), 
                             .RXPOLARITY(RXPOLARITY_IN), 
                             .RXRESET(RXRESET_IN), 
                             .RXUSRCLK(RXUSRCLK_IN), 
                             .RXUSRCLK2(RXUSRCLK2_IN), 
                             .TXBYPASS8B10B(TXBYPASS8B10B_IN[3:0]), 
                             .TXCHARDISPMODE(TXCHARDISPMODE_IN[3:0]), 
                             .TXCHARDISPVAL(TXCHARDISPVAL_IN[3:0]), 
                             .TXCHARISK(TXCHARISK_IN[3:0]), 
                             .TXDATA(TXDATA_IN[31:0]), 
                             .TXFORCECRCERR(TXFORCECRCERR_IN), 
                             .TXINHIBIT(TXINHIBIT_IN), 
                             .TXPOLARITY(TXPOLARITY_IN), 
                             .TXRESET(TXRESET_IN), 
                             .TXUSRCLK(TXUSRCLK_IN), 
                             .TXUSRCLK2(TXUSRCLK2_IN), 
                             .CHBONDDONE(CHBONDDONE_OUT), 
                             .CHBONDO(CHBONDO_OUT), 
                             .CONFIGOUT(CONFIGOUT_OUT), 
                             .RXBUFSTATUS(RXBUFSTATUS_OUT[1:0]), 
                             .RXCHARISCOMMA(RXCHARISCOMMA_OUT[3:0]), 
                             .RXCHARISK(RXCHARISK_OUT[3:0]), 
                             .RXCHECKINGCRC(RXCHECKINGCRC_OUT), 
                             .RXCLKCORCNT(RXCLKCORCNT_OUT[2:0]), 
                             .RXCOMMADET(RXCOMMADET_OUT), 
                             .RXCRCERR(RXCRCERR_OUT), 
                             .RXDATA(RXDATA_OUT[31:0]), 
                             .RXDISPERR(RXDISPERR_OUT[3:0]), 
                             .RXLOSSOFSYNC(RXLOSSOFSYNC_OUT[1:0]), 
                             .RXNOTINTABLE(RXNOTINTABLE_OUT[3:0]), 
                             .RXREALIGN(RXREALIGN_OUT), 
                             .RXRECCLK(RXRECCLK_OUT), 
                             .RXRUNDISP(RXRUNDISP_OUT[3:0]), 
                             .TXBUFERR(TXBUFERR_OUT), 
                             .TXKERR(TXKERR_OUT[3:0]), 
                             .TXN(TXN_OUT), 
                             .TXP(TXP_OUT), 
                             .TXRUNDISP(TXRUNDISP_OUT[3:0]));
//    synthesis attribute CHAN_BOND_LIMIT of GT_CUSTOM_INST is "16"
//    synthesis attribute CHAN_BOND_MODE of GT_CUSTOM_INST is "OFF"
//    synthesis attribute CHAN_BOND_OFFSET of GT_CUSTOM_INST is "8"
//    synthesis attribute CHAN_BOND_ONE_SHOT of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute CHAN_BOND_SEQ_1_1 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_1_2 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_1_3 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_1_4 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_2_1 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_2_2 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_2_3 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_2_4 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CHAN_BOND_SEQ_2_USE of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute CHAN_BOND_SEQ_LEN of GT_CUSTOM_INST is "4"
//    synthesis attribute CHAN_BOND_WAIT of GT_CUSTOM_INST is "8"
//    synthesis attribute CLK_CORRECT_USE of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute CLK_COR_INSERT_IDLE_FLAG of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute CLK_COR_KEEP_IDLE of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute CLK_COR_REPEAT_WAIT of GT_CUSTOM_INST is "1"
//    synthesis attribute CLK_COR_SEQ_1_1 of GT_CUSTOM_INST is "00110111100"
//    synthesis attribute CLK_COR_SEQ_1_2 of GT_CUSTOM_INST is "00010010101"
//    synthesis attribute CLK_COR_SEQ_1_3 of GT_CUSTOM_INST is "00010110101"
//    synthesis attribute CLK_COR_SEQ_1_4 of GT_CUSTOM_INST is "00010110101"
//    synthesis attribute CLK_COR_SEQ_2_1 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CLK_COR_SEQ_2_2 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CLK_COR_SEQ_2_3 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CLK_COR_SEQ_2_4 of GT_CUSTOM_INST is "00000000000"
//    synthesis attribute CLK_COR_SEQ_2_USE of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute CLK_COR_SEQ_LEN of GT_CUSTOM_INST is "4"
//    synthesis attribute CRC_END_OF_PKT of GT_CUSTOM_INST is "K29_7"
//    synthesis attribute CRC_FORMAT of GT_CUSTOM_INST is "USER_MODE"
//    synthesis attribute CRC_START_OF_PKT of GT_CUSTOM_INST is "K27_7"
//    synthesis attribute ALIGN_COMMA_MSB of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute COMMA_10B_MASK of GT_CUSTOM_INST is "1111111111"
//    synthesis attribute DEC_MCOMMA_DETECT of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute DEC_PCOMMA_DETECT of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute DEC_VALID_COMMA_ONLY of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute MCOMMA_10B_VALUE of GT_CUSTOM_INST is "1100000101"
//    synthesis attribute MCOMMA_DETECT of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute PCOMMA_10B_VALUE of GT_CUSTOM_INST is "0011111010"
//    synthesis attribute PCOMMA_DETECT of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute RX_BUFFER_USE of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute RX_CRC_USE of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute RX_DATA_WIDTH of GT_CUSTOM_INST is "4"
//    synthesis attribute RX_DECODE_USE of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute RX_LOSS_OF_SYNC_FSM of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute RX_LOS_INVALID_INCR of GT_CUSTOM_INST is "1"
//    synthesis attribute RX_LOS_THRESHOLD of GT_CUSTOM_INST is "4"
//    synthesis attribute TERMINATION_IMP of GT_CUSTOM_INST is "50"
//    synthesis attribute SERDES_10B of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute TX_BUFFER_USE of GT_CUSTOM_INST is "TRUE"
//    synthesis attribute TX_CRC_FORCE_VALUE of GT_CUSTOM_INST is "11010110"
//    synthesis attribute TX_CRC_USE of GT_CUSTOM_INST is "FALSE"
//    synthesis attribute TX_DATA_WIDTH of GT_CUSTOM_INST is "4"
//    synthesis attribute TX_DIFF_CTRL of GT_CUSTOM_INST is "500"
//    synthesis attribute TX_PREEMPHASIS of GT_CUSTOM_INST is "0"
//    synthesis attribute REF_CLK_V_SEL of GT_CUSTOM_INST is "0"

   defparam GT_CUSTOM_INST.ALIGN_COMMA_MSB = "TRUE";
   defparam GT_CUSTOM_INST.CHAN_BOND_LIMIT = 16;
   defparam GT_CUSTOM_INST.CHAN_BOND_MODE = "OFF";
   defparam GT_CUSTOM_INST.CHAN_BOND_OFFSET = 8;
   defparam GT_CUSTOM_INST.CHAN_BOND_ONE_SHOT = "FALSE";
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_1_1 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_1_2 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_1_3 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_1_4 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_2_1 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_2_2 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_2_3 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_2_4 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_2_USE = "FALSE";
   defparam GT_CUSTOM_INST.CHAN_BOND_SEQ_LEN = 1;
   defparam GT_CUSTOM_INST.CHAN_BOND_WAIT = 8;
   defparam GT_CUSTOM_INST.CLK_CORRECT_USE = "TRUE";
   defparam GT_CUSTOM_INST.CLK_COR_INSERT_IDLE_FLAG = "FALSE";
   defparam GT_CUSTOM_INST.CLK_COR_KEEP_IDLE = "FALSE";
   defparam GT_CUSTOM_INST.CLK_COR_REPEAT_WAIT = 1;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_1_1 = 11'b00110111100;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_1_2 = 11'b00010010101;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_1_3 = 11'b00010110101;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_1_4 = 11'b00010110101;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_2_1 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_2_2 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_2_3 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_2_4 = 11'b00000000000;
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_2_USE = "FALSE";
   defparam GT_CUSTOM_INST.CLK_COR_SEQ_LEN = 4;
   defparam GT_CUSTOM_INST.COMMA_10B_MASK = 10'b1111111111;
   defparam GT_CUSTOM_INST.CRC_END_OF_PKT = "K29_7";
   defparam GT_CUSTOM_INST.CRC_FORMAT = "USER_MODE";
   defparam GT_CUSTOM_INST.CRC_START_OF_PKT = "K27_7";
   defparam GT_CUSTOM_INST.DEC_MCOMMA_DETECT = "TRUE";
   defparam GT_CUSTOM_INST.DEC_PCOMMA_DETECT = "TRUE";
   defparam GT_CUSTOM_INST.DEC_VALID_COMMA_ONLY = "TRUE";
   defparam GT_CUSTOM_INST.MCOMMA_10B_VALUE = 10'b1100000101;
   defparam GT_CUSTOM_INST.MCOMMA_DETECT = "TRUE";
   defparam GT_CUSTOM_INST.PCOMMA_10B_VALUE = 10'b0011111010;
   defparam GT_CUSTOM_INST.PCOMMA_DETECT = "TRUE";
   defparam GT_CUSTOM_INST.RX_BUFFER_USE = "TRUE";
   defparam GT_CUSTOM_INST.RX_CRC_USE = "FALSE";
   defparam GT_CUSTOM_INST.RX_DATA_WIDTH = 4;
   defparam GT_CUSTOM_INST.RX_DECODE_USE = "TRUE";
   defparam GT_CUSTOM_INST.RX_LOSS_OF_SYNC_FSM = "TRUE";
   defparam GT_CUSTOM_INST.RX_LOS_INVALID_INCR = 1;
   defparam GT_CUSTOM_INST.RX_LOS_THRESHOLD = 4;
   defparam GT_CUSTOM_INST.TERMINATION_IMP = 50;
   defparam GT_CUSTOM_INST.SERDES_10B = "FALSE";
   defparam GT_CUSTOM_INST.TX_BUFFER_USE = "TRUE";
   defparam GT_CUSTOM_INST.TX_CRC_FORCE_VALUE = 8'b11010110;
   defparam GT_CUSTOM_INST.TX_CRC_USE = "FALSE";
   defparam GT_CUSTOM_INST.TX_DATA_WIDTH = 4;
   defparam GT_CUSTOM_INST.TX_DIFF_CTRL = 600;
   defparam GT_CUSTOM_INST.TX_PREEMPHASIS = 0;
   defparam GT_CUSTOM_INST.REF_CLK_V_SEL = 0;
   
endmodule
