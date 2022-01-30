-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- MIPS_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a MIPS_Processor implementation.

-- 04/2/2021 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;

entity MIPS_Processor is
  generic(N : integer := 32);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  MIPS_Processor;


architecture structure of MIPS_Processor is

  -- Required data memory signals
  signal s_DMemWr       	: std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        	: std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    	: std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     	: std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr 	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         	: std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         	: std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         	: std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated
  

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
		clk          : in std_logic;
		addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
		data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
		we           : in std_logic := '1';
		q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

  -- TODO: You may add any additional signals or components your implementation 
  --       requires below this comment
  
    -- Control signals
	-- DMemWr is MemWrite
	signal 	s_MemtoReg 		: std_logic;
	signal	s_Jump 			: std_logic;
	signal 	s_JAL			: std_logic;
	signal 	s_JR			: std_logic;
	signal	s_Branch 		: std_logic;
	signal	s_BNE			: std_logic;
	signal	s_ALUOp 		: std_logic_vector(3 downto 0);
	signal	s_ALUSrc 		: std_logic;
	signal	s_RegDst 		: std_logic;
	signal 	s_CTRLRegWr		: std_logic;
	signal	s_CTRLDMemWr	: std_logic;
	signal 	s_SignExt		: std_logic;
	signal	s_CTRLHalt		: std_logic;
	  
	-- Other signals
	signal s_Zero			: std_logic := '0';
	signal s_ExtImm			: std_logic_vector(31 downto 0);
	signal s_RegData0		: std_logic_vector(31 downto 0);
	signal s_RegData1		: std_logic_vector(31 downto 0);
	signal s_ALUSrcMux  	: std_logic_vector(31 downto 0);
	signal s_ALUControl		: std_logic_vector(3 downto 0);
	signal s_ALUOutTemp		: std_logic_vector(31 downto 0);
	signal s_RegWrMuxData 	: std_logic_vector(31 downto 0);
	signal s_RegWrMuxAddr	: std_logic_vector(4 downto 0);
	
	-- Pipeline signals
	-- IFID
	signal s_IFID_PCPlus4	: std_logic_vector(31 downto 0);
	signal s_IFID_inst		: std_logic_vector(31 downto 0);
	-- IDEX
	signal 	s_ID_EX_oRegDst: std_logic;
	signal 	s_ID_EX_oRegWrite:  std_logic;
	signal 	s_ID_EX_oALUOp:  std_logic_vector(3 downto 0);
	signal	s_ID_EX_oALUSrc:  std_logic;
	signal	s_ID_EX_oBranch:  std_logic;
	signal	s_ID_EX_oMemWrite:  std_logic;
	signal	s_ID_EX_oMemtoReg:  std_logic;
	signal	s_ID_EX_oJump:  std_logic;
	signal	s_ID_EX_oHalt:  std_logic;
	signal	s_ID_EX_oBNE :  std_logic;
	signal	s_ID_EX_oJAL :  std_logic;
	signal	s_ID_EX_oJR :  std_logic;
	signal	s_ID_EX_read_pc_val : std_logic_vector(31 downto 0);
	signal	s_ID_EX_read_regout0 :  std_logic_vector(31 downto 0);
	signal	s_ID_EX_read_regout1 :  std_logic_vector(31 downto 0);
	signal	s_ID_EX_read_immi :  std_logic_vector(31 downto 0);
	signal	s_ID_EX_read_inst	:  std_logic_vector(31 downto 0);
	-- EXMEM
	signal	s_EX_MEM_oRegWrite:  std_logic;
	signal	s_EX_MEM_oMemWrite:  std_logic;
	signal	s_EX_MEM_oMemtoReg:  std_logic;
	signal	s_EX_MEM_oJAL :  std_logic;
	signal	s_EX_MEM_oJump: std_logic;
	signal	s_EX_MEM_oBranch: std_logic;
	signal	s_EX_MEM_oBNE : std_logic;
	signal	s_EX_MEM_oJR : std_logic;
	signal	s_EX_MEM_oHalt : std_logic;
	signal	s_EX_MEM_oRegDst : std_logic;
	signal	s_EX_MEM_oZero	: std_logic;
	signal	s_EX_MEM_read_regout1 :  std_logic_vector(31 downto 0);
	signal	s_EX_MEM_read_pc_val :  std_logic_vector(31 downto 0);
	signal	s_EX_MEM_read_AluResult :  std_logic_vector(31 downto 0);
	signal	s_EX_MEM_read_inst:  std_logic_vector(31 downto 0);
	signal	s_EX_MEM_read_immi	: std_logic_vector(31 downto 0);
	-- MEMWB
	signal	s_MEM_WB_oRegWrite: std_logic;
	signal	s_MEM_WB_oMemtoReg:  std_logic;
	signal	s_MEM_WB_oJAL :  std_logic;
	signal	s_MEM_WB_oJump:  std_logic;
	signal	s_MEM_WB_oBranch:  std_logic;
	signal	s_MEM_WB_oBNE :  std_logic;
	signal	s_MEM_WB_oJR :  std_logic;
	signal	s_MEM_WB_oRegDst:  std_logic;
	signal	s_MEM_WB_oZero	: std_logic;
	signal	s_MEM_WB_read_regout1:  std_logic_vector(31 downto 0);
	signal	s_MEM_WB_read_pc_val :  std_logic_vector(31 downto 0);
	signal	s_MEM_WB_read_AluResult :  std_logic_vector(31 downto 0);
	signal	s_MEM_WB_read_MemData :  std_logic_vector(31 downto 0);
	signal	s_MEM_WB_read_inst :  std_logic_vector(31 downto 0);
	signal	s_MEM_WB_read_immi	: std_logic_vector(31 downto 0);
 
