-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_ControlLM.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for tb_ControlLM.vhd

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;

use std.textio.all;             -- For basic I/O


entity tb_ControlLM is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ControlLM;

architecture mixed of tb_ControlLM is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component Control_Logic_Module is
generic(N : integer := 32);
  port(	iOpcode 	: in std_logic_vector(5 downto 0);
		oMemRead 	: out std_logic;
		oMemWrite 	: out std_logic;
		oMemtoReg 	: out std_logic;
		oJump 		: out std_logic;
		oBranch 	: out std_logic;
		oALUOp 		: out std_logic_vector(3 downto 0);
		oALUSrc 	: out std_logic;
		oRegDst 	: out std_logic;
		oRegWrite 	: out std_logic;
		oHalt		: out std_logic);
end component;

signal 	CLK 		: std_logic := '0';
signal 	s_iOpcode 	: std_logic_vector(5 downto 0) := "000000";
signal	s_oMemRead 	: std_logic := '0';
signal	s_oMemWrite : std_logic := '0';
signal 	s_oMemtoReg : std_logic := '0';
signal	s_oJump 	: std_logic := '0';
signal	s_oBranch 	: std_logic := '0';
signal	s_oALUOp 	: std_logic_vector(3 downto 0) := "0000";
signal	s_oALUSrc 	: std_logic := '0';
signal	s_oRegDst 	: std_logic := '0';
signal	s_oRegWrite : std_logic := '0';
signal	s_oHalt	: std_logic := '0';

begin

DUT : Control_Logic_Module
	port map (iOpcode 	=> s_iOpcode,
		oMemRead 		=> s_oMemRead,
		oMemWrite 		=> s_oMemWrite,
		oMemtoReg 		=> s_oMemtoReg,
		oJump 			=> s_oJump,
		oBranch 		=> s_oBranch,
		oALUOp 			=> s_oALUOp,
		oALUSrc 		=> s_oALUSrc,
		oRegDst 		=> s_oRegDst,
		oRegWrite 		=> s_oRegWrite);

  
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
    -- R-Type
    s_iOpcode <= "000000";
    wait for cCLK_PER;
	
	-- addi
	s_iOpcode <= "001000";
	wait for cCLK_PER;

	-- lw
    s_iOpcode <= "100011";
    wait for cCLK_PER;

	-- sw
	s_iOpcode <= "101011";
    wait for cCLK_PER; 
	
	-- beq
	s_iOpcode <= "000100";
    wait for cCLK_PER; 
	
	-- j
	s_iOpcode <= "000010";
    wait for cCLK_PER;

    wait;
  end process;
end mixed;