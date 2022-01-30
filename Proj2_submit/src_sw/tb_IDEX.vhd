-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_IDEX.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is the testbench for the IF_ID_Registers.vhd file.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_IDEX is
  generic(gCLK_HPER   : time := 50 ns);
end tb_IDEX;

architecture behavior of tb_IDEX is

-- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  constant N : integer := 32;
  
  component ID_EX_Reg
	generic(N : integer := 32);
	port(ID_EX_clk : in std_logic;
		ID_EX_rst : in std_logic := '1';
		ID_EX_RegDst : in std_logic;	-- Control Signals
		ID_EX_RegWrite : in std_logic;
		ID_EX_ALUOp : in std_logic;
		ID_EX_ALUSrc : in std_logic;
		ID_EX_Branch : in std_logic;
		ID_EX_MemWrite : in std_logic;
		ID_EX_MemtoReg : in std_logic;
		ID_EX_Jump : in std_logic;
		ID_EX_Halt : in std_logic;
		ID_EX_BNE : in std_logic;
		ID_EX_JAL : in std_logic;
		ID_EX_JR : in std_logic;
		-- input Registers
		ID_EX_write_regDst : in std_logic_vector(4 downto 0);
		ID_EX_write_regout0 : in std_logic_vector(31 downto 0);
		ID_EX_write_regout1 : in std_logic_vector(31 downto 0);
		ID_EX_write_immi : in std_logic_vector(31 downto 0);
		ID_EX_write_pc_val : in std_logic_vector(31 downto 0);
		-- output
		ID_EX_oRegDst: out std_logic;	-- Control Signals
		ID_EX_oRegWrite: out std_logic;
		ID_EX_oALUOp: out std_logic;
		ID_EX_oALUSrc: out std_logic;
		ID_EX_oBranch: out std_logic;
		ID_EX_oMemWrite: out std_logic;
		ID_EX_oMemtoReg: out std_logic;
		ID_EX_oJump : out std_logic;
		ID_EX_oHalt : out std_logic;
		ID_EX_oBNE : out std_logic;
		ID_EX_oJAL : out std_logic;
		ID_EX_oJR : out std_logic;
		ID_EX_read_pc_val : out std_logic_vector(31 downto 0);
		ID_EX_read_regDst : out std_logic_vector(4 downto 0);
		ID_EX_read_regout0 : out std_logic_vector(31 downto 0);
		ID_EX_read_regout1 : out std_logic_vector(31 downto 0);
		ID_EX_read_immi : out std_logic_vector(31 downto 0));
end component;

signal CLK : std_logic := '0';
signal i_RST : std_logic;
signal ID_EX_write_pc_val : std_logic_vector(31 downto 0);

signal ID_EX_RegDst: std_logic;	-- Control Signals
signal ID_EX_RegWrite: std_logic;
signal ID_EX_ALUOp: std_logic;
signal ID_EX_ALUSrc: std_logic;
signal ID_EX_Branch: std_logic;
signal ID_EX_MemWrite: std_logic;
signal ID_EX_MemtoReg: std_logic;
signal ID_EX_Jump: std_logic;
signal ID_EX_Halt: std_logic;
signal ID_EX_BNE : std_logic;
signal ID_EX_JAL : std_logic;
signal ID_EX_JR : std_logic;
-- input Registers
signal ID_EX_write_regDst : std_logic_vector(4 downto 0);
signal ID_EX_write_regout0 : std_logic_vector(31 downto 0);
signal ID_EX_write_regout1 : std_logic_vector(31 downto 0);
signal ID_EX_write_immi : std_logic_vector(31 downto 0);
-- output
signal ID_EX_oRegDst: std_logic;	-- Control Signals
signal ID_EX_oRegWrite: std_logic;
signal ID_EX_oALUOp: std_logic;
signal ID_EX_oALUSrc: std_logic;
signal ID_EX_oBranch: std_logic;
signal ID_EX_oMemWrite: std_logic;
signal ID_EX_oMemtoReg: std_logic;
signal ID_EX_oJump: std_logic;
signal ID_EX_oHalt: std_logic;
signal ID_EX_oBNE : std_logic;
signal ID_EX_oJAL : std_logic;
signal ID_EX_oJR : std_logic;
signal ID_EX_read_regDst : std_logic_vector(4 downto 0);
signal ID_EX_read_regout0 : std_logic_vector(31 downto 0);
signal ID_EX_read_regout1 : std_logic_vector(31 downto 0);
signal ID_EX_read_immi : std_logic_vector(31 downto 0);
signal ID_EX_read_pc_val : std_logic_vector(31 downto 0);

