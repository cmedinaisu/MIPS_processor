-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MEM_WB_Reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the Execute/Memory pipeline register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity MEM_WB_Reg is
	port(MEM_WB_clk : in std_logic;
		MEM_WB_rst : in std_logic;
	-- Control Signals
		MEM_WB_RegWrite: in std_logic;
		MEM_WB_RegDst: in std_logic;
		MEM_WB_MemtoReg: in std_logic;
		MEM_WB_JAL : in std_logic;
		MEM_WB_Jump: in std_logic;
		MEM_WB_Branch: in std_logic;
		MEM_WB_BNE : in std_logic;
		MEM_WB_JR : in std_logic;
		-- input Registers
		MEM_WB_write_regout1 : in std_logic_vector(31 downto 0);
		MEM_WB_write_pc_val : in std_logic_vector(31 downto 0);
		MEM_WB_write_AluResult : in std_logic_vector(31 downto 0);
		MEM_WB_write_MemData : in std_logic_vector(31 downto 0);
		MEM_WB_write_inst : in std_logic_vector(31 downto 0);
		MEM_WB_Halt : in std_logic;
		MEM_WB_Zero		: in std_logic;
		MEM_WB_write_immi : in std_logic_vector(31 downto 0);
		MEM_WB_read_immi : out std_logic_vector(31 downto 0);
		MEM_WB_oZero	: out std_logic;
		MEM_WB_oHalt : out std_logic;
		-- output
		MEM_WB_oRegWrite: out std_logic;
		MEM_WB_oMemtoReg: out std_logic;
		MEM_WB_oJAL : out std_logic;
		MEM_WB_oJump: out std_logic;
		MEM_WB_oBranch: out std_logic;
		MEM_WB_oBNE : out std_logic;
		MEM_WB_oJR : out std_logic;
		MEM_WB_oRegDst: out std_logic;
		MEM_WB_read_regout1 : out std_logic_vector(31 downto 0);
		MEM_WB_read_pc_val : out std_logic_vector(31 downto 0);
		MEM_WB_read_AluResult : out std_logic_vector(31 downto 0);
		MEM_WB_read_MemData : out std_logic_vector(31 downto 0);
		MEM_WB_read_inst : out std_logic_vector(31 downto 0));
		
end MEM_WB_Reg;

architecture structural of MEM_WB_Reg is

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
	REG_IMMI: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_immi,
       oQ => MEM_WB_read_immi);

	REG_Zero: Reg_1 port map(iCLK => MEM_WB_clk,
		iReset	=> MEM_WB_rst,
		iD		=> MEM_WB_Zero,
		oQ		=> MEM_WB_oZero);
	
	REG_PC4: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_pc_val,
       oQ => MEM_WB_read_pc_val);
	 
	REG_REGOUT1: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_regout1,
       oQ => MEM_WB_read_regout1);
	
	REG_MEMDATA: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_MemData,
       oQ => MEM_WB_read_MemData);
	   
	REG_ALUOUT: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_AluResult,
       oQ => MEM_WB_read_AluResult);
	
	REG_INST: Reg_32 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_write_inst,
       oQ => MEM_WB_read_inst);
	   
	REG_DST: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_RegDst,
       oQ => MEM_WB_oRegDst);
	   
	-- control signals	
	REG_oREGWRITE: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_RegWrite,
       oQ => MEM_WB_oRegWrite);
	
	REG_MEMTOREG: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_MemtoReg,
       oQ => MEM_WB_oMemtoReg);
	   
	REG_BRANCH: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_Branch,
       oQ => MEM_WB_oBranch);
	   
	REG_JUMP: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_Jump,
       oQ => MEM_WB_oJump);
	
	REG_JR: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_JR,
       oQ => MEM_WB_oJR);
	
	REG_JAL: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_JAL,
       oQ => MEM_WB_oJAL);
	
	REG_BNE: Reg_1 port map(iCLK => MEM_WB_clk,
       iReset => MEM_WB_rst,
       iD => MEM_WB_BNE,
       oQ => MEM_WB_oBNE);
	   
		REG_HALT: Reg_1 port map(iCLK => MEM_WB_clk,
		iReset	=> MEM_WB_rst,
		iD		=> MEM_WB_Halt,
		oQ		=> MEM_WB_oHalt);
	
end structural;
