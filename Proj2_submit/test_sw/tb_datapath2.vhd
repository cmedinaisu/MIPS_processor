-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_datapath2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a testbench for the data path
--              
-- 03/28/2021 by Patrick Bruce.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;  -- For logic types I/O
library std;
use std.env.all;                -- For hierarchical/external signals
use std.textio.all;             -- For basic I/O

entity tb_datapath2 is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_datapath2;

architecture dataflow of tb_datapath2 is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component datapath2 is
  port(iCLk                 : in std_logic;
       iRA0 		        : in std_logic_vector(4 downto 0);
       iRA1 		        : in std_logic_vector(4 downto 0);
       iWA 		            : in std_logic_vector(4 downto 0);
       iREGWE               : in std_logic;
       iEXTctrl             : in std_logic;
       iIMM                 : in std_logic_vector(15 downto 0);
       iALUctrl             : in std_logic;                       -- dictates the add or subtract function of ALU
       iALUsrc              : in std_logic;                       -- dictates whether to use immidiate or R1
       iMEMWE			    : in std_logic;
       iREGsrc			    : in std_logic);
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic 												:= '0';

signal s_iRA0, s_iRA1, s_iWA   												: std_logic_vector(4 downto 0) := "00000";
signal s_iIMM																: std_logic_vector(15 downto 0) := X"0000";
signal s_iREGWE, s_iALUctrl, s_iALUsrc, s_iEXTctrl, s_iMEMWE, s_iREGsrc   	: std_logic := '0';

begin

DP0: datapath2
 port map (	
    iCLK		=> CLK,
	iRA0		=> s_iRA0,
	iRA1		=> s_iRA1,
	iWA			=> s_iWA,
	iREGWE		=> s_iREGWE,
	iEXTctrl	=> s_iEXTctrl,
	iIMM		=> s_iIMM,
	iALUctrl	=> s_iALUctrl,
	iALUsrc		=> s_iALUsrc,
	iMEMWE		=> s_iMEMWE,
	iREGsrc		=> s_iREGsrc);

P_CLK: process
  begin
    CLK <= '1';         -- clock starts at 1
    wait for gCLK_HPER; -- after half a cycle
    CLK <= '0';         -- clock becomes a 0 (negative edge)
    wait for gCLK_HPER; -- after half a cycle, process begins evaluation again
  end process;

P_RST: process
  begin
  	reset <= '0';   
    wait for gCLK_HPER/2;
	reset <= '1';
    wait for gCLK_HPER*2;
	reset <= '0';
	wait;
  end process;  

 P_TEST_CASES: process
  begin
    wait for gCLK_HPER/2; -- for waveform clarity, I prefer not to change inputs on clk edges

    -- addi $25, $0, 0 :
    s_iRA0      <= "00000";
    s_iRA1      <= "11001";
    s_iWA       <= "11001";
    s_iIMM      <= X"0000";
    s_iREGWE    <= '1';
    s_iALUctrl  <= '0';
    s_iALUsrc   <= '1';
    s_iEXTctrl  <= '1';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2;

    -- addi $26, $0, 256 :
    s_iRA0      <= "00000";
    s_iRA1      <= "11010";
    s_iWA       <= "11010";
    s_iIMM      <= X"0080";
    s_iREGWE    <= '1';
    s_iALUctrl  <= '0';
    s_iALUsrc   <= '1';
    s_iEXTctrl  <= '1';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2;

    -- lw $1, 0($25) :
    s_iRA0      <= "11001";
    s_iRA1      <= "00001";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0000";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;

    -- lw $2, 4($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0001";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --sw $1, 0($26)
    s_iRA0      <= "11010";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0000";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2;  

    --lw $2, 8($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0002";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;  

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --sw $1, 4($26)
    s_iRA0      <= "11010";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0001";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2;  
  
    --lw $2, 12($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0003";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;  

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --sw $1, 8($26)
    s_iRA0      <= "11010";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0002";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2; 

    --lw $2, 16($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0004";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;  

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --sw $1, 12($26)
    s_iRA0      <= "11010";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0003";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2;

    --lw $2, 20($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0005";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;  

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --sw $1, 16($26)
    s_iRA0      <= "11010";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0004";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2;

    --lw $2, 24($25)
    s_iRA0      <= "11001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00010";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"0006";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '1';
    wait for gCLK_HPER*2;  

    --add $1, $1, $2
    s_iRA0      <= "00001";
    s_iRA1      <= "00010";
    s_iREGWE    <= '1';
    s_iWA       <= "00001";
    s_iALUsrc   <= '0';
    s_iIMM      <= X"XXXX";
    s_iEXTctrl  <= 'X';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2; 

    --addi $27, $0, 512 # Load &B[256]
    s_iRA0      <= "00000";
    s_iRA1      <= "11011";
    s_iWA       <= "11011";
    s_iIMM      <= X"0100";
    s_iREGWE    <= '1';
    s_iALUctrl  <= '0';
    s_iALUsrc   <= '1';
    s_iEXTctrl  <= '1';
    s_iMEMWE    <= '0';
    s_iREGsrc   <= '0';
    wait for gCLK_HPER*2;

    --sw $1, -4($27) # Store $1 into B[255]
    s_iRA0      <= "11011";
    s_iRA1      <= "00001";
    s_iREGWE    <= '0';
    s_iWA       <= "XXXXX";
    s_iALUsrc   <= '1';
    s_iIMM      <= X"FFFC";
    s_iEXTctrl  <= '1';
    s_iALUctrl  <= '0';
    s_iMEMWE    <= '1';
    s_iREGsrc   <= 'X';
    wait for gCLK_HPER*2;

  end process;

end dataflow;