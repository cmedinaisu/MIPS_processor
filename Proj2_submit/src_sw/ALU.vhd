-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ALU.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the ALU module that will compute all operations given a 
-- 2 32-bit inputs, a 4-bit control line and 3 outputs -- 32-bit result, 1-bit zero signal and 1-bit overflow signal.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
	generic(N : integer := 32);
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		ALUControl : in std_logic_vector(3 downto 0);
		ishamt		:in std_logic_vector(4 downto 0);
		ALU_Out : out std_logic_vector(31 downto 0);
		Zero : out std_logic := '0';
		Overflow : out std_logic := '0');
end ALU;

architecture structural of ALU is

component ALU_Add_Sub is
	generic(N : integer := 32);
  port(A : in std_logic_vector(N-1 downto 0);
	B : in std_logic_vector(N-1 downto 0);
	nAdd_Sub : in std_logic;
	U_Op: in std_logic;
    AS_Out : out std_logic_vector(N-1 downto 0);
	carry_out : out std_logic;
	Overflow : out std_logic;
	Zero : out std_logic);
end component;

component proj_and is
	port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_or is
	port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_nor is
	port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_slt is
	port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_xor is
	port(i_A : in std_logic_vector(31 downto 0);
	i_B : in std_logic_vector(31 downto 0);
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_lui is
  port(i_A : in std_logic_vector(15 downto 0);-- immediate value being loaded into the register
	o_O : out std_logic_vector(31 downto 0));
end component;

component proj_sll is
	port(i_shift      : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
end component;

component proj_srl is
	port(i_shift      : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
end component;

component proj_sra is
	port(i_shift      : in std_logic_vector(4 downto 0);
       i_D          : in std_logic_vector(31 downto 0);
       o_O          : out std_logic_vector(31 downto 0));
end component;

signal shifter : std_logic_vector(4 downto 0);

-- outputs
signal output_add 	: std_logic_vector(31 downto 0);
signal output_addu 	: std_logic_vector(31 downto 0);
signal output_sub 	: std_logic_vector(31 downto 0);
signal output_subu 	: std_logic_vector(31 downto 0);
signal output_and 	: std_logic_vector(31 downto 0);
signal output_xor 	: std_logic_vector(31 downto 0);
signal output_nor 	: std_logic_vector(31 downto 0);
signal output_or 	: std_logic_vector(31 downto 0);
signal output_slt 	: std_logic_vector(31 downto 0);
signal output_lui	: std_logic_vector(31 downto 0);
signal output_sll	: std_logic_vector(31 downto 0);
signal output_srl	: std_logic_vector(31 downto 0);
signal output_sra	: std_logic_vector(31 downto 0);

signal zero_temp : std_logic := '0';
signal overflow_temp : std_logic := '0';
signal zero_temp1 : std_logic := '0';
signal overflow_temp1 : std_logic := '0';
signal zero_temp2 : std_logic := '0';
signal overflow_temp2 : std_logic := '0';
signal zero_temp3 : std_logic := '0';
signal overflow_temp3 : std_logic := '0';

begin

	AND0: proj_and port map(i_A => A,
							i_B => B,
							o_O => output_and);
							
	SLL0: proj_sll port map(i_shift => ishamt,
								i_D => B,
								o_O => output_sll);
								
	ADD0: ALU_Add_Sub port map(A => A,
									B => B,
									nAdd_Sub => '0',
									U_Op => '0',
									AS_Out => output_add,
									Overflow => overflow_temp,
									Zero => zero_temp);
									
	ADDU: ALU_Add_Sub port map(A => A,
									B => B,
									nAdd_Sub => '0',
									U_Op => '1',
									AS_Out => output_addu,
									Overflow => overflow_temp1,
									Zero => zero_temp1);
									
	SRL0: proj_srl port map(i_shift => ishamt,
								i_D => B,
								o_O => output_srl);
								
	SUBU: ALU_Add_Sub port map(A => A,
									B => B,
									nAdd_Sub => '1',
									U_Op => '1',
									AS_Out => output_subu,
									Overflow => overflow_temp2,
									Zero => zero_temp2);
									
	SUB: ALU_Add_Sub port map(A => A,
									B => B,
									nAdd_Sub => '1',
									U_Op => '0',
									AS_Out => output_sub,
									Overflow => overflow_temp3,
									Zero => zero_temp3);
									
	SLT: proj_slt port map(i_A => A,
						i_B => B,
						o_O => output_slt);
								
	SRA0: proj_sra port map(i_shift => ishamt,
								i_D => B,
								o_O => output_sra);
	
	NOR0: proj_nor 
	port map(
		i_A => A,
		i_B => B,
		o_O => output_nor);
							
	XOR0: proj_xor 
	port map(
		i_A => A,
		i_B => B,
		o_O => output_xor);
										
										
	OR0: proj_or 
	port map(
		i_A 	=> A,
		i_B 	=> B,
		o_O 	=> output_or);
							
	LUI0: proj_lui
	port map(
		i_A  	=> B(15 downto 0),-- immediate value being loaded into the register
		o_O  	=> output_lui);
							
	process(ALUControl, output_lui, output_add, output_addu, output_subu, output_sub, output_sll, output_srl, output_sra,
			output_slt, output_nor, output_and, output_xor, output_or, zero_temp, zero_temp1, 
			zero_temp2, zero_temp3, overflow_temp, overflow_temp1, overflow_temp2, overflow_temp3) is
	begin
		case ALUControl is
			--AND
			when "0000" =>
				ALU_Out <= output_and;
				Zero <= '0';
				Overflow <= '0';
			-- SLL
			when "0001" =>
				ALU_Out <= output_sll;
				Zero <= '0';
				Overflow <= '0';
			-- ADD
			when "0010" =>
				ALU_Out <= output_add;
				Zero <= zero_temp;
				Overflow <= overflow_temp;
			-- ADDU
			when "0011" =>
				ALU_Out <= output_addu;
				Zero <= zero_temp1;
				Overflow <= overflow_temp1;
			-- SRL
			when "0100" =>
				ALU_Out <= output_srl;
				Zero <= '0';
				Overflow <= '0';
			-- SUBU
			when "0101" =>
				ALU_Out <= output_subu;
				Zero <= zero_temp2;
				Overflow <= overflow_temp2;
			-- SUB
			when "0110" =>
				ALU_Out <= output_sub;
				Zero <= zero_temp3;
				Overflow <= overflow_temp3;
			-- SLT	
			when "0111" =>
				ALU_Out <= output_slt;
				Zero <= '0';
				Overflow <= '0';
			-- SRA	
			when "1000" =>
				ALU_Out <= output_sra;
				Zero <= '0';
				Overflow <= '0';
			-- LUI
			when "1001" =>
				ALU_Out <= output_lui;
				Zero <= '0';
				Overflow <= '0';
			-- NOR	
			when "1100" =>
				ALU_Out <= output_nor;
				Zero <= '0';
				Overflow <= '0';
			-- OR	
			when "1101" =>
				ALU_Out <= output_or;
				Zero <= '0';
				Overflow <= '0';
			-- XOR	
			when "1110" =>
				ALU_Out <= output_xor;
				Zero <= '0';
				Overflow <= '0';
			-- LUI
			when "1111" =>
				ALU_Out 	<= output_lui;
				Zero		<= '0';
				Overflow	<= '0';
			when others =>
				ALU_Out <= x"00000000";
				Zero		<= '0';
				Overflow	<= '0';
		end case;
	end process;
end structural;

