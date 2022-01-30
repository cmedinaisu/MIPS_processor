-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- Reg.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a behavioral 
-- register that delays the input by one clock cycle. 
--
--
-- NOTES: Integer data type is not typically useful when doing hardware
-- design. We use it here for simplicity, but in future labs it will be
-- important to switch to std_logic_vector types and associated math
-- libraries (e.g. signed, unsigned). 


-- 1/14/18 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity Reg_1 is
  port(iCLK             : in std_logic;
       iReset			: in std_logic;
       iD               : in std_logic;
       oQ               : out std_logic);

end Reg_1;

architecture behavior of Reg_1 is

begin

  process(iCLK, iD, iReset)
  begin
	if iReset = '1' then
		oQ <= '0';
    elsif rising_edge(iCLK) then
		oQ <= iD;
    end if;
		
  end process;
  
end behavior;