-- fetch was once a unit but had to be broken up so this is the unit broken up
component Reg is

  port(iCLK 	: in std_logic;
       iReset	: in std_logic;
       iD  		: in std_logic_vector(31 downto 0);
       oQ 		: out std_logic_vector(31 downto 0));

end component;

component adder_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_A   	: in std_logic_vector(N-1 downto 0);
       	i_B   	: in std_logic_vector(N-1 downto 0);
       	o_S    	: out std_logic_vector(N-1 downto 0);
		o_OF    : out std_logic);
end component;

component SLL2_26t28 is
  port(
       iD		: in std_logic_vector(25 downto 0);
       oQ		: out std_logic_vector(27 downto 0));
end component;

component SLL2_32 is
  port(
       iD		: in std_logic_vector(31 downto 0);
       oQ		: out std_logic_vector(31 downto 0));
end component;

component xorg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

component andg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end component;

signal s_BAnd											: std_logic;
signal s_PCiD, s_BAddy, s_PCPlus4, s_oBMux, s_PCPlusB, s_PCJumpMux	: std_logic_vector(31 downto 0);
signal s_JAddyEXT										: std_logic_vector(27 downto 0);
signal s_BXOr											: std_logic;

--- Fetch unit break up end. 

  component IF_ID_Reg is
	port(iIFID_clk : in std_logic;
		iIFID_rst : in std_logic := '1';
		iIFID_write_instr : in std_logic_vector(31 downto 0);
		iIFID_write_pc_val : in std_logic_vector(31 downto 0);
		oIFID_read_instr : out std_logic_vector(31 downto 0);
		oIFID_read_pc_val : out std_logic_vector(31 downto 0));
	end component;
  
  component extender is
	 port (	
		i16	: in	std_logic_vector(15 downto 0);
		iZS	: in	std_logic;
		o32	: out	std_logic_vector(31 downto 0));
	end component;
	
  component Control_Logic_Module is
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
  end component;
  
  component ID_EX_Reg is
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
  end component;
  
  component mux2t1_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_S          : in std_logic;
       i_D0         : in std_logic_vector(N-1 downto 0);
       i_D1         : in std_logic_vector(N-1 downto 0);
       o_O          : out std_logic_vector(N-1 downto 0));

  end component;
  
  component regfile is

  port(iCLk      	: in std_logic;
	   iRST			: in std_logic;
       iRA0 		: in std_logic_vector(4 downto 0);
       iRA1 		: in std_logic_vector(4 downto 0);
       iWA 			: in std_logic_vector(4 downto 0);
       iWD			: in std_logic_vector(31 downto 0);
       iWE			: in std_logic;
       oR0			: out std_logic_vector(31 downto 0);
       oR1 			: out std_logic_vector(31 downto 0));

  end component;
  
  component ALU_Control is
  port(	ALUOp 		: in std_logic_vector(3 downto 0);
		Funct 		: in std_logic_vector(5 downto 0);
		ALUControl 	: out std_logic_vector(3 downto 0);
		oJR			: out std_logic);
  end component;
  
  component ALU is
	generic(N : integer := 32);
	port(
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
		ALUControl : in std_logic_vector(3 downto 0);
		ishamt		: in std_logic_vector(4 downto 0);
		ALU_Out : out std_logic_vector(31 downto 0);
		Zero : out std_logic := '0';
		Overflow : out std_logic := '0');
  end component;
  
