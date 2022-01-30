-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- adder.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a one bit adder.

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
entity ALU_adder is
	
	port ( x, y, cin, iclk: in std_logic;
		  Cout, S : out std_logic); 
end ALU_adder;

architecture structural of ALU_adder is

component ALU_andg2 is
	port ( i_A, i_B : in std_logic;
			o_F : out std_logic);
end component;

component ALU_xorg2 is
	port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component ALU_org2 is
	port ( i_A, i_B : in std_logic;
			o_F : out std_logic);
end component;

-- intermediate signals
signal i_x, i_a, i_b : std_logic;

begin
	s1: ALU_xorg2 port map ( i_A => x,
						i_B => y,
						o_F => i_x);
						
	s2: ALU_xorg2 port map ( i_A => i_x,
						i_B => Cin,
						o_F => S);
						
	x1: ALU_andg2 port map ( i_A => Cin,
						 i_B => i_x,
						 o_F => i_a);
						 
	x2: ALU_andg2 port map ( i_A => x,
						 i_B => y,
						 o_F => i_b);
						 
	o1: ALU_org2 port map ( i_A => i_a,
						i_B => i_b,
						o_F => Cout);
						
end structural;

	