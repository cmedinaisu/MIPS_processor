-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Control_Logic_Module.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the control unit module that will take in a 6-bit
-- opcode and designate control signals for for the given instruction.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Control_Logic_Module is
	port(	
		iOpcode 	: in std_logic_vector(5 downto 0);
		oMemWrite 	: out std_logic;
		oMemtoReg 	: out std_logic;
		oJump 		: out std_logic;
		oJAL		: out std_logic;
		oBranch 	: out std_logic;
		oBNE		: out std_logic;
		oALUOp 		: out std_logic_vector(3 downto 0);
		oALUSrc 	: out std_logic;
		oRegDst 	: out std_logic;
		oRegWrite 	: out std_logic;
		oSignExt	: out std_logic;
		oHalt		: out std_logic);
end Control_Logic_Module;

architecture structural of Control_Logic_Module is
begin

	process(iOpcode) is
	begin
		case iOpcode is
			when "010100" => -- s_Halt control signal for MIPS_Processor
				oMemWrite <= 'X';
				oMemtoReg <= 'X';
				oJump <= 'X';
				oJAL 	<= '0';
				oBranch <= 'X';
				oBNE	<= '0';
				oALUOp <= "XXXX";
				oALUSrc <= 'X';
				oRegDst <= 'X';
				oRegWrite <= 'X';
				oSignExt	<= 'X';
				oHalt <= '1';
			when "000000" => -- R-Type instructions
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "1111";
				oALUSrc <= '0';
				oRegDst <= '1';
				oRegWrite <= '1';
				oSignExt	<= 'X';
				oHalt <= '0';
			when "001000" => -- addi
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0010";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '1';
				oHalt <= '0';
			when "001001" => -- addiu
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0011";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '1';
				oHalt <= '0';
			when "001100" => -- andi
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0000";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '0';
				oHalt <= '0';
			when "001111" => -- lui 
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "1001";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= 'X';
				oHalt <= '0';
			when "100011" => -- lw
				oMemWrite <= '0';
				oMemtoReg <= '1';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0010";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '1';
				oHalt <= '0';
			when "001101" => -- ori
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "1101";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '0';
				oHalt <= '0';
			when "001110" => -- xori
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "1110";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '0';
				oHalt <= '0';
			when "001010" => -- slti
				oMemWrite <= '0';
				oMemtoReg <= '0';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0111";
				oALUSrc <= '1';
				oRegDst <= '0';
				oRegWrite <= '1';
				oSignExt	<= '1';
				oHalt <= '0';
			when "101011" => -- sw
				oMemWrite <= '1';
				oMemtoReg <= 'X';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "0010";
				oALUSrc <= '1';
				oRegDst <= 'X';
				oRegWrite <= '0';
				oSignExt	<= '1';
				oHalt <= '0';
			when "000100" => -- beq
				oMemWrite <= '0';
				oMemtoReg <= 'X';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '1';
				oBNE	<= '0';
				oALUOp <= "0110";
				oALUSrc <= '0';
				oRegDst <= 'X';
				oRegWrite <= '0';
				oSignExt	<= 'X';
				oHalt <= '0';
			when "000101" => -- bne
				oMemWrite <= '0';
				oMemtoReg <= 'X';
				oJump <= '0';
				oJAL 	<= '0';
				oBranch <= '1';
				oBNE	<= '1';
				oALUOp <= "0110";
				oALUSrc <= '0';
				oRegDst <= 'X';
				oRegWrite <= '0';
				oSignExt	<= '1';
				oHalt <= '0';
			when "000010" => -- j
				oMemWrite <= '0';
				oMemtoReg <= 'X';
				oJump <= '1';
				oJAL 	<= '0';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "XXXX";
				oALUSrc <= 'X';
				oRegDst <= 'X';
				oRegWrite <= '0';
				oSignExt	<= 'X';
				oHalt <= '0';
			when "000011" => -- jal
				oMemWrite <= '0';
				oMemtoReg <= 'X';
				oJump <= '1';
				oJAL 	<= '1';
				oBranch <= '0';
				oBNE	<= '0';
				oALUOp <= "XXXX";
				oALUSrc <= 'X';
				oRegDst <= 'X';
				oRegWrite <= '1';
				oSignExt	<= 'X';
				oHalt <= '0';
			when others =>
				oMemWrite <= 'X';
				oMemtoReg <= 'X';
				oJump <= 'X';
				oJAL 	<= '0';
				oBranch <= 'X';
				oBNE	<= '0';
				oALUOp <= "XXXX";
				oALUSrc <= 'X';
				oRegDst <= 'X';
				oRegWrite <= 'X';
				oSignExt	<= 'X';
				oHalt <= '0';
		end case;
	end process;

end structural;