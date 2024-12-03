`timescale 1ns / 1ps
module bidir32(ctrl,en,DataIn,DataOut,DataInout);
input ctrl,en;
input [31:0]DataIn;
output [31:0]DataOut;
inout [31:0]DataInout;
assign DataOut=DataInout;
assign DataInout=((ctrl==1'b0)&&(en==1'b1))?DataIn:32'hzzzzzzzz;
endmodule
