`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:08:47 02/11/2021
// Design Name:   scl_clk
// Module Name:   C:/verilog/I2C/I2C/TB_scl_clk.v
// Project Name:  I2C
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: scl_clk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TB_scl_clk;

	// Inputs
	reg clk;

	// Outputs
	wire scl;
	wire scl1;
	wire scl2;

	// Instantiate the Unit Under Test (UUT)
	scl_clk uut (
		.clk(clk), 
		.scl(scl),
		.scl1(scl1),
		.scl2(scl2)
	);
	
	initial begin
	clk = 1'b0;
	forever#5 clk=~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

