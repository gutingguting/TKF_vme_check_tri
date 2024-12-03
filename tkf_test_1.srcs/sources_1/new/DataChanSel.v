`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    09:38:17 01/05/07
// Design Name:    
// Module Name:    DataChanSel
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
module DataChanSel(ds,v2pen,sp3en,cblten,mcsten,vmedin,vmedout,sp3din,sp3dout,v2pdin,v2pdout);

input	[1:0]ds;
input v2pen,sp3en;

input cblten,mcsten;

input [31:0]vmedin;
input [15:0]sp3din;
input [31:0]v2pdin;

output [31:0]vmedout;
output [15:0]sp3dout;
output [31:0]v2pdout;

//assign vmedout = ((cblten== 1'b1)||(mcsten== 1'b1)||((v2pen == 1'b1)&&(sp3en == 1'b0))) ? v2pdin : (((v2pen == 1'b0)&&(sp3en == 1'b1)) ? {16'hffff,sp3din} : 32'hffffffff);
//assign v2pdout = ((cblten== 1'b1)||(mcsten== 1'b1)||((v2pen == 1'b1)&&(sp3en == 1'b0))) ? vmedin : 32'hffffffff;
//assign sp3dout = ((cblten== 1'b0)||(mcsten== 1'b0)||((v2pen == 1'b0)&&(sp3en == 1'b1))) ? vmedin[15:0] : 16'hffff;


reg [31:0]vmedout;
reg [15:0]sp3dout;
reg [31:0]v2pdout;
always @ (v2pen,sp3en,cblten,mcsten,v2pdin,vmedin,sp3din)
begin
	if ((ds[0] == 1'b0)&& (ds[1] == 1'b0))
		begin
			if ((cblten== 1'b1)||(mcsten== 1'b1))
				begin
					vmedout <= v2pdin;
					v2pdout <= vmedin;
					sp3dout <= 16'hffff;
				end 
			else
				begin
					if ((v2pen == 1'b1)&&(sp3en == 1'b0))
						begin
							v2pdout <= vmedin;
							vmedout <= v2pdin;
							sp3dout <= 16'hffff;
						end
					else if ((v2pen == 1'b0)&&(sp3en == 1'b1))
						begin
							sp3dout <= vmedin[15:0];
		 					vmedout[15:0] <= sp3din;
							vmedout[31:16] <= 16'hffff;
							v2pdout <= 32'hffffffff;		
						end
					else
						begin
							vmedout <= 32'hffffffff;
							sp3dout <= 16'hffff;
							v2pdout <= 32'hffffffff;
						end 
				end
			end 
end 

endmodule
