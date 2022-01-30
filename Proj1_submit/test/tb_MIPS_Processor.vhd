-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the MIPS_Processor.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_MIPS_Processor is
  generic(gCLK_HPER   : time := 10 ns);   
end tb_MIPS_Processor;

architecture mixed of tb_MIPS_Processor is

constant cCLK_PER  : time := gCLK_HPER * 2;

component MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0));
end component;

signal CLK, reset 	: std_logic := '0';
signal s_iRST		: std_logic := '0';
signal s_iInstLd	: std_logic := '0';
signal s_iInstAddr	: std_logic_vector(31 downto 0) := X"00000000";
signal s_iInstExt	: std_logic_vector(31 downto 0) := X"00000000";
signal s_oALUOut	: std_logic_vector(31 downto 0) := X"00000000";

begin
  MIPS_Processor0: MIPS_Processor
  generic map (
		N			=> 32)
  port map(
		iCLK		=> CLK,
		iRST        => s_iRST,
		iInstLd     => s_iInstLd,
		iInstAddr   => s_iInstAddr,
		iInstExt    => s_iInstExt,
		oALUOut     => s_oALUOut);


  
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
	s_iRST <= '1';
    wait for gCLK_HPER*2;
	s_iRST <= '0';
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
  end process;

end mixed;