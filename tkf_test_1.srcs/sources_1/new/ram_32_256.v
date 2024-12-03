`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/02 17:00:35
// Design Name: 
// Module Name: ram_32_256
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram_32_256(
    input wire [7 : 0] addra,
    input wire [7 : 0] addrb,
    input wire clka,
    input wire clkb,
    input wire [31 : 0] dina,
    output wire [31 : 0] doutb,
    input wire enb,
    input wire wea
    );


ram_32_256_1 example (
  .clka(clka),    // input wire clka
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addra),  // input wire [7 : 0] addra
  .dina(dina),    // input wire [31 : 0] dina
  .douta(),  // output wire [31 : 0] douta
  .clkb(clkb),    // input wire clkb
  .enb(enb),      // input wire enb
  .web(),      // input wire [0 : 0] web
  .addrb(addrb),  // input wire [7 : 0] addrb
  .dinb(),    // input wire [31 : 0] dinb
  .doutb(doutb)  // output wire [31 : 0] doutb
);
    
endmodule
