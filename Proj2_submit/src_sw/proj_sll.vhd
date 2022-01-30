-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- proj_sll.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an sll
-- using structural VHDL, generics, and generate statements.
--
--
-- NOTES:
-- 3/11/21 Patrick Bruce
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity proj_sll is
  port(	i_shift   	: in std_logic_vector(4 downto 0);
       	i_D   		: in std_logic_vector(31 downto 0);
		o_O    		: out std_logic_vector(31 downto 0));

end proj_sll;

architecture structural of proj_sll is

component mux32t1_1 is
 port (	
    i_D0   	: in	std_logic;
    i_D1   	: in	std_logic;
    i_D2   	: in	std_logic;
    i_D3   	: in	std_logic;
    i_D4   	: in	std_logic;
    i_D5   	: in	std_logic;
    i_D6   	: in	std_logic;
    i_D7   	: in	std_logic;
    i_D8   	: in	std_logic;
    i_D9   	: in	std_logic;
    i_D10  	: in	std_logic;
    i_D11  	: in	std_logic;
    i_D12  	: in	std_logic;
    i_D13  	: in	std_logic;
    i_D14  	: in	std_logic;
    i_D15  	: in	std_logic;
    i_D16  	: in	std_logic;
    i_D17  	: in	std_logic;
    i_D18  	: in	std_logic;
    i_D19  	: in	std_logic;
    i_D20  	: in	std_logic;
    i_D21  	: in	std_logic;
    i_D22  	: in	std_logic;
    i_D23  	: in	std_logic;
    i_D24  	: in	std_logic;
    i_D25  	: in	std_logic;
    i_D26  	: in	std_logic;
    i_D27  	: in	std_logic;
    i_D28  	: in	std_logic;
    i_D29  	: in	std_logic;
    i_D30  	: in	std_logic;
    i_D31  	: in	std_logic;
    i_S		: in	std_logic_vector(4 downto 0);
    o_O		: out	std_logic);
end component;

Signal s_DAppendZeros : std_logic_vector(63 downto 0);

begin

s_DAppendZeros(31 downto 0) <= x"00000000";
s_DAppendZeros(63 downto 32) <= i_D;

  -- Instantiate N ADD instances.
  G_Mux: for i in 32 to 63 generate
  MUXAS: mux32t1_1
  port map(	
    i_D0	=> s_DAppendZeros(i),
    i_D1   	=> s_DAppendZeros(i - 1),
    i_D2   	=> s_DAppendZeros(i - 2),
    i_D3   	=> s_DAppendZeros(i - 3),
    i_D4   	=> s_DAppendZeros(i - 4),
    i_D5   	=> s_DAppendZeros(i - 5),
    i_D6   	=> s_DAppendZeros(i - 6),
    i_D7   	=> s_DAppendZeros(i - 7),
    i_D8   	=> s_DAppendZeros(i - 8),
    i_D9   	=> s_DAppendZeros(i - 9),
    i_D10  	=> s_DAppendZeros(i - 10),
    i_D11  	=> s_DAppendZeros(i - 11),
    i_D12  	=> s_DAppendZeros(i - 12),
    i_D13  	=> s_DAppendZeros(i - 13),
    i_D14  	=> s_DAppendZeros(i - 14),
    i_D15  	=> s_DAppendZeros(i - 15),
    i_D16  	=> s_DAppendZeros(i - 16),
    i_D17  	=> s_DAppendZeros(i - 17),
    i_D18  	=> s_DAppendZeros(i - 18),
    i_D19  	=> s_DAppendZeros(i - 19),
    i_D20  	=> s_DAppendZeros(i - 20),
    i_D21  	=> s_DAppendZeros(i - 21),
    i_D22  	=> s_DAppendZeros(i - 22),
    i_D23  	=> s_DAppendZeros(i - 23),
    i_D24  	=> s_DAppendZeros(i - 24),
    i_D25  	=> s_DAppendZeros(i - 25),
    i_D26  	=> s_DAppendZeros(i - 26),
    i_D27  	=> s_DAppendZeros(i - 27),
    i_D28  	=> s_DAppendZeros(i - 28),
    i_D29  	=> s_DAppendZeros(i - 29),
    i_D30  	=> s_DAppendZeros(i - 30),
    i_D31  	=> s_DAppendZeros(i - 31),
    i_S		=> i_shift,
    o_O		=> o_O(i - 32));

  end generate G_Mux;

  
end structural;