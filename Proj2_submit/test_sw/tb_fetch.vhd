-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_fetch.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the fetch.
--              
-- 01/03/2020 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_fetch is
  generic(gCLK_HPER   : time := 10 ns);   
end tb_fetch;

architecture mixed of tb_fetch is

constant cCLK_PER  : time := gCLK_HPER * 2;

component fetch is
  port( 
	CLK				: in std_logic;
	iReset			: in std_logic;
	iJumpCtrl		: in std_logic;
	iJumpAddress	: in std_logic_vector(25  downto 0);
	iBranchCtrl		: in std_logic;
	iZero			: in std_logic;
	iBranchAmount	: in std_logic_vector(31 downto 0);
	oPC				: out std_logic_vector(31 downto 0));
end component;

signal CLK, reset 	: std_logic := '0';
signal s_iReset		: std_logic := '0';
signal s_iJumpCtrl		: std_logic := '0';
signal s_oPC		: std_logic_vector((32 -1) downto 0);
signal s_iJumpCtrlAddress		: std_logic_vector(25 downto 0);
signal s_iBranchCtrl	: std_logic	:= '0';
signal s_iZero		: std_logic := '0';
signal s_iBranchAmount	: std_logic_vector(31 downto 0)	:= X"00000000";

begin
  FETCH0: fetch
  port map(
	clk 			=> CLK,
	iReset			=> s_iReset,
	iJumpCtrl		=> s_iJumpCtrl,
	iJumpAddress	=> s_iJumpCtrlAddress,
	iBranchCtrl		=> s_iBranchCtrl,
	iZero			=> s_iZero,
	iBranchAmount	=> s_iBranchAmount,
	oPC				=> s_oPC);


  
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
    wait for gCLK_HPER*2;
	s_iReset	<= '1';
	wait for gCLK_HPER*2;
	s_iReset	<= '0';
	s_iJumpCtrl		<= '0';
	s_iJumpCtrlAddress	<= "00000000000000000000000000";
	s_iBranchCtrl	<= '0';
	s_iZero		<= '0';
	s_iBranchAmount	<= X"00000000";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	s_iReset	<= '0';
	s_iJumpCtrl		<= '0';
	s_iJumpCtrlAddress	<= "00000000000000000000000000";
	s_iBranchCtrl	<= '1';
	s_iZero		<= '1';
	s_iBranchAmount	<= X"0000000F";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	s_iReset	<= '0';
	s_iJumpCtrl		<= '1';
	s_iJumpCtrlAddress	<= "00000000000000000000000001";
	s_iBranchCtrl	<= '1';
	s_iZero		<= '1';
	s_iBranchAmount	<= X"0000000F";
	wait for gCLK_HPER*2;
	wait for gCLK_HPER*2;
	s_iReset	<= '1';
	wait for gCLK_HPER*2;
	s_iReset	<= '0';
	wait for gCLK_HPER*2;
	
	
	wait for gCLK_HPER/2;
  end process;

end mixed;