----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:22:24 04/16/2021 
-- Design Name: 
-- Module Name:    RS232-tranciever - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


-- Clk_divider = (board_frequency)/(desire_baud_rate)

entity RS232 is
	generic ( Clk_divider : integer := 10416 
	);
	port(
	clk : in std_logic;
	char : in std_logic_vector (7 downto 0);
	trx_port : out std_logic ;
	reset : in std_logic;
	enable : in std_logic);

end RS232;

architecture Behavioral of RS232 is

	type state_type is (idle,start,sending,stop);
	signal i_count : unsigned ( 2 downto 0) := "000"; -- counter cadru
	signal state : state_type := idle;
	signal frame : std_logic_vector (7 downto 0) := (others => '0');
	signal clk_counter : integer range 0 to clk_divider-1 :=0;
	signal frame_index : integer range 0 to 7 := 0; --un cadru are 8 biti
	signal start_trans : std_logic := '0';
	signal load       : std_logic := '0';
	signal load_debounce : std_logic := '0';
	signal baud_rate : std_logic := '0';
	signal trx_reg : std_logic := '0';
	
begin

	--	clock_divider : process (clk,reset)
		--begin
			--if (reset = '1') then
				--clk_counter <= 0;
				--baud_rate <= '0';
			--elsif (rising_edge(clk)) then
				--if ( clk_counter < clk_divider - 1) then
					--clk_counter <= clk_counter + 1;
				--else
					--baud_rate <= not baud_rate;
					--clk_counter <= 0;
			
				--end if;
				
			
		--	end if;
			
		--end process clock_divider;

		tranx_proc : process (clk,reset)
		begin
				
		
			if (rising_edge(clk))then
			
				case state is
					when idle => 
						trx_reg    <= '1';
						frame_index <= 0; 
						clk_counter <= 0;
						frame <= (others => '0');
					if (start_trans = '1') then
						frame <= char;
						state <= start;
					else
						state <= idle;
					end if;
					
					when start =>
						trx_reg   <= '0';
						if(clk_counter < clk_divider - 1)then
							clk_counter <= clk_counter + 1;
							state <= start ;
						else
							state  <= sending;
							clk_counter <= 0;
						end if;
						
					when sending =>
						trx_reg <= frame(frame_index);
						if(clk_counter < clk_divider - 1)then
							clk_counter <= clk_counter + 1;
							state <= sending;
							else
							clk_counter <= 0;
							if ( frame_index < 7) then
								frame_index <= frame_index + 1;
								state <= sending;
							else
								frame_index <= 0;
								state <= stop;
							end if;
						end if;
						
					when stop =>
						trx_reg <= '1';
						if(clk_counter < clk_divider - 1)then
							clk_counter <= clk_counter + 1;
						else 
							clk_counter <= 0;
							state       <= idle;
						end if;
						
					when others =>
						state <= idle;
						
				end case;
				
			
			end if;
		
		
		end process tranx_proc;
		
		trx_port <= trx_reg;
		start_trans <= load and (not load_debounce);
		
		debounce_filter : process(clk)
		begin
			if (rising_edge(clk)) then
				if(reset = '1')then
					load <= '0';
					load_debounce <= '0';
				else
					load <= enable;
					load_debounce <= load;
				end if;
			end if;
		end process debounce_filter;


end Behavioral;