component EX_MEM_Reg is
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
end component;
		
component MEM_WB_Reg is
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
end component;

begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;


  IMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  s_DMemAddr <= s_EX_MEM_read_AluResult;
  s_DMemWr	 <= s_EX_MEM_oMemWrite;
  s_DMemData <= s_EX_MEM_read_regout1;
  DMem: mem
    generic map(ADDR_WIDTH => 10,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)
  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 
 

-- begin the break up of the fetch architecture.
PC0: Reg
  port map(
	iCLK	=> iCLK,
	iReset	=> iRST,
	iD		=> s_PCiD,
	oQ		=> s_NextInstAddr);

ADD0: adder_N
  generic map(N => 32)
  port map(
	i_A		=> s_NextInstAddr,
    i_B   	=> x"00000004",
    o_S    	=> s_PCPlus4);  
	
IFID: IF_ID_Reg
  port map(
	iIFID_clk 			=> iCLK,
	iIFID_rst 			=> iRST,
	iIFID_write_instr 	=> s_Inst,
	iIFID_write_pc_val 	=> s_PCPlus4,
	oIFID_read_instr 	=> s_IFID_inst,
	oIFID_read_pc_val 	=> s_IFID_PCPlus4);

IDEX: ID_EX_Reg
	port map(ID_EX_clk 		=> iCLK,
		ID_EX_rst		=> iRST,
		ID_EX_RegDst	=> s_RegDst,
		ID_EX_RegWrite	=> s_CTRLRegWr,
		ID_EX_ALUOp		=> s_ALUOp,
		ID_EX_ALUSrc	=> s_ALUSrc,
		ID_EX_Branch	=> s_Branch,
		ID_EX_MemWrite	=> s_CTRLDMemWr,
		ID_EX_MemtoReg	=> s_MemtoReg,
		ID_EX_Jump		=> s_Jump,
		ID_EX_BNE 		=> s_BNE,
		ID_EX_JAL		=> s_JAL,
		ID_EX_JR 		=> s_JR,
		ID_EX_Halt		=> s_CTRLHalt,
		-- input Registers
		--ID_EX_write_regDst : in std_logic_vector(4 downto 0);
		ID_EX_write_regout0 	=> s_RegData0,
		ID_EX_write_regout1 	=> s_RegData1,
		ID_EX_write_immi 		=> s_ExtImm,
		ID_EX_write_pc_val		=> s_IFID_PCPlus4,
		ID_EX_write_inst		=> s_IFID_inst,
		-- output
		ID_EX_oHalt		=> s_ID_EX_oHalt,
		ID_EX_oRegDst 	=> s_ID_EX_oRegDst,
		ID_EX_oRegWrite => s_ID_EX_oRegWrite,
		ID_EX_oALUOp	=> s_ID_EX_oALUOp,
		ID_EX_oALUSrc	=> s_ID_EX_oALUSrc,
		ID_EX_oBranch	=>s_ID_EX_oBranch,
		ID_EX_oMemWrite	=>s_ID_EX_oMemWrite,
		ID_EX_oMemtoReg	=>s_ID_EX_oMemtoReg,
		ID_EX_oJump	=>s_ID_EX_oJump,
		ID_EX_oBNE	=>s_ID_EX_oBNE,
		ID_EX_oJAL	=>s_ID_EX_oJAL,
		ID_EX_oJR	=>s_ID_EX_oJR,
		ID_EX_read_pc_val	=>s_ID_EX_read_pc_val,
		--ID_EX_read_regDst : out std_logic_vector(4 downto 0);
		ID_EX_read_regout0	=>s_ID_EX_read_regout0,
		ID_EX_read_regout1	=>s_ID_EX_read_regout1,
		ID_EX_read_immi	=>s_ID_EX_read_immi,
		ID_EX_read_inst	=>s_ID_EX_read_inst);
		
