-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- norg2.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 2-input NOR gate


library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_norg2 is

  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);

end ALU_norg2;

architecture dataflow of ALU_norg2 is
begin

  o_F <= i_A nor i_B;
  
end dataflow;
