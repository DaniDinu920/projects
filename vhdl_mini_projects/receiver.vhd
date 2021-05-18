----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:29:08 04/26/2021 
-- Design Name: 
-- Module Name:    receiver - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity receiver is generic(
			clk_divider : integer := 10416);
		port ( 
			clk : IN std_logic;
			rx_port : IN std_logic;
			char : out std_logic_vector (7 downto 0)
			--reset : in std_logic
		);
end receiver;

architecture Behavioral of receiver is
		
		type state_type is (idle,start,receive,stop);
		signal state : state_type := idle;
		signal clk_counter : integer range 0 to clk_divider-1;
		signal baud_rate : std_logic := '0';
		signal frame : std_logic_vector ( 7 downto 0) := ( others => '0');
		signal frame_index : integer range 0 to 7 := 0;

begin

		baud_rate_proc : process (clk,state)
		begin
			if((rising_edge(clk)) AND (state /= idle))then
				baud_rate <= '0';
					if( clk_counter < clk_divider - 1) then
						clk_counter <= clk_counter + 1;
					else
						baud_rate <= '1';
						clk_counter <= 0;
					end if;
			end if;
		end process baud_rate_proc;
		
		receive_proc : process (clk)
		begin
			if (rising_edge(clk)) then
				 case (state) is
				 
					when idle =>
						frame_index <= 0;
						if ( rx_port = '0') then
							state <= start;
						else 
							state <= idle;
						end if;
					
					when start =>
						if (baud_rate = '1') then
							if (rx_port = '0') then
								state <= receive;
							else 
								state <= idle;
							end if;
						else
							state <= start;
						end if;
						
					when receive =>
						frame (frame_index) <= rx_port;
						if ( baud_rate = '1') then
							if ( frame_index < 7) then
								frame_index <= frame_index + 1;
								state <= receive;
							else
								state <= stop;
							end if;
						else
							state <= receive;
						end if;
						
					when stop =>
						if ( baud_rate = '1') then
							state <= idle;
						else 
							state <= stop;
						end if;
					
					when others =>
						state <= idle;
						
				 end case;
				
			end if;
		
		end process receive_proc;

	char <= frame;
end Behavioral;

