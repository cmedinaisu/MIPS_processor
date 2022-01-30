-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- norg32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a Data Path
--
--
-- NOTES:
-- 3/24/21 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.or_reduce;

	entity norg32 is
	  port(	i_A   	: in std_logic_vector(31 downto 0);
			o_F    	: out std_logic);
	end norg32;
	
architecture dataflow of norg32 is

signal s_OrA1 : std_logic;
signal s_OrA2 : std_logic;
signal s_OrA3 : std_logic;
signal s_OrA4 : std_logic;
signal s_OrA5 : std_logic;
signal s_OrA6 : std_logic;
signal s_OrA7 : std_logic;
signal s_OrA8 : std_logic;
signal s_OrA9 : std_logic;
signal s_OrA10 : std_logic;
signal s_OrA11 : std_logic;
signal s_OrA12 : std_logic;
signal s_OrA13 : std_logic;
signal s_OrA14 : std_logic;
signal s_OrA15 : std_logic;
signal s_OrA16 : std_logic;
signal s_OrA17 : std_logic;
signal s_OrA18 : std_logic;
signal s_OrA19 : std_logic;
signal s_OrA20 : std_logic;
signal s_OrA21 : std_logic;
signal s_OrA22 : std_logic;
signal s_OrA23 : std_logic;
signal s_OrA24 : std_logic;
signal s_OrA25 : std_logic;
signal s_OrA26 : std_logic;
signal s_OrA27 : std_logic;
signal s_OrA28 : std_logic;
signal s_OrA29 : std_logic;
signal s_OrA30 : std_logic;
signal s_OrA31 : std_logic;


begin

	s_OrA1 	<= i_A(0) or i_A(1);
	s_OrA2 	<= s_OrA1 or i_A(2);
	s_OrA3 	<= s_OrA2 or i_A(3);
	s_OrA4 	<= s_OrA3 or i_A(4);
	s_OrA5 	<= s_OrA4 or i_A(5);
	s_OrA6 	<= s_OrA5 or i_A(6);
	s_OrA7 	<= s_OrA6 or i_A(7);
	s_OrA8 	<= s_OrA7 or i_A(8);
	s_OrA9 	<= s_OrA8 or i_A(9);
	s_OrA10 <= s_OrA9 or i_A(10);
	s_OrA11 <= s_OrA10 or i_A(11);
	s_OrA12 <= s_OrA11 or i_A(12);
	s_OrA13 <= s_OrA12 or i_A(13);
	s_OrA14 <= s_OrA13 or i_A(14);
	s_OrA15 <= s_OrA14 or i_A(15);
	s_OrA16 <= s_OrA15 or i_A(16);
	s_OrA17 <= s_OrA16 or i_A(17);
	s_OrA18 <= s_OrA17 or i_A(18);
	s_OrA19 <= s_OrA18 or i_A(19);
	s_OrA20 <= s_OrA19 or i_A(20);
	s_OrA21 <= s_OrA20 or i_A(21);
	s_OrA22 <= s_OrA21 or i_A(22);
	s_OrA23 <= s_OrA22 or i_A(23);
	s_OrA24 <= s_OrA23 or i_A(24);
	s_OrA25 <= s_OrA24 or i_A(25);
	s_OrA26 <= s_OrA25 or i_A(26);
	s_OrA27 <= s_OrA26 or i_A(27);
	s_OrA28 <= s_OrA27 or i_A(28);
	s_OrA29 <= s_OrA28 or i_A(29);
	s_OrA30 <= s_OrA29 or i_A(30);
	s_OrA31 <= s_OrA30 or i_A(31);

	o_F <= not s_OrA31;
	
end dataflow;
	
	