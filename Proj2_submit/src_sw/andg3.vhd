-------------------------------------------------------------------------
-- PAtrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- andg3.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 3-input AND 
-- gate.
--
--
-- NOTES:
-- 3/11/21 Patrick Bruce
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity andg3 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
       	o_F          	: out std_logic);

end andg3;

architecture structural of andg3 is
component andg2 is
  port(i_A          : in 	std_logic;
       i_B          : in 	std_logic;
       o_F          : out 	std_logic);
end component;

signal p_A : std_logic;

begin
AND0: andg2 port map(
	i_A 	=>	i_A,
	i_B	=>	i_B,
	o_F	=>	p_A);

AND1: andg2 port map(
	i_A 	=>	p_A,
	i_B	=>	i_C,
	o_F	=>	o_F);
  
end structural;