-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- tb_datapath.vhd
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

entity tb_datapath is
  generic(gCLK_HPER   : time := 10 ns);   -- Generic for half of the clock cycle period
end tb_datapath;

architecture dataflow of tb_datapath is

-- Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

component datapath is

  port(iCLk                         : in std_logic;
       iRA0 		            : in std_logic_vector(4 downto 0);
       iRA1 		            : in std_logic_vector(4 downto 0);
       iWA 		            : in std_logic_vector(4 downto 0);
       iREGWE                       : in std_logic;
       iEXTctrl			    : in std_logic;
       iIMM                         : in std_logic_vector(15 downto 0);
       iALUctrl                          : in std_logic;                       -- dictates the add or subtract function of ALU
       iALUsrc                      : in std_logic;                       -- dictates whether to use immidiate or R1
       oRES 		            : out std_logic_vector(31 downto 0);  
       oR1		            : out std_logic_vector(31 downto 0));

end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset : std_logic := '0';

signal s_iRA0, s_iRA1, s_iWA    : std_logic_vector(4 downto 0) := "00000";
signal s_oRES, s_oR1   		: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
signal s_iIMM			: std_logic_vector(15 downto 0) := X"0000";
signal s_iS, s_iREGWE, s_iALUctrl, s_iALUsrc, s_iEXTctrl   	: std_logic := '0';

begin

DP0: datapath
 port map (	
        iCLK		=> CLK,
	iRA0		=> s_iRA0,
	iRA1		=> s_iRA1,
	iWA		=> s_iWA,
	iREGWE		=> s_iREGWE,
	iEXTctrl	=> s_iEXTctrl,
	iIMM		=> s_iIMM,
	iALUctrl	=> s_iALUctrl,
	iALUsrc		=> s_iALUsrc,
	oRES		=> s_oRES,
	oR1		=> s_oR1);

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

    -- Test case 1:
    s_iEXTctrl <= '1';
    s_iWA      <= "00001";
    s_iIMM     <= "0000000000000001";
    s_iRA0     <= "00000";
    s_iALUsrc  <= '1';
    s_iREGWE      <= '1';
    wait for gCLK_HPER*2;

    -- Test case 2:
    s_iWA     <= "00010";
    s_iIMM    <= "0000000000000010";
    s_iRA0    <= "00000";
    s_iRA1    <= "00001";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "00011";
    s_iIMM    <= "0000000000000011";
    s_iRA0    <= "00000";
    s_iRA1    <= "00010";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "00100";
    s_iIMM    <= "0000000000000100";
    s_iRA0    <= "00000";
    s_iRA1    <= "00011";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "00101";
    s_iIMM    <= "0000000000000101";
    s_iRA0    <= "00000";
    s_iRA1    <= "00100";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "00110";
    s_iIMM    <= "0000000000000110";
    s_iRA0    <= "00000";
    s_iRA1    <= "00101";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "00111";
    s_iIMM    <= "0000000000000111";
    s_iRA0    <= "00000";
    s_iRA1    <= "00110";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "01000";
    s_iIMM    <= "0000000000001000";
    s_iRA0    <= "00000";
    s_iRA1    <= "00111";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "01001";
    s_iIMM    <= "0000000000001001";
    s_iRA0    <= "00000";
    s_iRA1    <= "01000";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    s_iWA     <= "01010";
    s_iIMM    <= "0000000000001010";
    s_iRA0    <= "00000";
    s_iRA1    <= "01001";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $11, $1, $2
    s_iWA      <= "01011";
    s_iRA0     <= "00001";
    s_iRA1     <= "00010";
    s_iALUctrl      <= '0';
    s_iALUsrc  <= '0';
    s_iREGWE      <= '1';
    wait for gCLK_HPER*2;

    -- sub $12, $11, $3
    s_iWA     <= "01100";
    s_iRA0    <= "01011";
    s_iRA1    <= "00011";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $13, $12, $4
    s_iWA     <= "01101";
    s_iRA0    <= "01100";
    s_iRA1    <= "00100";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '0';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- sub $14, $13, $5
    s_iWA     <= "01110";
    s_iRA0    <= "01101";
    s_iRA1    <= "00101";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $15, $14, $6
    s_iWA     <= "01111";
    s_iRA0    <= "01110";
    s_iRA1    <= "00110";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '0';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- sub $16, $15, $7
    s_iWA     <= "10000";
    s_iRA0    <= "01111";
    s_iRA1    <= "00111";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $17, $16, $8
    s_iWA     <= "10001";
    s_iRA0    <= "10000";
    s_iRA1    <= "01000";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '0';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- sub $18, $17, $9
    s_iWA     <= "10010";
    s_iRA0    <= "10001";
    s_iRA1    <= "01001";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $19, $18, $10
    s_iWA     <= "10011";
    s_iRA0    <= "10010";
    s_iRA1    <= "01010";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '0';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- addi $20, $0, '-35'
    s_iWA     <= "10100";
    s_iIMM    <= "1111111111011101";
    s_iRA0    <= "00000";
    s_iALUsrc <= '1';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

    -- add $21, $19, $20
    s_iWA     <= "10101";
    s_iRA0    <= "10011";
    s_iRA1    <= "10100";
    s_iALUsrc <= '0';
    s_iALUctrl     <= '0';
    s_iREGWE     <= '1';
    wait for gCLK_HPER*2;

  end process;

end dataflow;