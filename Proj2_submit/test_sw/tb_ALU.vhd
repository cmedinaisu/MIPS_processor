-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the test bench for the ALU.vhd file
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O

-- Usually name your testbench similar to below for clarity tb_<name>
-- TODO: change all instances of tb_TPU_MV_Element to reflect the new testbench.
entity tb_ALU is
  generic(gCLK_HPER : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ALU;

architecture mixed of tb_ALU is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;
constant N : integer := 32;

component ALU is
	generic(N : integer := 32);
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		ALUControl : in std_logic_vector(3 downto 0);
		ALU_Out : out std_logic_vector(31 downto 0);
		Zero : out std_logic := '0';
		Overflow : out std_logic := '0');
end component;

signal CLK, reset : std_logic := '0';
signal s_A : std_logic_vector(31 downto 0);
signal s_B : std_logic_vector(31 downto 0);
signal s_ALUControl : std_logic_vector(3 downto 0);
signal s_ALU_Out : std_logic_vector(31 downto 0);
signal s_Zero : std_logic := '0';
signal s_Overflow : std_logic := '0';

begin

DUT: ALU
	generic map( N => N )
	port map (
			A => s_A,
			B => s_B,
			ALUControl => s_ALUControl,
			ALU_Out => s_ALU_Out,
			Zero => s_Zero,
			Overflow => s_Overflow);
			
  --This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
  
  
    P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- Test case:
	-- adding 15 and 2
	s_A <= x"0000000F";
	s_B <= x"00000002";
	s_ALUControl <= "0010";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- check overflow
	s_A <= x"7FFFFFFF";
	s_B <= x"7FFFFFFF";
	s_ALUControl <= "0010";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- check no overflow
	s_A <= x"7FFFFFFF";
	s_B <= x"7FFFFFFF";
	s_ALUControl <= "0011";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- check zero
	s_A <= x"0000000F";
	s_B <= x"0000000F";
	s_ALUControl <= "0110";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- s_AND output = 0xs_AAAAAAAA
	s_A <= x"AAAAAAAA";
	s_B <= x"FFFFFFFF";
	s_ALUControl <= "0000";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- OR output = 0xFFFFFFFF
	s_A <= x"AAAAAAAA";
	s_B <= x"FFFFFFFF";
	s_ALUControl <= "1110";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- XOR output = 0xFFFFFFFF
	s_A <= x"AAAAAAAA";
	s_B <= x"55555555";
	s_ALUControl <= "1101";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- NOR output = 0x00000000
	s_A <= x"AAAAAAAA";
	s_B <= x"55555555";
	s_ALUControl <= "1100";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- SLT A < B output = 0
	s_A <= x"0000000A";
	s_B <= x"00000005";
	s_ALUControl <= "0111";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- SLT A < B output = 1
	s_A <= x"00000001";
	s_B <= x"00000005";
	s_ALUControl <= "0111";
    wait for gCLK_HPER*2;
	
	-- Test case:
	-- undefined
	s_A <= x"00000001";
	s_B <= x"00000005";
	s_ALUControl <= "1111";
    wait for gCLK_HPER*2;

end process;
end mixed;