begin

DUT: ID_EX_Reg
	generic map( N => N )
	port map(ID_EX_clk => CLK,
		ID_EX_rst => i_RST,
		ID_EX_RegDst => ID_EX_RegDst,
		ID_EX_RegWrite => ID_EX_RegWrite,
		ID_EX_ALUOp => ID_EX_ALUOp,
		ID_EX_ALUSrc => ID_EX_ALUSrc,
		ID_EX_Branch => ID_EX_Branch,
		ID_EX_MemWrite => ID_EX_MemWrite,
		ID_EX_MemtoReg => ID_EX_MemtoReg,
		ID_EX_Jump => ID_EX_Jump,
		ID_EX_Halt => ID_EX_Halt,
		ID_EX_BNE => ID_EX_BNE,
		ID_EX_JAL => ID_EX_JAL,
		ID_EX_JR => ID_EX_JR,
		ID_EX_write_regDst => ID_EX_write_regDst,
		ID_EX_write_regout0 => ID_EX_write_regout0,
		ID_EX_write_regout1 => ID_EX_write_regout1,
		ID_EX_write_immi => ID_EX_write_immi,
		ID_EX_write_pc_val => ID_EX_write_pc_val,
		ID_EX_oRegDst => ID_EX_oRegDst,
		ID_EX_oRegWrite => ID_EX_oRegWrite,
		ID_EX_oALUOp => ID_EX_oALUOp,
		ID_EX_oALUSrc => ID_EX_oALUSrc,
		ID_EX_oBranch => ID_EX_oBranch,
		ID_EX_oMemWrite => ID_EX_oMemWrite,
		ID_EX_oMemtoReg => ID_EX_oMemtoReg,
		ID_EX_oJump => ID_EX_oJump,
		ID_EX_oHalt => ID_EX_oHalt,
		ID_EX_oBNE => ID_EX_oBNE,
		ID_EX_oJAL => ID_EX_oJAL,
		ID_EX_oJR => ID_EX_oJR,
		ID_EX_read_pc_val => ID_EX_read_pc_val,
		ID_EX_read_regDst => ID_EX_read_regDst,
		ID_EX_read_regout0 => ID_EX_read_regout0,
		ID_EX_read_regout1 => ID_EX_read_regout1,
		ID_EX_read_immi => ID_EX_read_immi);
		
--This first process is to setup the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;
  
 -- P_RST: process
--  begin
  	--i_RST <= '0';   
   -- wait for gCLK_HPER/2;
--	i_RST <= '1';
--    wait for gCLK_HPER*2;
--	i_RST <= '0';
--	wait;
--  end process;

-- Testbench process  
  P_TB: process
  begin
  
	wait for cCLK_PER / 4;
	
	-- test 1
	ID_EX_RegDst <= '1';
	ID_EX_RegWrite <= '1';
	ID_EX_ALUOp <= '1';
	ID_EX_ALUSrc <= '1';
	ID_EX_Branch <= '1';
	ID_EX_MemWrite <= '1';
	ID_EX_MemtoReg <= '1';
	ID_EX_Jump <= '1';
	ID_EX_Halt <= '0';
	ID_EX_BNE <= '0';
	ID_EX_JAL <= '0';
	ID_EX_JR <= '0';
	ID_EX_write_regDst <= "11111";
	ID_EX_write_regout0 <= x"FFFF0000";
	ID_EX_write_regout1 <= x"00005555";
	ID_EX_write_immi <= x"0000AAAA";
	ID_EX_write_pc_val <= x"00400004";
	wait for cCLK_PER;
		
		-- test 2
	ID_EX_RegDst <= '1';
	ID_EX_RegWrite <= '1';
	ID_EX_ALUOp <= '1';
	ID_EX_ALUSrc <= '1';
	ID_EX_Branch <= '1';
	ID_EX_MemWrite <= '1';
	ID_EX_MemtoReg <= 'X';
	ID_EX_Jump <= '1';
	ID_EX_Halt <= '0';
	ID_EX_BNE <= '0';
	ID_EX_JAL <= '0';
	ID_EX_JR <= '1';
	ID_EX_write_regDst <= "11001";
	ID_EX_write_regout0 <= x"FF000000";
	ID_EX_write_regout1 <= x"00000055";
	ID_EX_write_immi <= x"000000AA";
	ID_EX_write_pc_val <= x"004000FF";
	wait for cCLK_PER;
		
    wait;
  end process;
end behavior;
	