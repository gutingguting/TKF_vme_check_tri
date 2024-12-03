`timescale 1ns / 1ps
module bidir8(cplden,ctrl,DataIn,DataOut,DataInout);
input ctrl;
input cplden;
input [7:0]DataIn;
output [7:0]DataOut;
inout [7:0]DataInout;
assign DataOut=DataInout;
assign DataInout=((ctrl==1'b0)&&(cplden==1'b1))?DataIn:8'bz;
endmodule
