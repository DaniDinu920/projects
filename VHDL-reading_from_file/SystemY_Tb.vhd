library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- Convert std_logic to text and reverse

library STD;
use STD.textio.all; -- Capabilities to write to a file

entity SystemY_Tb is

end entity;

architecture sim of SystemY_Tb is

	-- Declarative zone of VHDL
	
	-- Constant declaration
	constant t_wait : time := 100 ns;
	
	-- Component declaration
	component SystemY is
		port(
			ABC : in  std_logic_vector(2 downto 0);
			F   : out std_logic
		);
	end component;

	-- Signal declaration
	signal ABC_TB : std_logic_vector(2 downto 0);
	signal F_TB   : std_logic;
	
begin

	uut : SystemY
		port map(
		ABC => ABC_TB,
		F   => F_TB
		);
		
	-- Stimulus generation
	Stimulus : process is

		-- File that we read
		file Fin : TEXT open READ_MODE is "input_vector.txt";
	
		variable current_read_line  : line; -- line by line reading from file
		variable current_read_field : std_logic_vector(2 downto 0);  -- After we read the line, we need to read from the line
		
		variable current_write_line : line; -- STD_OUTPUT
		
		file Fout : TEXT open WRITE_MODE is "output_file.txt";
		variable current_line : line;
		
	begin
		
		-- Testbench code here --
		
		while(not endfile(Fin)) loop
		
			-- Read setup
			readline(Fin, current_read_line);
			read(current_read_line, current_read_field); -- 000 from file to std_logic_vector
			ABC_TB <= current_read_field; wait for t_wait;
			
			-- Write setup to external file
			write(current_write_line, string'("Input file vector ABC_TB= "));
			write(current_write_line, ABC_TB);
			write(current_write_line, string'(" File Output F_TB= "));
			write(current_write_line, F_TB);
			writeline(Fout, current_write_line);
			
			-- Write setup to tcl
			write(current_write_line, string'("Input console vector ABC_TB= "));
			write(current_write_line, ABC_TB);
			write(current_write_line, string'(" Console Output F_TB= "));
			write(current_write_line, F_TB);
			writeline(OUTPUT, current_write_line);
			
		end loop;
		
		wait;
		
	end process Stimulus;

end architecture sim;