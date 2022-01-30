-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an extender class
--
--
-- NOTES:
-- 3/28/21 by Patrick Bruce
-------------------------------------------------------------------------

-- Library Declarations
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity 
entity extender is
 port (	
	i16	: in	std_logic_vector(15 downto 0);
	iZS	: in	std_logic;
	o32	: out	std_logic_vector(31 downto 0));
end extender;

-- Architecture
architecture dataflow of extender is

signal s_ext	: std_logic;

begin

s_ext <= iZS and i16(15);

o32(2#0000#) <= i16(2#0000#);
o32(2#0001#) <= i16(2#0001#);
o32(2#0010#) <= i16(2#0010#);
o32(2#0011#) <= i16(2#0011#);

o32(2#0100#) <= i16(2#0100#);
o32(2#0101#) <= i16(2#0101#);
o32(2#0110#) <= i16(2#0110#);
o32(2#0111#) <= i16(2#0111#);

o32(2#1000#) <= i16(2#1000#);
o32(2#1001#) <= i16(2#1001#);
o32(2#1010#) <= i16(2#1010#);
o32(2#1011#) <= i16(2#1011#);

o32(2#1100#) <= i16(2#1100#);
o32(2#1101#) <= i16(2#1101#);
o32(2#1110#) <= i16(2#1110#);
o32(2#1111#) <= i16(2#1111#);

o32(2#10000#) <= s_ext;
o32(2#10001#) <= s_ext;
o32(2#10010#) <= s_ext;
o32(2#10011#) <= s_ext;

o32(2#10100#) <= s_ext;
o32(2#10101#) <= s_ext;
o32(2#10110#) <= s_ext;
o32(2#10111#) <= s_ext;

o32(2#11000#) <= s_ext;
o32(2#11001#) <= s_ext;
o32(2#11010#) <= s_ext;
o32(2#11011#) <= s_ext;

o32(2#11100#) <= s_ext;
o32(2#11101#) <= s_ext;
o32(2#11110#) <= s_ext;
o32(2#11111#) <= s_ext;

end dataflow;