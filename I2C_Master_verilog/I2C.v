module I2C(
	input wire clk,
	input wire reset,
	inout  i2c_sda,
	output  i2c_sc1,
	input en_rx,
	input w_enable
	);
	
	
	reg r_i2c_sda;
	reg [3:0] state=4'b0000;
	reg [3:0] frame_count;
	reg [3:0] bits_count;
	reg [6:0] r_add; // adresa slave-ului
	reg r_w_byte;
	reg [6:0] r_sda = 7'b0;
	reg [7:0] r_data = 8'b0;	
	reg [7:0] reg_addr = 8'b0; // adresa registrului din care citeste
	reg [7:0] receive_data = 8'b0; // registrul in care sunt memorate datele de la slave
	reg stop_bit = 1'b1;
	reg [1:0] en_scl = 2'b00;
	
	wire scl;
	wire scl1;
	wire scl2;
	
	parameter [3:0] idle = 4'b0001;
	parameter [3:0] start = 4'b0010;
	parameter [3:0] transmisie = 4'b0011;
	parameter [3:0] transmisie_addr_reg = 4'b0100;
	parameter [3:0] receptie = 4'b0101;
	
	scl_clk Clock(.clk(clk),.scl(scl),.scl1(scl1),.scl2(scl2));
	
	always @(posedge scl2)begin
	
		if(reset)begin
			state <= idle;
			frame_count <= 4'b0;
			bits_count <= 4'b0;
			
		end
		
		case(state)
		
		
			idle:begin
				
				r_i2c_sda <= 7'b1;
				r_add <= 7'b1010101; // adresa slave-ului
				bits_count <= 4'b0;
				r_data <= 8'b10101101;
				reg_addr <= 8'b11101011;
				if (frame_count == 1'b0)
					state <= start;
			
			end
			
			start:begin
			
				bits_count <= bits_count + 1'b1;
				
				if (bits_count == 4'b0)
				
					r_i2c_sda <= 1'b0;
					
				else if(bits_count > 4'b0000 && bits_count < 4'b1000) begin
				
					r_i2c_sda <= r_add[6];
					r_add <= {r_add[5:0],1'b0};
					
				end
				else if( bits_count == 4'b1000 && frame_count == 4'b0000)
				
						r_i2c_sda <=  1'b0 ;
						
				else if( bits_count == 4'b1000 && frame_count > 4'b0000)
						
						r_i2c_sda <= ( w_enable == 1'b1 ? 1'b0 : 1'b1);
				
				else if ( bits_count == 4'b1010 && i2c_sda == 1'b0) begin
				
						state <= transmisie_addr_reg;
						bits_count <= 4'b0;
						frame_count <= frame_count + 1'b1;
						
				end
				
				else if ( bits_count == 4'b1010 && i2c_sda == 1'b0 && w_enable == 1'b0) begin
				
						state <= receptie;
						bits_count <= 4'b0;
						frame_count <= frame_count + 1'b1;
						
					end
				
				end
				
				transmisie : begin // transmisie date
					
					bits_count <= bits_count + 1'b1;
					
					
				if(bits_count >= 4'b0000 && bits_count < 4'b1000) begin
				
					r_i2c_sda <= r_data[7];
					r_data <= {r_data[6:0],1'b0};
				
				end
				
				else if(bits_count == 4'b1001 && i2c_sda == 1'b0) begin
				
					frame_count <= frame_count + 1'b1;
					r_i2c_sda <= stop_bit;
					
					
					end
				
				end
				
				transmisie_addr_reg : begin // transmisie adresa registru
					
					bits_count <= bits_count + 1'b1;
						
				if( bits_count >= 4'b0000 && bits_count < 4'b1000) begin
				
					r_i2c_sda <= reg_addr[7];
					reg_addr <= {reg_addr[6:0],1'b0};
				
				end
				
				else if(bits_count == 4'b1001 && i2c_sda == 1'b0 && w_enable == 1'b1 ) begin
				
					state <= transmisie;
					frame_count <= frame_count + 1'b1;
					bits_count <= 4'b0;
				
				end
				
				else if(bits_count == 4'b1001 && i2c_sda == 1'b0 && w_enable == 1'b0) begin
				
					state <= start;
					frame_count <= frame_count + 1'b1;
					bits_count <= 4'b0;
				
					end
				
				end
				
				receptie : begin // receptie date
					
				if (bits_count < 4'b1000 && i2c_sda != 1'bz) begin
				
						bits_count <= bits_count + 1'b1;
						receive_data <= {receive_data[6:0], i2c_sda};
						
				end
				
				if (bits_count == 4'b1000) begin
					
						r_i2c_sda <= 1'b0;
						bits_count <= 4'b0000;
						
				end
				
				end
				
				
			
			
		endcase
	
	
		
		end
		
		always @(posedge scl) begin
		
			case(state)
				
				idle: en_scl <= 2'b01;
				start: en_scl <= (bits_count < 4'b0001 ?  2'b01 : (bits_count == 4'b0001 ? 2'b10 : 2'b11));
				transmisie: en_scl <= (bits_count == 4'b1001 ? 2'b01 : 2'b11);
			
			
			endcase
		
		end
		
assign i2c_sda =  (en_rx)  ?   r_i2c_sda : 8'bz;
assign i2c_scl = (en_scl == 2'b01 ? 1'b1 : (en_scl == 2'b10 ? 1'b0 : (en_scl == 2'b11 ? scl : 1'b1)));
	
endmodule
