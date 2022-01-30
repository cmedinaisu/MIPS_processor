-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- IF_ID_Reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of the Fetch/Decode pipeline register
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity IF_ID_Reg is
	port(iIFID_clk : in std_logic;
		iIFID_rst : in std_logic := '1';
		iIFID_write_instr : in std_logic_vector(31 downto 0);
		iIFID_write_pc_val : in std_logic_vector(31 downto 0);
		oIFID_read_instr : out std_logic_vector(31 downto 0);
		oIFID_read_pc_val : out std_logic_vector(31 downto 0));
end IF_ID_Reg;

architecture structural of IF_ID_Reg is

component Reg_32 is
	port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic_vector(31 downto 0);
       oQ               : out std_logic_vector(31 downto 0));
end component;
	   
signal write_t : std_logic := '1';

begin

	REG_INSTR: Reg_32 port map(iCLK => iIFID_clk,
       iReset => iIFID_rst,
       iD => iIFID_write_instr,
       oQ => oIFID_read_instr);
	   
	REG_PC4: Reg_32 port map(iCLK => iIFID_clk,
       iReset => iIFID_rst,
       iD => iIFID_write_pc_val,
       oQ => oIFID_read_pc_val);
	
end structural;

