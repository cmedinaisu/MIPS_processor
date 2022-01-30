-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Add_Sub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit adder and subtractor
-- signal to detect Overflow and zero

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Add_Sub is
  generic(N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port(A : in std_logic_vector(N-1 downto 0);
	B : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	U_Op: in std_logic;
    AS_Out : out std_logic_vector(N-1 downto 0);
	carry_out : out std_logic;
	Overflow : out std_logic;
	Zero : out std_logic);

end ALU_Add_Sub;

architecture structural of ALU_Add_Sub is

  component ALU_adder_N is
	generic(N : integer := 32);
    port(x : in std_logic_vector(N-1 downto 0);
	y : in std_logic_vector(N-1 downto 0);
	Cin : in std_logic;
	U_Op: in std_logic;
	S : out std_logic_vector(N-1 downto 0);
    Cout : out std_logic;
	Overflow : out std_logic;
	Zero : out std_logic);
		
  end component;
  
  component ALU_onesComp_N is
	generic(N : integer := 32);
	port(i_C          : in std_logic_vector(N-1 downto 0);
       o_C          : out std_logic_vector(N-1 downto 0));
	   
	end component;
	
	component ALU_mux2t1_N is
	generic(N : integer := 32);
	port(i_S        : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));
	   
	end component;
	
	signal i_v, i_b : std_logic_vector(N-1 downto 0);
	signal carry_temp: std_logic_vector(N-1 downto 0);
	

begin
						
	invert: ALU_onesComp_N port map ( i_C => B,
						o_C => i_v);
						 
	muxsub: ALU_mux2t1_N port map (i_S => nAdd_Sub,
						i_D0 => B,
						i_D1 => i_v,
						o_O => i_b);
						
	add: ALU_adder_N port map ( x => A,
						y => i_b,
						Cin => nAdd_Sub,
						U_Op => U_Op,
						Cout => carry_out,
						S => AS_Out,
						Overflow => Overflow,
						Zero => Zero);
	
end structural;
