-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- adder_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit adder

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_adder_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(x : in std_logic_vector(N-1 downto 0);
	y : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
	U_Op: in std_logic;
	S : out std_logic_vector(N-1 downto 0);
    Cout : out std_logic;
	Overflow : out std_logic;
	Zero : out std_logic);

end ALU_adder_N;

architecture structural of ALU_adder_N is

  component adder is
  port (	
		i_A	: in	std_logic;
		i_B	: in	std_logic;
		i_C	: in	std_logic;
		o_S	: out	std_logic;
		o_C	: out	std_logic);
  end component;
  
  signal carrybit : std_logic_vector(N-1 downto 0);
  signal s_S	  : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate N instances for adder.
  G_NBit_ADD: for i in 0 to N-1 generate
INIT:
  if i = 0 generate
    ADDINIT: adder port map(
				i_A     => x(i),
				i_B     => y(i),
				i_C		=> Cin,
				o_S		=> s_S(i),
				o_C  	=> carrybit(i));  
	end generate;
	
ADD_N:
	if i/= 0 generate
	ADD: adder port map(
				i_A     => x(i),
				i_B     => y(i), 
				i_C		=> carrybit(i-1),
				o_S     => s_S(i),
				o_C  	=> carrybit(i));
	end generate;
  end generate G_NBit_ADD;
  
 -- Carry_Out:
	Cout <= carrybit(N-1);
	
	-- check for overflow
	
	ovf: process(U_Op,carrybit) is
	begin
		if (U_Op = '0') then
			Overflow <= carrybit(N-1) xor carrybit(N-2);
		else
			Overflow <= '0';
		end if;
	end process ovf;
	
	S 		<= s_S;
	
	zero 	<= not (s_S(0) or s_S(1) or s_S(2) or s_S(3) or s_S(4) or s_S(5) or s_S(6) or s_S(7) or s_S(8) or s_S(9) or s_S(10) 
				or s_S(11) or s_S(12) or s_S(13) or s_S(14) or s_S(15)or s_S(16) or s_S(17) or s_S(18) or s_S(19) or s_S(20) 
				or s_S(21) or s_S(22) or s_S(23) or s_S(24) or s_S(25)or s_S(26) or s_S(27) or s_S(28) or s_S(29) or s_S(30));
	
	
end structural;
