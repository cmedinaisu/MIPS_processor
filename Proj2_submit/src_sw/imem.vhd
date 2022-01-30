-- Patrick Bruce

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity imem is
	port(
		clk	: in std_logic;
		iRA : in std_logic_vector(9 downto 0);
		oI	: out std_logic_vector(31 downto 0));
end imem;

architecture structural of imem is

component mem is
	generic (
		DATA_WIDTH 	: natural := 32;
		ADDR_WIDTH 	: natural := 10);

	port(
		clk		: in std_logic;
		addr	: in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
		we		: in std_logic := '1';
		q		: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

signal s_data	        : std_logic_vector((32-1) downto 0) := x"00000000";
signal s_we		: std_logic := '0';

begin
  MEM0: mem
  generic map(
	DATA_WIDTH => 32,
	ADDR_WIDTH => 10)
  port map( 
	clk 	=> CLK,
	addr	=> iRA,
	data	=> s_data,
	we		=> s_we,
	q		=> oI);
	
end structural;

