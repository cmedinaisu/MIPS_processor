-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_ALUC.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for tb_ALUC.vhd

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;

use std.textio.all;             -- For basic I/O


entity tb_ALUC is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_ALUC;

architecture mixed of tb_ALUC is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component ALU_Control is
  port(ALUOp : in std_logic_vector(3 downto 0);
		Funct : in std_logic_vector(5 downto 0);
		ALUControl : out std_logic_vector(3 downto 0));
end component;

signal CLK : std_logic := '0';
signal Funct : std_logic_vector(5 downto 0);
signal ALUOp : std_logic_vector(3 downto 0);
signal ALUControl : std_logic_vector(3 downto 0);

begin

DUT : ALU_Control
	port map (ALUOp => ALUOp,
		Funct => Funct,
		ALUControl => ALUControl);

  
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
	-- adding(lw, sw, addi)
    ALUOp <= "0010";
	Funct <= "XXXXXX";
    wait for cCLK_PER;
	
	-- andi
    ALUOp <= "0000";
	Funct <= "XXXXXX";
    wait for cCLK_PER;
	
	-- R-Type: add
    ALUOp <= "1111";
	Funct <= "100000";
    wait for cCLK_PER;
	
	-- R-Type: nor
    ALUOp <= "1111";
	Funct <= "100111";
    wait for cCLK_PER;
	
	-- R-Type: slt
    ALUOp <= "1111";
	Funct <= "101010";
    wait for cCLK_PER;
	
	-- NONE
    ALUOp <= "1000";
	Funct <= "000000";
    wait for cCLK_PER;

    wait;
  end process;
end mixed;