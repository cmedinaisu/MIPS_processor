-------------------------------------------------------------------------
-- PAtrick Bruce
-- Department of Electrical or Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- org3.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 3-input or 
-- gate.
--
--
-- NOTES:
-- 3/11/21 Patrick Bruce
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity org3 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
       	o_F          	: out std_logic);

end org3;

architecture structural of org3 is
component org2 is
  port(i_A          : in 	std_logic;
       i_B          : in 	std_logic;
       o_F          : out 	std_logic);
end component;

signal p_A : std_logic;

begin
or0: org2 port map(
	i_A 	=>	i_A,
	i_B	=>	i_B,
	o_F	=>	p_A);

or1: org2 port map(
	i_A 	=>	p_A,
	i_B	=>	i_C,
	o_F	=>	o_F);
  
end structural;