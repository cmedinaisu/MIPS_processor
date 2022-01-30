-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an adderusing 
-- structural VHDL.
--
--
-- NOTES:
-- 3/9/21 by Patrick Bruce
-------------------------------------------------------------------------

-- Library Declarations
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity 
entity adder is
 port (	i_A	: in	std_logic;
	i_B	: in	std_logic;
	i_C	: in	std_logic;
	o_S	: out	std_logic;
	o_C	: out	std_logic);
end adder;

-- Architecture
architecture structural of adder is

component andg2 is

  port(i_A          : in 	std_logic;
       i_B          : in 	std_logic;
       o_F          : out 	std_logic);

end component;

component andg3 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
       	o_F          	: out std_logic);

end component;

component invg is

  port(i_A          : in 	std_logic;
       o_F          : out 	std_logic);

end component;

component org3 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
       	o_F          	: out std_logic);

end component;

component org4 is

  port(	i_A          	: in std_logic;
       	i_B          	: in std_logic;
	i_C		: in std_logic;
	i_D		: in std_logic;
       	o_F          	: out std_logic);

end component;

-- Intermidiate Signal Declaration

signal p_NotA, p_NotB, p_NotC, p_AB, p_AC, p_BC, p_ABC, p_ANotBNotC, p_NotABNotC, p_NotANotBC : std_logic;

begin
INVA: invg port map(
	i_A 	=>	i_A,
	o_F	=>	p_NotA);

INVB: invg port map(
	i_A 	=>	i_B,
	o_F	=>	p_NotB);

INVC: invg port map(
	i_A 	=>	i_C,
	o_F	=>	p_NotC);

AB: andg2 port map(
	i_A	=>	i_A,
	i_B	=>	i_B,
	o_F	=>	p_AB);

AC: andg2 port map(
	i_A	=>	i_A,
	i_B	=>	i_C,
	o_F	=>	p_AC);

BC: andg2 port map(
	i_A	=>	i_B,
	i_B	=>	i_C,
	o_F	=>	p_BC);

ABC: andg3 port map(
	i_A	=>	i_A,
	i_B	=>	i_B,
	i_C	=>	i_C,
	o_F	=>	p_ABC);

ANotBNotC: andg3 port map(
	i_A	=>	i_A,
	i_B	=>	p_NotB,
	i_C	=>	p_NotC,
	o_F	=>	p_ANotBNotC);

NotABNotC: andg3 port map(
	i_A	=>	p_NotA,
	i_B	=>	i_B,
	i_C	=>	p_notC,
	o_F	=>	p_NotABNotC);

NotANotBC: andg3 port map(
	i_A	=>	p_NotA,
	i_B	=>	p_NotB,
	i_C	=>	i_C,
	o_F	=>	p_NotANotBC);

COUT: org3 port map(
	i_A	=>	p_AB,
	i_B	=>	p_AC,
	i_C	=>	p_BC,
	o_F	=>	o_C);

SOUT: org4 port map(
	i_A	=>	p_ABC,
	i_B 	=>	p_ANotBNotC,
	i_C	=>	p_NotABNotC,
	i_D	=>	p_NotANotBC,
	o_F	=>	o_S);

end structural;