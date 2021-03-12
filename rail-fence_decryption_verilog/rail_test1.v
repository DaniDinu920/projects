`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:01:24 12/12/2020
// Design Name:   rail_fence
// Module Name:   C:/verilog/rail_fence/rail_test1.v
// Project Name:  rail_fence
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rail_fence
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rail_test1;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] data;
	reg [1:0] key;

	// Outputs
	wire [7:0] data_c;

	// Instantiate the Unit Under Test (UUT)
	rail_fence uut (
		.clk(clk), 
		.reset(reset), 
		.data(data), 
		.data_c(data_c), 
		.key(key)
	);
	initial begin
	clk=1'b0;
	forever#5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		data = 8'h44;
		key = 2'b10;
		#10
		data = 8'h43;
		key = 2'b10;
		#10
		data = 8'h49;
		key = 2'b10;
		#10
		data= 8'h54;
		key = 2'b10;
		#10
		data = 8'h54;
		key = 2'b10;
		#10
		data = 8'h45;
		key = 2'b10;
		#10
		data = 8'h52;
		key = 2'b10;
		#10
		data = 8'h50;
		key = 2'b10;
		#10
		data = 8'h41;
		key = 2'b10;
		#10
		data = 8'hFA;
		key = 2'b10;


		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

