library IEEE;
use ieee.std_logic_1164.all;

entity SystemY is
	port(
		ABC : in  std_logic_vector(2 downto 0);
		F   : out std_logic
	);
end entity;

architecture rtl of SystemY is

	-- Declarative zone of VHDL

begin

	SystemY_Proc : process(ABC) is		
	begin
		case(ABC) is
			when "001" | "100" | "101" =>
				F <= '1';
			when others =>
				F <= '0';
		end case;
	end process;

end architecture rtl;