EXMEM: EX_MEM_Reg
	port map(EX_MEM_clk => iCLK,
		EX_MEM_rst => iRST,
	-- Control Signals
		EX_MEM_RegWrite => s_ID_EX_oRegWrite,
		EX_MEM_MemWrite => s_ID_EX_oMemWrite,
		EX_MEM_MemtoReg	=> s_ID_EX_oMemtoReg,
		EX_MEM_JAL		=> s_ID_EX_oJAL,
		EX_MEM_Jump		=> s_ID_EX_oJump,
		EX_MEM_Branch	=> s_ID_EX_oBranch,
		EX_MEM_BNE		=> s_ID_EX_oBNE,
		EX_MEM_JR		=> s_ID_EX_oJR,
		EX_MEM_RegDst	=> s_ID_EX_oRegDst,
		EX_MEM_Halt		=> s_ID_EX_oHalt,
		EX_MEM_Zero		=> s_Zero,
		-- Registers
		EX_MEM_write_AluResult 	=> s_ALUOutTemp,
		EX_MEM_write_regout1	=> s_ID_EX_read_regout1,
		EX_MEM_write_pc_val		=> s_ID_EX_read_pc_val,
		EX_MEM_write_inst		=> s_ID_EX_read_inst,
		EX_MEM_write_immi		=> s_ID_EX_read_immi,
		-- output
	-- Control Signals
		EX_MEM_oZero			=> s_EX_MEM_oZero,
		EX_MEM_oHalt			=> s_EX_MEM_oHalt,
		EX_MEM_oRegWrite		=> s_EX_MEM_oRegWrite,
		EX_MEM_oMemWrite		=> s_EX_MEM_oMemWrite,
		EX_MEM_oMemtoReg		=> s_EX_MEM_oMemtoReg,
		EX_MEM_oJAL				=> s_EX_MEM_oJAL,
		EX_MEM_oJump			=> s_EX_MEM_oJump,
		EX_MEM_oBranch			=> s_EX_MEM_oBranch,
		EX_MEM_oBNE				=> s_EX_MEM_oBNE,
		EX_MEM_oJR				=> s_EX_MEM_oJR,
		EX_MEM_oRegDst			=> s_EX_MEM_oRegDst,
		EX_MEM_read_regout1		=> s_EX_MEM_read_regout1,
		EX_MEM_read_pc_val		=> s_EX_MEM_read_pc_val,
		EX_MEM_read_AluResult	=> s_EX_MEM_read_AluResult,
		EX_MEM_read_inst		=> s_EX_MEM_read_inst,
		EX_MEM_read_immi		=> s_EX_MEM_read_immi); 

