-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_norOP.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for proj_nor.vhd

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;

use std.textio.all;             -- For basic I/O


entity tb_norOP is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_norOP;

architecture mixed of tb_norOP is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component proj_nor is
  port(i_A          : in std_logic_vector(31 downto 0);
       i_B          : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
end component;

signal CLK : std_logic := '0';
signal i_A : std_logic_vector(31 downto 0);
signal i_B : std_logic_vector(31 downto 0);
signal o_O : std_logic_vector(31 downto 0);

begin

DUT : proj_nor
	port map (i_A => i_A,
		i_B => i_B,  
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
    -- output: 0x0000FFFF
    i_A <= x"FFFF0000";
    i_B  <= x"00000000";
    wait for cCLK_PER;

    -- output: 0x55555555
    i_A <= x"AAAAAAAA";
    i_B  <= x"AAAAAAAA";
    wait for cCLK_PER;

	-- output: 0x00000000
    i_A <= x"FF003300";
    i_B  <= x"FFFFFFFF";
    wait for cCLK_PER; 

    wait;
  end process;
end mixed;