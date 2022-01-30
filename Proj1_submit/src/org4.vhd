-------------------------------------------------------------------------
-- PAtrick Bruce
-- Department of Electrical or Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- org4.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 4-input or 
-- gate.
--
--
-- NOTES:
-- 3/11/21 Patrick Bruce
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity org4 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
	i_D		: in std_logic;
       	o_F          	: out std_logic);

end org4;

architecture structural of org4 is
component org2 is
  port(i_A          : in 	std_logic;
       i_B          : in 	std_logic;
       o_F          : out 	std_logic);
end component;

component org3 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
       	o_F          	: out std_logic);

end component;

signal p_A : std_logic;

begin
or0: org2 port map(
	i_A 	=>	i_A,
	i_B	=>	i_B,
	o_F	=>	p_A);

or1: org3 port map(
	i_A 	=>	p_A,
	i_B	=>	i_C,
	i_C	=>	i_D,
	o_F	=>	o_F);
  
end structural;