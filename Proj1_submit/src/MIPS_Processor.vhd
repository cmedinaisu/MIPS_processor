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
	signal 	s_SignExt		: std_logic;
	  
	-- Other signals
	signal s_Zero			: std_logic := '0';
	signal s_ExtImm			: std_logic_vector(31 downto 0);
	signal s_RegData1		: std_logic_vector(31 downto 0);
	signal s_ALUSrcMux  	: std_logic_vector(31 downto 0);
	signal s_ALUControl		: std_logic_vector(3 downto 0);
	signal s_ALUOutTemp		: std_logic_vector(31 downto 0);
	signal s_RegWrMuxData 	: std_logic_vector(31 downto 0);
	signal s_RegWrMuxAddr	: std_logic_vector(4 downto 0);
 
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
  
  s_DMemAddr <= s_ALUOutTemp;
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

SLL1: SLL2_32
  port map(
    iD					=> s_ExtImm,
	oQ					=> s_BAddy);
	
ADD1: adder_N
  generic map(N => 32)
  port map(
	i_A					=> s_PCPlus4,
    i_B   				=> s_BAddy,
    o_S    				=> s_PCPlusB);
	
XOR0: xorg2
  port map(
	i_A					=> s_Zero,
	i_B					=> s_BNE,
	o_F					=> s_BXOr);
	
	
AND0: andg2
  port map(
    i_A					=> s_Branch,
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
    iD		=> s_Inst(25 downto 0),
    oQ   	=> s_JAddyEXT);

JMUX: mux2t1_N
  generic map(N => 32)
  port map(
    i_S 				=> s_Jump,
	i_D0				=> s_oBMux,
	i_D1(31 downto 28)	=> s_PCPlus4(31 downto 28),
	i_D1(27 downto 0)	=> s_JAddyExt,
	o_O					=> s_PCJumpMux);
	
JRMUX: mux2t1_N
  generic map(N => 32)
  port map(
	i_S					=> s_JR,
	i_D0				=> s_PCJumpMux,
	i_D1				=> s_RegData1,
	o_O					=> s_PCiD);

-- end of fetch break up	
	
 Ext: extender
 port map(
	i16				=> s_Inst(15 downto 0),
	iZS				=> s_SignExt,
	o32				=> s_ExtImm);

 CLM: Control_Logic_Module
 port map (
	iOpcode 		=> s_Inst(31 downto 26),
	oMemWrite 		=> s_DMemWr,
	oMemtoReg 		=> s_MemtoReg,
	oJump 			=> s_Jump,
	oJAL			=> s_JAL,
	oBranch 		=> s_Branch,
	oBNE			=> s_BNE,
	oALUOp 			=> s_ALUOp,
	oALUSrc 		=> s_ALUSrc,
	oRegDst 		=> s_RegDst,
	oRegWrite 		=> s_RegWr,
	oSignExt		=> s_SignExt,
	oHalt			=> s_Halt);
	
 MUXRegAD: mux2t1_N
 generic map(
	N => 5)
 port map (
	i_S				=> s_RegDst,
	i_D0			=> s_Inst(20 downto 16),
	i_D1			=> s_Inst(15 downto 11),
	o_O				=> s_RegWrMuxAddr);
	
 MUXJALDT: mux2t1_N
 generic map(
	N => 32)
 port map (
	i_S				=> s_JAL,
	i_D0			=> s_RegWrMuxData,
	i_D1			=> s_PCPlus4,
	o_O				=> s_RegWrData);

 MUXJALAD: mux2t1_N
 generic map(
	N => 5)
 port map (
	i_S				=> s_JAL,
	i_D0			=> s_RegWrMuxAddr,
	i_D1			=> "11111",
	o_O				=> s_RegWrAddr);
 
 RegFile0: regfile
 port map(
	iCLk			=> iCLK,
	iRST			=> iRST,
	iRA0			=> s_inst(25 downto 21),
	iRA1			=> s_inst(20 downto 16),
	iWA				=> s_RegWrAddr,
	iWD				=> s_RegWrData,
	iWE				=> s_RegWr,
	oR0				=> s_RegData1,
	oR1 			=> s_DMemData);

 MUXALU: mux2t1_N
 generic map(
	N => N)
 port map (
	i_S				=> s_ALUSrc,
	i_D0			=> s_DMemData,
	i_D1			=> s_ExtImm,
	o_O				=> s_ALUSrcMux);
	
 ALUCTRL: ALU_Control
 port map (
	ALUOp 			=> s_ALUOp,
	Funct 			=> s_Inst(5 downto 0),
	ALUControl		=> s_ALUControl,
	oJR				=> s_JR);
	
	
 ALU0: ALU
 generic map(
	N => N)
 port map (
	A				=> s_RegData1,
	B				=> s_ALUSrcMux,
	ALUControl		=> s_ALUControl,
	ishamt			=> s_Inst(10 downto 6),
	ALU_Out			=> s_ALUOutTemp,
	Zero 			=> s_Zero,
	Overflow 		=> s_Ovfl);
	
 oALUOut	<= s_ALUOutTemp;
	
 MUXRegWrt: mux2t1_N
 generic map(
	N => N)
 port map (
	i_S				=> s_MemtoReg,
	i_D0			=> s_ALUOutTemp,
	i_D1			=> s_DMemOut,
	o_O				=> s_RegWrMuxData);
	
end structure;