MEMWB : MEM_WB_Reg
	port map(MEM_WB_clk => iCLK,
		MEM_WB_rst		=> iRST,
	-- Control Signals
		MEM_WB_RegWrite 	=> s_EX_MEM_oRegWrite,
		MEM_WB_RegDst 	=> s_EX_MEM_oRegDst,
		MEM_WB_MemtoReg 	=> s_EX_MEM_oMemtoReg,
		MEM_WB_JAL 	=> s_EX_MEM_oJAL,
		MEM_WB_Jump 	=> s_EX_MEM_oJump,
		MEM_WB_Branch 	=> s_EX_MEM_oBranch,
		MEM_WB_BNE 	=> s_EX_MEM_oBNE,
		MEM_WB_JR 	=> s_EX_MEM_oJR,
		MEM_WB_Halt	=> s_EX_MEM_oHalt,
		MEM_WB_Zero	=> s_EX_MEM_oZero,
		-- input Registers
		MEM_WB_write_regout1	=> s_EX_MEM_read_regout1,
		MEM_WB_write_pc_val 	=> s_EX_MEM_read_pc_val,
		MEM_WB_write_AluResult 	=> s_EX_MEM_read_AluResult,
		MEM_WB_write_MemData 	=> s_DMemOut,
		MEM_WB_write_inst 		=> s_EX_MEM_read_inst,
		MEM_WB_write_immi		=> s_EX_MEM_read_immi,
		-- output
		MEM_WB_oZero			=> s_MEM_WB_oZero,
		MEM_WB_oHalt			=> s_Halt,
		MEM_WB_oRegWrite		=> s_MEM_WB_oRegWrite,
		MEM_WB_oMemtoReg		=> s_MEM_WB_oMemtoReg,
		MEM_WB_oJAL		=> s_MEM_WB_oJAL,
		MEM_WB_oJump		=> s_MEM_WB_oJump,
		MEM_WB_oBranch		=> s_MEM_WB_oBranch,
		MEM_WB_oBNE		=> s_MEM_WB_oBNE,
		MEM_WB_oJR		=> s_MEM_WB_oJR,
		MEM_WB_oRegDst		=> s_MEM_WB_oRegDst,
		MEM_WB_read_regout1		=> s_MEM_WB_read_regout1,
		MEM_WB_read_pc_val		=> s_MEM_WB_read_pc_val,
		MEM_WB_read_AluResult		=> s_MEM_WB_read_AluResult,
		MEM_WB_read_MemData		=> s_MEM_WB_read_MemData,
		MEM_WB_read_inst		=> s_MEM_WB_read_inst,
		MEM_WB_read_immi		=> s_MEM_WB_read_immi);
		

SLL1: SLL2_32
  port map(
    iD					=> s_MEM_WB_read_immi,
	oQ					=> s_BAddy);
	
ADD1: adder_N
  generic map(N => 32)
  port map(
	i_A					=> s_MEM_WB_read_pc_val,
    i_B   				=> s_BAddy,
    o_S    				=> s_PCPlusB);
	
XOR0: xorg2
  port map(
	i_A					=> s_MEM_WB_oZero,
	i_B					=> s_MEM_WB_oBNE,
	o_F					=> s_BXOr);
	
	
AND0: andg2
  port map(
    i_A					=> s_MEM_WB_oBranch,
	i_B					=> s_BXOr,
	o_F					=> s_BAnd);

BMUX: mux2t1_N
  generic map(N => 32)
  port map(
    i_S 				=> s_BAnd,
	i_D0				=> s_PCPlus4,
	i_D1(31 downto 0)	=> s_PCPlusB,
	o_O					=> s_oBMux);
	
SLL0: SLL2_26t28
  port map(
    iD		=> s_MEM_WB_read_inst(25 downto 0),
    oQ   	=> s_JAddyEXT);

JMUX: mux2t1_N
  generic map(N => 32)
  port map(
    i_S 				=> s_MEM_WB_oJump,
	i_D0				=> s_oBMux,
	i_D1(31 downto 28)	=> s_MEM_WB_read_pc_val(31 downto 28),
	i_D1(27 downto 0)	=> s_JAddyExt,
	o_O					=> s_PCJumpMux);
	
