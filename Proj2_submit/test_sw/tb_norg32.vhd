library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_norg32 is
  generic(gCLK_HPER   : time := 10 ns);
end tb_norg32;

architecture structural of tb_norg32 is

	constant cCLK_PER  : time := gCLK_HPER * 2;

	component norg32 is
	  port(	i_A   	: in std_logic_vector(31 downto 0);
			o_F    	: out std_logic);
	end component;

	signal CLK, reset 	: std_logic := '0';
	signal s_iA   		: std_logic_vector(31 downto 0);
	signal s_oF    		: std_logic := '0';
	
begin

	DUT: norg32
	port map(	
			i_A	=> s_iA,
			o_F	=> s_oF);

	P_CLK: process
	begin
		CLK <= '1';         -- clock starts at 1
		wait for gCLK_HPER; -- after half a cycle
		CLK <= '0';         -- clock becomes a 0 (negative edge)
		wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
	end process;
	
	P_RST: process
	begin
		reset <= '0';   
		wait for gCLK_HPER/2;
		reset <= '1';
		wait for gCLK_HPER*2;
		reset <= '0';
	wait;
	end process; 
	
	P_Test_Cases: process
	begin
		wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges
		
		s_iA	<= X"00000000";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000001";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000002";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000003";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000004";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000005";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000000";
		wait for gCLK_HPER*2;
		
		s_iA	<= X"00000006";
		wait for gCLK_HPER*2;
		
	end process;

end structural;