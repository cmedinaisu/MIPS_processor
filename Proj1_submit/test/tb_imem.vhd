-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_imem.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the imem.
--              
-- 04/10/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of dmem to reflect the new testbench.
entity tb_imem is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_imem;

architecture mixed of tb_imem is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component imem is
	port(
		clk	: in std_logic;
		iRA : in std_logic_vector(9 downto 0);
		oI	: out std_logic_vector(31 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';
signal s_addr	        : std_logic_vector((10-1) downto 0) := "0000000000";
signal s_q		: std_logic_vector((32 -1) downto 0);

begin
  MEM0: imem
  port map( 
	clk 	=> CLK,
	iRA		=> s_addr,
	oi		=> s_q);
  
  --This first process is to setup the clock for the test bench
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
  

  P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges
	
    -- writes to $0x100
	s_addr	<= "0000000000";
    wait for gCLK_HPER*2;
	s_addr	<= "0000000001";
	wait for gCLK_HPER*2;
	s_addr	<= "0000000010";
	wait for gCLK_HPER*2;
	s_addr	<= "0000000011";
	wait for gCLK_HPER*2;
	s_addr	<= "0000000100";
	wait for gCLK_HPER*2;
	s_addr	<= "0000000101";
	wait for gCLK_HPER*2;
	
  end process;

end mixed;