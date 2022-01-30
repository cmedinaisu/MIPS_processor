-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- add_sub_N.vhd
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

entity add_sub_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_A   	: in std_logic_vector(N-1 downto 0);
       	i_B   	: in std_logic_vector(N-1 downto 0);
	i_AS	: in std_logic;
       	o_S    	: out std_logic_vector(N-1 downto 0);
	o_OF    : out std_logic);

end add_sub_N;

architecture structural of add_sub_N is

component adder_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_A   	: in std_logic_vector(N-1 downto 0);
       	i_B   	: in std_logic_vector(N-1 downto 0);
       	o_S    	: out std_logic_vector(N-1 downto 0);
	o_OF    : out std_logic);
end component;

component OnesComp is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A         : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component mux2t1_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
end component;

signal p_Mux, p_Twos, p_BInv : std_logic_vector(N-1 downto 0);

signal p_One: std_logic_vector(N-1 downto 0) := (others => '0');

begin

  p_One(0) <= '1';

  INV1: OnesComp port map(
	i_A	=> i_B,
	o_F	=> p_BInv);

  ADD1: Adder_N port map(
	i_A	=> p_BInv,
	i_B	=> p_One,
	o_S	=> p_Twos);

  MUXAS: mux2t1_N port map(
	i_S	=> i_AS,
	i_D0	=> i_B,
	i_D1	=> p_Twos,
	o_O	=> p_Mux);

  ADD0: Adder_N port map(
	i_A	=> i_A,
	i_B	=> p_Mux,
	o_S	=> o_S,
	o_OF	=> o_OF);
  
end structural;