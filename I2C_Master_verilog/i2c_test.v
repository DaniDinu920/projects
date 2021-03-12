`timescale 1ns / 1ps


module i2c_test;

	// Inputs
	reg clk;
	reg reset;
	reg w_enable;
	reg en_rx;
	reg r_i2c_sda;

	// Outputs
	wire i2c_sc1;

	// Bidirs
	wire i2c_sda;

	// Instantiate the Unit Under Test (UUT)
	I2C uut (
		.clk(clk), 
		.reset(reset), 
		.i2c_sda(i2c_sda), 
		.i2c_sc1(i2c_sc1),
		.en_rx(en_rx),
		.w_enable(w_enable)
	);

	initial begin
	clk = 1'b0;
	forever #5 clk=~clk;
	end




	initial begin
	
	reset <= 1'b1;
	w_enable <= 1'b1;
	en_rx <= 1'b1;
	#345
	reset <= 1'b0;
	en_rx <= 1'b1;
	#200
	en_rx <= 1'b0;
	r_i2c_sda <= 1'b0;
	#20
	en_rx <= 1'b1;
	r_i2c_sda <= 1'bz;
	#180
	en_rx <= 1'b0;
	r_i2c_sda <= 1'b0;
	#20
	en_rx <= 1'b1;
	r_i2c_sda <= 1'bz;
	#180
	en_rx <= 1'b0;
	r_i2c_sda <= 1'b0;
	#20
	en_rx <= 1'b1;
	r_i2c_sda <= 1'bz;

	end
	
assign i2c_sda = (!en_rx) ? r_i2c_sda : 8'bz;
      
endmodule

