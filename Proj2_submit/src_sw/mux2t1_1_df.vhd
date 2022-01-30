-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- mux2t1_1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an 1-bit wide 2:1
-- mux using dataflow VHDL.
--
--
-- NOTES:
-- 3/9/21 by Patrick Bruce
-------------------------------------------------------------------------

-- Library Declarations
library IEEE;
use IEEE.std_logic_1164.all;

-- Entity 
entity mux2t1_1_df is
 port (	i_D0	: in	std_logic;
	i_D1	: in	std_logic;
	i_S	: in	std_logic;
	o_O	: out	std_logic);
end mux2t1_1_df;

-- Architecture
architecture dataflow of mux2t1_1_df is
begin
 o_O <=	i_D0 when (i_S = '0') else
	i_D1 when (i_S = '1');

end dataflow;