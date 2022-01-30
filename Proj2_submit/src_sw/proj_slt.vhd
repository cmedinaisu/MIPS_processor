-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- proj_slt.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 32 bit component that wil do an SLT operation for the ALU

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity proj_slt is
  port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0)); 
end proj_slt;



-- i_A < i_B; if true o_O = 1, else o_O = 0
architecture dataflow of proj_slt is

component add_sub_N is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_A   	: in std_logic_vector(N-1 downto 0);
       	i_B   	: in std_logic_vector(N-1 downto 0);
		i_AS	: in std_logic;
       	o_S    	: out std_logic_vector(N-1 downto 0);
		o_OF    : out std_logic);

end component;

component xorg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal s_iA, s_iB, s_Difference : std_logic_vector(31 downto 0);
signal s_OverFlow, s_CarryOut, s_Zero : std_logic;

begin
	
	ADD0: add_sub_N
	generic map(N => 32)
	port map(
		i_A 	=> i_A,
       	i_B 	=> i_B,
		i_AS 	=> '1',
       	o_S		=> s_Difference,
		o_OF	=> s_OverFlow);	
		
	o_O(31 downto 1) <= "0000000000000000000000000000000";
	o_O(0) <= (s_OverFlow xor s_Difference(31)) 
					and (i_B(0)
					or i_B(1)
					or i_B(2)
					or i_B(3)
					or i_B(4)
					or i_B(5)
					or i_B(6)
					or i_B(7)
					or i_B(8)
					or i_B(9)
					or i_B(10)
					or i_B(11)
					or i_B(12)
					or i_B(13)
					or i_B(14)
					or i_B(15)
					or i_B(16)
					or i_B(17)
					or i_B(18)
					or i_B(19)
					or i_B(20)
					or i_B(21)
					or i_B(22)
					or i_B(23)
					or i_B(24)
					or i_B(25)
					or i_B(26)
					or i_B(27)
					or i_B(28)
					or i_B(29)
					or i_B(30)
					or not i_B(31));
	

	
end dataflow;