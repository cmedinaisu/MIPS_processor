-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- tb_IFID.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file is the testbench for the IF_ID_Registers.vhd file.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_IFID is
  generic(gCLK_HPER   : time := 50 ns);
end tb_IFID;

architecture behavior of tb_IFID is

-- Calculate the clock period as twice the half-period
  constant cCLK_PER  : time := gCLK_HPER * 2;
  
  component IF_ID_Reg
	port(iIFID_clk : in std_logic;
		iIFID_rst : in std_logic := '1';
		iIFID_write_instr : in std_logic_vector(31 downto 0);
		iIFID_write_pc_val : in std_logic_vector(31 downto 0);
		oIFID_read_instr : out std_logic_vector(31 downto 0);
		oIFID_read_pc_val : out std_logic_vector(31 downto 0));
end component;

signal CLK : std_logic := '0';
signal i_RST : std_logic;
signal IFID_write_instr : std_logic_vector(31 downto 0);
signal IFID_write_pc_val : std_logic_vector(31 downto 0);
signal IFID_read_instr : std_logic_vector(31 downto 0);
signal IFID_read_pc_val : std_logic_vector(31 downto 0);



begin

DUT: IF_ID_Reg
	port map(iIFID_clk => CLK,
		iIFID_rst => i_RST,
		iIFID_write_instr => IFID_write_instr,
		iIFID_write_pc_val =>  IFID_write_pc_val,
		oIFID_read_instr => IFID_read_instr,
		oIFID_read_pc_val => IFID_read_pc_val);
		
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
	--i_RST <= '1';
	wait for cCLK_PER / 4; 
  
  
	IFID_write_instr <= x"FF0000AA";
	IFID_write_pc_val <= x"0000FFFF";
	wait for cCLK_PER;
	
	IFID_write_instr <= x"0000FFAA";
	IFID_write_pc_val <= x"0000AAFF";
	wait for cCLK_PER;
	
    wait;
  end process;
end behavior;
	