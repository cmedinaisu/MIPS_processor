-------------------------------------------------------------------------
-- Cristofer Medina Lopez
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- onesComp_N.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit one's complement calculator

-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU_onesComp_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_C          : in std_logic_vector(N-1 downto 0);
       o_C          : out std_logic_vector(N-1 downto 0));

end ALU_onesComp_N;

architecture structural of ALU_onesComp_N is

  component invg is
    port(i_A          : in std_logic;
		o_F          : out std_logic);
		
  end component;

begin

  -- Instantiate N one's complement instances.
  G_NBit_OC: for i in 0 to N-1 generate
    OCI: invg port map(
              i_A     => i_C(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              o_F      => o_C(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_OC;
  
end structural;
