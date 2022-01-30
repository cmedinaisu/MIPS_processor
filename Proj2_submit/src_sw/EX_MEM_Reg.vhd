-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- EX_MEM_Reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the Execute/Memory pipeline register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity EX_MEM_Reg is
	port(EX_MEM_clk : in std_logic;
		EX_MEM_rst : in std_logic;
	-- Control Signals
		EX_MEM_RegWrite: in std_logic;
		EX_MEM_MemWrite: in std_logic;
		EX_MEM_MemtoReg: in std_logic;
		EX_MEM_JAL : in std_logic;
		EX_MEM_Jump: in std_logic;
		EX_MEM_Branch: in std_logic;
		EX_MEM_BNE : in std_logic;
		EX_MEM_JR : in std_logic;
		EX_MEM_RegDst: in std_logic;
		-- Registers
		EX_MEM_write_AluResult : in std_logic_vector(31 downto 0);
		EX_MEM_write_regout1 : in std_logic_vector(31 downto 0);
		EX_MEM_write_pc_val : in std_logic_vector(31 downto 0);
		EX_MEM_write_inst: in std_logic_vector(31 downto 0);
		EX_MEM_Halt 	: in std_logic;
		EX_MEM_Zero		: in std_logic;
		EX_MEM_write_immi : in std_logic_vector(31 downto 0);
		EX_MEM_read_immi : out std_logic_vector(31 downto 0);
		EX_MEM_oZero	: out std_logic;
		EX_MEM_oHalt : out std_logic;
		-- output
	-- Control Signals
		EX_MEM_oRegWrite: out std_logic;
		EX_MEM_oMemWrite: out std_logic;
		EX_MEM_oMemtoReg: out std_logic;
		EX_MEM_oJAL : out std_logic;
		EX_MEM_oJump: out std_logic;
		EX_MEM_oBranch: out std_logic;
		EX_MEM_oBNE : out std_logic;
		EX_MEM_oJR : out std_logic;
		EX_MEM_oRegDst: out std_logic;
		EX_MEM_read_regout1 : out std_logic_vector(31 downto 0);
		EX_MEM_read_pc_val : out std_logic_vector(31 downto 0);
		EX_MEM_read_AluResult : out std_logic_vector(31 downto 0);
		EX_MEM_read_inst: out std_logic_vector(31 downto 0));
		
end EX_MEM_Reg;

architecture structural of EX_MEM_Reg is

component Reg_32 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic_vector(31 downto 0);
       oQ               : out std_logic_vector(31 downto 0));
end component;

component Reg_5 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic_vector(4 downto 0);
       oQ               : out std_logic_vector(4 downto 0));
end component;

component Reg_1 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic;
       oQ               : out std_logic);
end component;

begin

	REG_IMMI: Reg_32 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_write_immi,
       oQ => EX_MEM_read_immi);

	REG_PC4: Reg_32 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_write_pc_val,
       oQ => EX_MEM_read_pc_val);
	   
	REG_Zero: Reg_1 port map(iCLK => EX_MEM_clk,
		iReset	=> EX_MEM_rst,
		iD		=> EX_MEM_Zero,
		oQ		=> EX_MEM_oZero);
	
	REG_REGOUT1: Reg_32 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_write_regout1,
       oQ => EX_MEM_read_regout1);
	
		REG_HALT: Reg_1 port map(iCLK => EX_MEM_clk,
		iReset	=> EX_MEM_rst,
		iD		=> EX_MEM_Halt,
		oQ		=> EX_MEM_oHalt);
	   
	REG_ALUOUT: Reg_32 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_write_AluResult,
       oQ => EX_MEM_read_AluResult);
	   
	-- control signals	
	REG_REGWRITE: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_RegWrite,
       oQ => EX_MEM_oRegWrite);
	   
	REG_MEMWRITE: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_MemWrite,
       oQ => EX_MEM_oMemWrite);
	
	REG_MEMTOREG: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_MemtoReg,
       oQ => EX_MEM_oMemtoReg);
	
	REG_RegDST: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_RegDst,
       oQ => EX_MEM_oRegDst);
	
	REG_INST: REG_32 port map(iCLK => EX_MEM_clk,
		iReset 	=> EX_MEM_rst,
		iD		=> EX_MEM_write_inst,
		oQ		=> EX_MEM_read_inst);
		
	REG_BRANCH: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_Branch,
       oQ => EX_MEM_oBranch);
	   
	REG_JUMP: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_Jump,
       oQ => EX_MEM_oJump);
	
	REG_JR: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_JR,
       oQ => EX_MEM_oJR);
	
	REG_JAL: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_JAL,
       oQ => EX_MEM_oJAL);
	
	REG_BNE: Reg_1 port map(iCLK => EX_MEM_clk,
       iReset => EX_MEM_rst,
       iD => EX_MEM_BNE,
       oQ => EX_MEM_oBNE);
	
end structural;
