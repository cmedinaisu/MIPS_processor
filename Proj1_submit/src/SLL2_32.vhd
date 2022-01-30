-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- SLL2_32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of shift left
-- logical by 2 bits on a 26 bit input. 
--
--


-- 4/7/21 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity SLL2_32 is

  port(
       iD               : in std_logic_vector(31 downto 0);
       oQ               : out std_logic_vector(31 downto 0));

end SLL2_32;

architecture dataflow of SLL2_32 is
begin

	oQ(31 downto 2) <= iD(29 downto 0);
	oQ(1 downto 0) <= "00";
	
end dataflow;
