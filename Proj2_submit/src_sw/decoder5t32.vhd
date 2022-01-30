-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- decoder5t32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 5:32
-- decoder using dataflow VHDL.
--
--
-- NOTES:
-- 3/9/21 by Patrick Bruce
-------------------------------------------------------------------------

-- Library Declarations
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity 
entity decoder5t32 is
 port (	D_IN	: in	std_logic_vector(4 downto 0);
	F_OUT	: out	std_logic_vector(31 downto 0));
end decoder5t32;


-- Architecture
architecture dataflow of decoder5t32 is
begin
with D_IN select
  F_OUT <= "00000000000000000000000000000001" when "00000",
           "00000000000000000000000000000010" when "00001",
           "00000000000000000000000000000100" when "00010",
           "00000000000000000000000000001000" when "00011",
           "00000000000000000000000000010000" when "00100",
           "00000000000000000000000000100000" when "00101",
           "00000000000000000000000001000000" when "00110",
           "00000000000000000000000010000000" when "00111",
           "00000000000000000000000100000000" when "01000",
           "00000000000000000000001000000000" when "01001",
           "00000000000000000000010000000000" when "01010",
           "00000000000000000000100000000000" when "01011",
           "00000000000000000001000000000000" when "01100",
           "00000000000000000010000000000000" when "01101",
           "00000000000000000100000000000000" when "01110",
           "00000000000000001000000000000000" when "01111",
           "00000000000000010000000000000000" when "10000",
           "00000000000000100000000000000000" when "10001",
           "00000000000001000000000000000000" when "10010",
           "00000000000010000000000000000000" when "10011",
           "00000000000100000000000000000000" when "10100",
           "00000000001000000000000000000000" when "10101",
           "00000000010000000000000000000000" when "10110",
           "00000000100000000000000000000000" when "10111",
           "00000001000000000000000000000000" when "11000",
           "00000010000000000000000000000000" when "11001",
           "00000100000000000000000000000000" when "11010",
           "00001000000000000000000000000000" when "11011",
           "00010000000000000000000000000000" when "11100",
           "00100000000000000000000000000000" when "11101",
           "01000000000000000000000000000000" when "11110",
           "10000000000000000000000000000000" when "11111",
           "00000000000000000000000000000000" when others;
end dataflow;
