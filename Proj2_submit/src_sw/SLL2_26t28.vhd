-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- SLL2_26t28.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of shift left
-- logical by 2 bits on a 26 bit input. 
--
--


-- 4/7/21 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity SLL2_26t28 is

  port(
       iD               : in std_logic_vector(25 downto 0);
       oQ               : out std_logic_vector(27 downto 0));

end SLL2_26t28;

architecture dataflow of SLL2_26t28 is
begin
	oQ(27) <= iD(25);
	oQ(26) <= iD(24);
	oQ(25) <= iD(23);
	oQ(24) <= iD(22);	
	oQ(23) <= iD(21);
	oQ(22) <= iD(20);
	oQ(21) <= iD(19);
	oQ(20) <= iD(18);
	oQ(19) <= iD(17);
	oQ(18) <= iD(16);
	oQ(17) <= iD(15);
	oQ(16) <= iD(14);
	oQ(15) <= iD(13);
	oQ(14) <= iD(12);	
	oQ(13) <= iD(11);
	oQ(12) <= iD(10);
	oQ(11) <= iD(9);
	oQ(10) <= iD(8);
	oQ(9) <= iD(7);
	oQ(8) <= iD(6);
	oQ(7) <= iD(5);
	oQ(6) <= iD(4);
	oQ(5) <= iD(3);
	oQ(4) <= iD(2);	
	oQ(3) <= iD(1);
	oQ(2) <= iD(0);
	oQ(1) <= '0';
	oQ(0) <= '0';

	
end dataflow;
