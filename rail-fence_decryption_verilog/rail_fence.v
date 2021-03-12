`timescale 1ns / 1ps
module rail_fence(clk,reset,data,data_c,key,busy
    );
	 
	 input clk;
	 input reset;
	 input [7:0] data;
	 input [1:0] key;
	 reg en=1'b1;
	 
	 reg [399:0] data_i=400'b0;
	 reg [7:0] data_r=8'b0;
	 reg [7:0] count1 = 8'b0; 
	 reg [7:0] count=8'b0;
	 integer index1;
	 integer index2;
	 reg [2:0] step=3'b0;
	 reg valid_i=1'b1;
	 
	 output [7:0] data_c;
	 output busy;
	 parameter [2:0] start_decriptare1 = 3'b001;
	 parameter [2:0] start_decriptare2 = 3'b010;
	 
	 
	 always @(posedge clk) begin
		
		if(valid_i)begin
			data_i[399:0] <= {data_i[392:0],data[7:0]};
			count <= count + 1'b1;
				index1 <= count;
				index2 <= (count>>1);
		end
		if (count == 8'b00110010) begin
			valid_i <= 1'b0;
		end
		if ((data_i[7:0]==8'b11111010)&&(key == 2'b10)&&(en))begin
				step <=start_decriptare1;
				valid_i <= 1'b0;
				en <= 1'b0;
			end
			//if((data_i[7:0]==8'b11111010)&&(key == 2'b11))begin
				//step <= start_decriptare2;
				//valid_i <= 1'b0;
				//index1 <= count;
				//index2 <= (count>>1);
			//end
			
		case (step) 
		//initializare_index : begin
			//end
		start_decriptare1 : begin
			data_r <= data_i[8*index1+:8];
			index1 <= index1 - 1'b1;
			count1 <= count1 + 1'b1;
			if ((index1 == 0) || (index2==0))
				step <= 3'b111;
				else 
				step <= start_decriptare2;
			end
		start_decriptare2 : begin
			data_r <= data_i[8*index2+:8];
			index2 <= index2 - 1'b1;
			count1 <= count1 + 1'b1;
			if ((index1 == 0) || (index2==0))
				step <= 3'b111;
				else 
				step <= start_decriptare1;
			end
			
		   endcase
		
	end
	
assign data_c = data_r;

endmodule
