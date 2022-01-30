-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- ID_EX_Reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the Decode/Execute pipeline register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ID_EX_Reg is
	port(ID_EX_clk : in std_logic;
		ID_EX_rst : in std_logic;
		ID_EX_RegDst: in std_logic;	-- Control Signals
		ID_EX_RegWrite: in std_logic;
		ID_EX_ALUOp: in std_logic_vector(3 downto 0);
		ID_EX_ALUSrc: in std_logic;
		ID_EX_Branch: in std_logic;
		ID_EX_MemWrite: in std_logic;
		ID_EX_MemtoReg: in std_logic;
		ID_EX_Jump: in std_logic;
		ID_EX_BNE : in std_logic;
		ID_EX_JAL : in std_logic;
		ID_EX_JR : in std_logic;
		-- input Registers
		--ID_EX_write_regDst : in std_logic_vector(4 downto 0);
		ID_EX_write_regout0 : in std_logic_vector(31 downto 0);
		ID_EX_write_regout1 : in std_logic_vector(31 downto 0);
		ID_EX_write_immi : in std_logic_vector(31 downto 0);
		ID_EX_write_pc_val : in std_logic_vector(31 downto 0);
		ID_EX_write_inst	: in std_logic_vector(31 downto 0);
		ID_EX_Halt : in std_logic;
		ID_EX_oHalt : out std_logic;
		-- output
		ID_EX_oRegDst: out std_logic;	-- Control Signals
		ID_EX_oRegWrite: out std_logic;
		ID_EX_oALUOp: out std_logic_vector(3 downto 0);
		ID_EX_oALUSrc: out std_logic;
		ID_EX_oBranch: out std_logic;
		ID_EX_oMemWrite: out std_logic;
		ID_EX_oMemtoReg: out std_logic;
		ID_EX_oJump: out std_logic;
		ID_EX_oBNE : out std_logic;
		ID_EX_oJAL : out std_logic;
		ID_EX_oJR : out std_logic;
		ID_EX_read_pc_val : out std_logic_vector(31 downto 0);
		--ID_EX_read_regDst : out std_logic_vector(4 downto 0);
		ID_EX_read_regout0 : out std_logic_vector(31 downto 0);
		ID_EX_read_regout1 : out std_logic_vector(31 downto 0);
		ID_EX_read_immi : out std_logic_vector(31 downto 0);
		ID_EX_read_inst	: out std_logic_vector(31 downto 0));
		
end ID_EX_Reg;

architecture structural of ID_EX_Reg is

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

component Reg_4 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic_vector(3 downto 0);
       oQ               : out std_logic_vector(3 downto 0));
end component;

component Reg_1 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic;
       oQ               : out std_logic);
end component;

begin

	REG_PC4: Reg_32 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_write_pc_val,
       oQ => ID_EX_read_pc_val);
	   
	REG_REGOUT0: Reg_32 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_write_regout0,
       oQ => ID_EX_read_regout0);
	   
	REG_REGOUT1: Reg_32 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_write_regout1,
       oQ => ID_EX_read_regout1);
	   
	REG_IMMI: Reg_32 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_write_immi,
       oQ => ID_EX_read_immi);
	   
	REG_INST: REG_32 port map(iCLK => ID_EX_clk,
		iReset 	=> ID_EX_rst,
		iD		=> ID_EX_write_inst,
		oQ		=> ID_EX_read_inst);
	   
	--REG_DST: Reg_5 port map(iCLK => ID_EX_clk,
    --   iReset => ID_EX_rst,
    --   iD => ID_EX_write_regDst,
    --   oQ => ID_EX_read_regDst);
	
	REG_HALT: Reg_1 port map(iCLK => ID_EX_clk,
		iReset	=> ID_EX_rst,
		iD		=> ID_EX_Halt,
		oQ		=> ID_EX_oHalt);
	
	   
	-- control signals
	REG_oRegDST: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_RegDst,
       oQ => ID_EX_oRegDst);
	
	REG_oREGWRITE: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_RegWrite,
       oQ => ID_EX_oRegWrite);
	
	REG_ALUOP: Reg_4 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_ALUOp,
       oQ => ID_EX_oALUOp);
	
	REG_ALUSRC: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_ALUSrc,
       oQ => ID_EX_oALUSrc);
	
	REG_BRANCH: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_Branch,
       oQ => ID_EX_oBranch);
	
	REG_MEMWRITE: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_MemWrite,
       oQ => ID_EX_oMemWrite);
	
	REG_MEMTOREG: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_MemtoReg,
       oQ => ID_EX_oMemtoReg);
	
	REG_JUMP: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_Jump,
       oQ => ID_EX_oJump);
	
	REG_JR: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_JR,
       oQ => ID_EX_oJR);
	
	REG_JAL: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_JAL,
       oQ => ID_EX_oJAL);
	
	REG_BNE: Reg_1 port map(iCLK => ID_EX_clk,
       iReset => ID_EX_rst,
       iD => ID_EX_BNE,
       oQ => ID_EX_oBNE);
	   
	
end structural;
