`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:58:26 02/11/2021 
// Design Name: 
// Module Name:    scl_clk 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module scl_clk(
	input clk,
	output scl,
	output scl1,
	output scl2
    );
	
	reg div = 1'b0;
	reg div2 = 1'b0;
	reg r_scl = 1'b0;

	Clock Clock_pll(.CLK_IN1(clk), .CLK_OUT1(scl1));
	
	always @(negedge clk) begin
	
			div <= div ^ 1'b1;
	end
	
	
	always @(posedge clk) begin
	
			div2 <= div2 ^ 1'b1;
			
	end
	
assign scl = div;
assign scl2 = div2;

endmodule
