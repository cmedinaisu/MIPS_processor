-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------

-- mux2t1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a two input multiplexor.

-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;


-- 2:1 MUX MODULE with structural modeling

library IEEE;
use IEEE.std_logic_1164.all;
entity ALU_mux2t1 is
	
	port ( i_D0, i_D1, i_S : in std_logic;
		  o_O : out std_logic); 
end ALU_mux2t1;

architecture structural of ALU_mux2t1 is

component andg2 is
	port ( i_A, i_B : in std_logic;
			o_F : out std_logic);
end component;

component invg is
	port ( i_A : in std_logic;
			o_F : out std_logic);
end component;

component org2 is
	port ( i_A, i_B : in std_logic;
			o_F : out std_logic);
end component;

-- intermediate signals
signal andout1, andout2, notout : std_logic;

begin
	s1: invg port map ( i_A => i_S,
						o_F => notout);
						
	x1: andg2 port map ( i_A => i_D0,
						 i_B => notout,
						 o_F => andout1);
						 
	x2: andg2 port map ( i_A => i_D1,
						 i_B => i_S,
						 o_F => andout2);
						 
	o1: org2 port map ( i_A => andout1,
						i_B => andout2,
						o_F => o_O);
						
end structural;

	