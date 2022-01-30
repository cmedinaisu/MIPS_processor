-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- proj_lui.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation for the lui operation that will take 
-- 
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity proj_lui is

  port(i_A : in std_logic_vector(15 downto 0);-- immediate value being loaded into the register
	o_O : out std_logic_vector(31 downto 0));
end proj_lui;

architecture structural of proj_lui is

begin
			
	o_O(31 downto 16) 	<= i_A;
	o_O(15 downto 0) 	<= x"0000";
	
end structural;