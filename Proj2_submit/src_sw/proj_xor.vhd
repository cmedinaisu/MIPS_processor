-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- proj_xor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 32 bit component that wil do an XOR operation for the ALU

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity proj_xor is
  port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end proj_xor;

architecture structural of proj_xor is

component xorg2 is
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;
	   
begin

  -- Instantiate N mux instances.
  GEN_XOR: for i in 0 to 31 generate
    XORI: xorg2 port map(
        i_A => i_A(i),
		i_B => i_B(i),
		o_F => o_O(i));
  end generate GEN_XOR;
  
end structural;