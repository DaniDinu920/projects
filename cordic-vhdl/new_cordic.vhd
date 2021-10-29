library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity new_cordic is 
		generic(
			
				input_size : integer := 18;
				lut_depth_c : integer := 16;
				coordonate_v_depth : integer := 16;
				iteration_num : integer := 16;
				lut_width_c : integer := 18
		
		);
		
		port (
				
				clk : IN std_logic;
				rst : IN std_logic;
				en  :  IN std_logic;
				x_in : IN std_logic_vector (input_size -1 downto 0);
				y_in : IN std_logic_vector (input_size -1 downto 0);
				data_out_valid : out std_logic ;
				mag : out std_logic_vector (input_size - 1 downto 0);
				atan : out std_logic_vector (input_size - 1 downto 0)
		);


end new_cordic;

architecture Behavioral of new_cordic is

type state_type is (idle,start,sign_extension,cordic,add_k);
type LUT_t is array (0 to lut_depth_c - 1) of signed(lut_width_c - 1 downto 0);
type coordonate_array_t is array (0 to coordonate_v_depth - 1) of signed(input_size  downto 0);
type angle_array_t is array (0 to coordonate_v_depth - 1) of signed(input_size -1 downto 0);

constant K : signed (17 downto 0) := "001001101101110101";
constant cordic_lut_c : lut_t := (
   "001011010000000000","000110101001000010","000011100000100101","000001110010000000","000000111001001110","000000011100101000",
	"000000001110010100","000000000111001010","000000000011100101","000000000001110010","000000000000111001","000000000000011100",
	"000000000000001110","000000000000000111","000000000000000011","000000000000000001"
);
		
signal state : state_type := idle;
signal counter : integer := 0;
signal quad : std_logic_vector(1 downto 0);
signal X : coordonate_array_t := (others =>(others => '0'));
signal Y : coordonate_array_t := (others =>(others => '0'));
signal Z : angle_array_t := (others =>(others => '0'));

signal x_r : signed (input_size -1 downto 0);
signal y_r : signed (input_size -1 downto 0);

signal X_mult : signed(input_size + 18 downto 0);

begin


					cordic_process_vector_mode : process(clk,rst)
					begin
							if(rst = '1')then
								
									state <= idle; 
							elsif(rising_edge(clk))then
									
									case(state) is
										
										when idle =>
										
											for index in 0 to (coordonate_v_depth -1)
												loop
													X(index) <= (others => '0');
													Y(index) <= (others => '0');
													Z(index) <= (others => '0');
												end loop;
													if(en='1') then
														state <= start;
													else
														state <= idle;
													end if;
										when start =>
										
													x_r <= signed(x_in);
													y_r <= signed(y_in);
													z(0) <= (others => '0'); -- vector mode conditions
													state <= sign_extension;
													
										when sign_extension =>
										
													if (x_r(input_size -1) = '1') then
															if(y_r(input_size - 1) = '0')then
																
																quad <= "01";
																x(0) <= (not('1' & x_r) + "1");
																y(0) <= (not('0' & y_r) + "1");
																state <= cordic;
																
															else
																
																quad <= "10";
																x(0) <= (not('0' & x_r) + "1");
																y(0) <= (not('1' & y_r) + "1");
																state <= cordic;
																
															end if;
																
													else
															if (y_r(input_size -1) = '0' ) then
															
																quad <= "00";
																x(0) <= ('0' & x_r);
																y(0) <= ('0' & y_r);
																state <= cordic;
															
															else
																
																quad <= "11";
																x(0) <= ('0' & x_r);
																y(0) <= ('1' & y_r);
																state <= cordic;
															
															
															end if;

													end if;
													
													
													
													when cordic =>
													
													
															generare_pipelined_mode : for index in 0 to lut_depth_c  -2 loop
																if(Y(index)< 0) then
																
																	X(index + 1) <= X(index) - (shift_right((Y(index)),index));
																	Y(index + 1) <= Y(index) + (shift_right((X(index)),index));
																	Z(index + 1) <= Z(index) - cordic_lut_c(index);
																	
																else
																
																	X(index + 1) <= X(index) + (shift_right((Y(index)),index));
																	Y(index + 1) <= Y(index) - (shift_right((X(index)),index));
																	Z(index + 1) <= Z(index) + cordic_lut_c(index);
																	
																	
																end if;
																
															end loop generare_pipelined_mode;
															
															
															if(counter < iteration_num -1) then
															
																counter <= counter + 1;
																else 
																state <= add_K;
																counter <= 0;
																
															end if;
															
													when add_k =>
													
																						
																		data_out_valid <= '1';
																		x_mult <= K * X(coordonate_v_depth -1);
													
													when others =>
													
														state <= idle;
																						
													
													
											
										
									end case;
							end if;
					
					
					end process cordic_process_vector_mode;
					
					
mag <= std_logic_vector(x_mult(33 downto 16));

atan <= std_logic_vector(Z(coordonate_v_depth - 1)(input_size - 1 downto 0) + "001000000000000000") when quad = "01" else
		  std_logic_vector(Z(coordonate_v_depth - 1)(input_size - 1 downto 0) - "001000000000000000")  when quad = "10" else
		  std_logic_vector(Z(coordonate_v_depth - 1)(input_size - 1 downto 0)); 



end Behavioral;


