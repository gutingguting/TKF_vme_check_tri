`timescale 1ns / 1ps
module set1or0(in1,eq_in1,cons_1);
input in1;
output eq_in1;
output cons_1;

assign eq_in1 = in1;
assign cons_1 = 1;

endmodule
