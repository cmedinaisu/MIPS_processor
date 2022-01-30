-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_SLL2_26t28.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the shift by 2 26 bit.
--              
-- 03/09/2021 by Patrick Bruce.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_SLL2_26t28 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_SLL2_26t28;

architecture structural of tb_SLL2_26t28 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component SLL2_26t28 is
  port(
       iD               : in std_logic_vector(25 downto 0);
       oQ               : out std_logic_vector(27 downto 0));
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_iD : std_logic_vector(25 downto 0) := "00000000000000000000000000";
signal s_oQ	: std_logic_vector(27 downto 0) := "0000000000000000000000000000";

begin

SLL0: SLL2_26t28
 port map (	
	iD		=> s_iD,
	oQ		=> s_oQ);

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

    -- Test case 1:
    s_iD   		<= "00000000000000000000000001";
    wait for gCLK_HPER*2;

    -- Test case 2:
    s_iD   		<= "11000000000000000000000001";
    wait for gCLK_HPER*2;

    -- Test case 3:
    s_iD   		<= "00000000000000000000000101";
    wait for gCLK_HPER*2;
	
	    -- Test case 4:
    s_iD   		<= "00000000010000000000000001";
    wait for gCLK_HPER*2;

    -- Test case 5:
    s_iD   		<= "10000000000000000000000001";
    wait for gCLK_HPER*2;

    -- Test case 6:
    s_iD   		<= "00000000000000001000000001";
    wait for gCLK_HPER*2;

  end process;

end structural;