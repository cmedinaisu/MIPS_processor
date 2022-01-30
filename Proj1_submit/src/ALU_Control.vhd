-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ALU_Control.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the ALU control unit module that will take in a 6-bit
-- function code and a 2-bit ALUOp signal, which will output a 4-bit signal that will drive a selector of chooing
-- the right ALU operation for a given instruction.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_Control is
	generic(N : integer := 32);
	port(ALUOp 		: in std_logic_vector(3 downto 0);
		Funct 		: in std_logic_vector(5 downto 0);
		ALUControl 	: out std_logic_vector(3 downto 0);
		oJR			: out std_logic);
		
end ALU_Control;

architecture structural of ALU_Control is
begin
	process(ALUOp, Funct) is
	begin
		case ALUOp is
			-- ADDING: load, store, addi
			when "0010" =>
				ALUControl <= "0010";
				oJR		   <= '0';
			-- SUB: beq, bne
			when "0110" =>
				ALUControl <= "0110";
				oJR		   <= '0';
			-- ADDIU
			when "0011" =>
				ALUControl <= "0011";
				oJR		   <= '0';
			-- ANDI
			when "0000" =>
				ALUControl <= "0000";
				oJR		   <= '0';
			-- XORI
			when "1110" =>
				ALUControl <= "1110";
				oJR		   <= '0';
			-- ORI
			when "1101" =>
				ALUControl <= "1101";
				oJR		   <= '0';
			-- SLTI
			when "0111" =>
				ALUControl <= "0111";
				oJR		   <= '0';
			-- LUI
			when "1001" =>
				ALUControl <= "1001";
				oJR		   <= '0';
			-- R-type Instructions
			when "1111" => 
				-- ADD
				if Funct = "100000" then
					ALUControl <= "0010";
					oJR		   <= '0';
				-- ADDU
				elsif Funct = "100001" then
					ALUControl <= "0011";
					oJR		   <= '0';
				-- AND
				elsif Funct = "100100" then
					ALUControl <= "0000";
					oJR		   <= '0';
				-- NOR
				elsif Funct = "100111" then
					ALUControl <= "1100";
					oJR		   <= '0';
				-- XOR
				elsif Funct = "100110" then
					ALUControl <= "1110";
					oJR		   <= '0';
				-- OR
				elsif Funct = "100101" then
					ALUControl <= "1101";
					oJR		   <= '0';
				-- SLT
				elsif Funct = "101010" then
					ALUControl <= "0111";
					oJR		   <= '0';
				-- SUB
				elsif Funct = "100010" then
					ALUControl <= "0110";
					oJR		   <= '0';
				-- SUBU
				elsif Funct = "100011" then
					ALUControl <= "0101";
					oJR		   <= '0';
				-- SLL
				elsif Funct = "000000" then
					ALUControl <= "0001";
					oJR		   <= '0';
				-- SRL
				elsif Funct = "000010" then
					ALUControl <= "0100";
					oJR		   <= '0';
				-- SRA
				elsif Funct = "000011" then
					ALUControl <= "1000";
					oJR		   <= '0';
				-- JR
				elsif Funct = "001000" then
					ALUControl <= "1000";
					oJR		   <= '1';
				else
					ALUControl <= "XXXX";
					oJR		   <= '0';
				end if;
			when others =>
				ALUControl <= "XXXX";
				oJR		   <= '0';
			end case;
	end process;

end structural;