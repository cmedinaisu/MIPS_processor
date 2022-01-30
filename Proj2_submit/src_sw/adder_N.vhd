-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 2:1
-- ADD using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 3/11/21 Patrick Bruce
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity adder_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_A   	: in std_logic_vector(N-1 downto 0);
       	i_B   	: in std_logic_vector(N-1 downto 0);
       	o_S    	: out std_logic_vector(N-1 downto 0);
	o_OF    : out std_logic);

end adder_N;

architecture structural of adder_N is

  component adder is
  port(	i_A   	: in std_logic;
      	i_B  	: in std_logic;
     	i_C    	: in std_logic;
    	o_S   	: out std_logic;
	o_C	: out std_logic);
  end component;

signal p_C : std_logic_vector(N-1 downto 0);

component xorg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

begin

  G_First_ADD: adder port map(
	i_A 	=> i_A(0),
    i_B   	=> i_B(0),
    i_C    	=> '0',  
    o_S    	=> o_S(0),
	o_C	=> p_C(0)); 

  -- Instantiate N ADD instances.
  G_NBit_ADD: for i in 1 to N-2 generate
    ADDI: adder port map(
       	i_A 	=> i_A(i),      -- All instances share the same select input.
      	i_B   	=> i_B(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
       	i_C    	=> p_C(i-1),  -- ith instance's data 1 input hooked up to ith data 1 input.
        o_S    	=> o_S(i),
		o_C		=> p_C(i));  -- ith instance's data output hooked up to ith data output.

  end generate G_NBit_ADD;

  G_Last_ADD: adder port map(
	i_A		=> i_A(N-1),
	i_B		=> i_B(N-1),
    i_C    	=> p_C(N-2),  
    o_S    	=> o_S(N-1),
	o_C		=> p_C(N-1)); 
	
  XOR0: xorg2 port map(
	i_A		=> p_C(N-1),
	i_B		=> p_C(N-2),
	o_F		=> o_OF);
	
  
  
end structural;