JRMUX: mux2t1_N
  generic map(N => 32)
  port map(
	i_S					=> s_MEM_WB_oJR,
	i_D0				=> s_PCJumpMux,
	i_D1				=> s_MEM_WB_read_regout1,
	o_O					=> s_PCiD);

-- end of fetch break up	
	
 Ext: extender
 port map(
	i16				=> s_IFID_inst(15 downto 0),
	iZS				=> s_SignExt,
	o32				=> s_ExtImm);

 CLM: Control_Logic_Module
 port map (
	iOpcode 		=> s_IFID_inst(31 downto 26),
	oMemWrite 		=> s_CTRLDMemWr,
	oMemtoReg 		=> s_MemtoReg,
	oJump 			=> s_Jump,
	oJAL			=> s_JAL,
	oBranch 		=> s_Branch,
	oBNE			=> s_BNE,
	oALUOp 			=> s_ALUOp,
	oALUSrc 		=> s_ALUSrc,
	oRegDst 		=> s_RegDst,
	oRegWrite 		=> s_CTRLRegWr,
	oSignExt		=> s_SignExt,
	oHalt			=> s_CTRLHalt);
	
 MUXRegAD: mux2t1_N
 generic map(
	N => 5)
 port map (
	i_S				=> s_MEM_WB_oRegDst,
	i_D0			=> s_MEM_WB_read_inst(20 downto 16),
	i_D1			=> s_MEM_WB_read_inst(15 downto 11),
	o_O				=> s_RegWrMuxAddr);
	
 MUXJALDT: mux2t1_N
 generic map(
	N => 32)
 port map (
	i_S				=> s_MEM_WB_oJAL,
	i_D0			=> s_RegWrMuxData,
	i_D1			=> s_MEM_WB_read_pc_val,
	o_O				=> s_RegWrData);

 MUXJALAD: mux2t1_N
 generic map(
	N => 5)
 port map (
	i_S				=> s_MEM_WB_oJAL,
	i_D0			=> s_RegWrMuxAddr,
	i_D1			=> "11111",
	o_O				=> s_RegWrAddr);
	
	s_RegWr <= s_MEM_WB_oRegWrite;
 
 RegFile0: regfile
 port map(
	iCLk			=> iCLK,
	iRST			=> iRST,
	iRA0			=> s_IFID_inst(25 downto 21),
	iRA1			=> s_IFID_inst(20 downto 16),
	iWA				=> s_RegWrAddr,
	iWD				=> s_RegWrData,
	iWE				=> s_RegWr,
	oR0				=> s_RegData0,
	oR1 			=> s_RegData1);

 MUXALU: mux2t1_N
 generic map(
	N => N)
 port map (
	i_S				=> s_ID_EX_oALUSrc,
	i_D0			=> s_ID_EX_read_regout1,
	i_D1			=> s_ID_EX_read_immi,
	o_O				=> s_ALUSrcMux);
	
 ALUCTRL: ALU_Control
 port map (
	ALUOp 			=> s_ID_EX_oALUOp,
	Funct 			=> s_ID_EX_read_inst(5 downto 0),
	ALUControl		=> s_ALUControl,
	oJR				=> s_JR);
	
	
 ALU0: ALU
 generic map(
	N => N)
 port map (
	A				=> s_ID_EX_read_regout0,
	B				=> s_ALUSrcMux,
	ALUControl		=> s_ALUControl,
	ishamt			=> s_ID_EX_read_inst(10 downto 6),
	ALU_Out			=> s_ALUOutTemp,
	Zero 			=> s_Zero,
	Overflow 		=> s_Ovfl);
	
 oALUOut	<= s_ALUOutTemp;
	
 MUXRegWrt: mux2t1_N
 generic map(
	N => N)
 port map (
	i_S				=> s_MEM_WB_oMemtoReg,
	i_D0			=> s_MEM_WB_read_AluResult,
	i_D1			=> s_MEM_WB_read_MemData,
	o_O				=> s_RegWrMuxData);
	
end structure;
