-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_lui_op.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the test bench for the ALU.vhd file
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O


entity tb_lui_op is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_lui_op;

architecture mixed of tb_lui_op is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component proj_lui is
  port(i_A : in std_logic_vector(15 downto 0);-- immediate value being loaded into the register
	o_O : out std_logic_vector(31 downto 0));
end component;

signal CLK : std_logic := '0';
signal i_A : std_logic_vector(15 downto 0);
signal o_O : std_logic_vector(31 downto 0);

begin

DUT : proj_lui
	port map (i_A => i_A,  
		o_O => o_O);
		
		
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
  
    -- Testbench process  
  P_TB: process
  begin
	wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges
  
    -- output: 0xFFFF0000
    i_A <= x"FFFF";
    wait for cCLK_PER;
	
	-- output: 0x00000000
    i_A <= x"0000";
    wait for cCLK_PER;
	
	-- output: 0x06600000
    i_A <= x"0660";
    wait for cCLK_PER;
	
	
	end process;
end mixed;