-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- tb_srl_bs.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for proj_srl.vhd

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.textio.all;             -- For basic I/O


entity tb_srl_bs is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_srl_bs;

architecture mixed of tb_srl_bs is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component barrelshift_srl is
  port(i_shift      : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(31 downto 0);
       o_Q          : out std_logic_vector(31 downto 0));
end component;

signal CLK : std_logic := '0';
signal i_shift : std_logic_vector(4 downto 0);
signal i_D : std_logic_vector(31 downto 0);
signal o_Q : std_logic_vector(31 downto 0);

begin

DUT : barrelshift_srl
	port map (i_shift => i_shift,
		i_D => i_D,  
		o_Q => o_Q);

  
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
    -- output: FFFFFFFF
    i_shift <= "00000";
    i_D  <= x"FFFFFFFF";
    wait for cCLK_PER;

    -- output: 0
    i_shift <= "00010";
    i_D  <= x"FFFFFFFF";
    wait for cCLK_PER;

	-- output: 0
    --i_shift <= "";
    --i_D  <= x"FFFFFFFF";
    --wait for cCLK_PER;

	-- output: 00000000
    i_shift <= "11111";
    i_D  <= x"FFFFFFFF";
    wait for cCLK_PER;

    wait;
  end process;
end mixed;