-------------------------------------------------------------------------
-- Patrick Bruce
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- regfile.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a register file
--
--
-- NOTES:
-- 3/24/21 by H3::Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;


entity regfile is

  port(iCLk                 : in std_logic;
	   iRST					: in std_logic;
       iRA0 		        : in std_logic_vector(4 downto 0);
       iRA1 		        : in std_logic_vector(4 downto 0);
       iWA 		            : in std_logic_vector(4 downto 0);
       iWD                  : in std_logic_vector(31 downto 0);
       iWE                  : in std_logic;
       oR0 		            : out std_logic_vector(31 downto 0);
       oR1 		            : out std_logic_vector(31 downto 0));

end regfile;

architecture structure of regfile is
  
  -- Describe the component entities as defined in Adder.vhd, Reg.vhd,
  -- Multiplier.vhd, RegLd.vhd (not strictly necessary).

  component decoder5t32 is
  port(D_IN	: in	std_logic_vector(4 downto 0);
       F_OUT	: out	std_logic_vector(31 downto 0));
  end component;

  component andg2 is
  port(i_A      : in std_logic;
       i_B      : in std_logic;
       o_F      : out std_logic);
  end component;

  component register_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(	i_CLK		: in std_logic;     -- Clock input
	i_RST		: in std_logic;
  	i_WE         	: in std_logic;     -- Write enable input
       	i_D 		: in std_logic_vector(N-1 downto 0);
       	o_Q  		: out std_logic_vector(N-1 downto 0));
  end component;

  component mux32t1_32 is
  port (	
    i_D0   : in	std_logic_vector(31 downto 0);
    i_D1   : in	std_logic_vector(31 downto 0);
    i_D2   : in	std_logic_vector(31 downto 0);
    i_D3   : in	std_logic_vector(31 downto 0);
    i_D4   : in	std_logic_vector(31 downto 0);
    i_D5   : in	std_logic_vector(31 downto 0);
    i_D6   : in	std_logic_vector(31 downto 0);
    i_D7   : in	std_logic_vector(31 downto 0);
    i_D8   : in	std_logic_vector(31 downto 0);
    i_D9   : in	std_logic_vector(31 downto 0);
    i_D10  : in	std_logic_vector(31 downto 0);
    i_D11  : in	std_logic_vector(31 downto 0);
    i_D12  : in	std_logic_vector(31 downto 0);
    i_D13  : in	std_logic_vector(31 downto 0);
    i_D14  : in	std_logic_vector(31 downto 0);
    i_D15  : in	std_logic_vector(31 downto 0);
    i_D16  : in	std_logic_vector(31 downto 0);
    i_D17  : in	std_logic_vector(31 downto 0);
    i_D18  : in	std_logic_vector(31 downto 0);
    i_D19  : in	std_logic_vector(31 downto 0);
    i_D20  : in	std_logic_vector(31 downto 0);
    i_D21  : in	std_logic_vector(31 downto 0);
    i_D22  : in	std_logic_vector(31 downto 0);
    i_D23  : in	std_logic_vector(31 downto 0);
    i_D24  : in	std_logic_vector(31 downto 0);
    i_D25  : in	std_logic_vector(31 downto 0);
    i_D26  : in	std_logic_vector(31 downto 0);
    i_D27  : in	std_logic_vector(31 downto 0);
    i_D28  : in	std_logic_vector(31 downto 0);
    i_D29  : in	std_logic_vector(31 downto 0);
    i_D30  : in	std_logic_vector(31 downto 0);
    i_D31  : in	std_logic_vector(31 downto 0);
    i_S	: in	std_logic_vector(4 downto 0);
    o_O	: out	std_logic_vector(31 downto 0));
  end component;

  -- Signals to carry Data
  signal s_iWD, s_oR1, s_oR2   : std_logic_vector(31 downto 0);

  -- Internal Data signals
  signal s_FOUT, s_WE : std_logic_vector(31 downto 0);

  type busbus is array (31 downto 0) of std_logic_vector (31 downto 0);
  signal s_Q : busbus;

begin

  ---------------------------------------------------------------------------
  -- Level 0: Decoder, And Gate, and Registers
  ---------------------------------------------------------------------------
 
  g_Decode: decoder5t32
    port MAP(D_IN             => iWA,
             F_OUT            => s_FOUT);


  -- Instantiate N AND instances.
  G_NBit_AND: for i in 0 to 31 generate
    ANDI: andg2 
      port map (
              i_A      => iWE,      -- All instances share the same select input.
              i_B      => s_FOUT(i),  -- ith instance's data 0 input hooked up to ith data 0 input.
              o_F      => s_WE(i));  -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_AND;

  -- Instantiate N AND instances.
  G_NReg: for i in 1 to 31 generate
    REGI: register_N 
      generic map (N => 32)
      port map (	
	i_CLK	=>	iCLK,
	i_RST	=>	iRST,
	i_D	=>	iWD,
	i_WE	=>	s_WE(i),
	o_Q	=>	s_Q(i));
  end generate G_NReg;
  
  REG0: register_N
	generic map (N => 32)
	port map (
	i_CLK	=>	iCLK,
	i_RST	=>	'1',
	i_D	=>	iWD,
	i_WE	=>	s_WE(0),
	o_Q	=>	s_Q(0));

  ---------------------------------------------------------------------------
  -- Level 1: Mux
  ---------------------------------------------------------------------------
  
  MUX0: mux32t1_32
  port map (	
    i_D0   => s_Q(0),
    i_D1   => s_Q(1),
    i_D2   => s_Q(2),
    i_D3   => s_Q(3),
    i_D4   => s_Q(4),
    i_D5   => s_Q(5),
    i_D6   => s_Q(6),
    i_D7   => s_Q(7),
    i_D8   => s_Q(8),
    i_D9   => s_Q(9),
    i_D10  => s_Q(10),
    i_D11  => s_Q(11),
    i_D12  => s_Q(12),
    i_D13  => s_Q(13),
    i_D14  => s_Q(14),
    i_D15  => s_Q(15),
    i_D16  => s_Q(16),
    i_D17  => s_Q(17),
    i_D18  => s_Q(18),
    i_D19  => s_Q(19),
    i_D20  => s_Q(20),
    i_D21  => s_Q(21),
    i_D22  => s_Q(22),
    i_D23  => s_Q(23),
    i_D24  => s_Q(24),
    i_D25  => s_Q(25),
    i_D26  => s_Q(26),
    i_D27  => s_Q(27),
    i_D28  => s_Q(28),
    i_D29  => s_Q(29),
    i_D30  => s_Q(30),
    i_D31  => s_Q(31),
    i_S	   => iRA0,
    o_O	   => oR0);

  MUX1: mux32t1_32
  port map (	
    i_D0   => s_Q(0),
    i_D1   => s_Q(1),
    i_D2   => s_Q(2),
    i_D3   => s_Q(3),
    i_D4   => s_Q(4),
    i_D5   => s_Q(5),
    i_D6   => s_Q(6),
    i_D7   => s_Q(7),
    i_D8   => s_Q(8),
    i_D9   => s_Q(9),
    i_D10  => s_Q(10),
    i_D11  => s_Q(11),
    i_D12  => s_Q(12),
    i_D13  => s_Q(13),
    i_D14  => s_Q(14),
    i_D15  => s_Q(15),
    i_D16  => s_Q(16),
    i_D17  => s_Q(17),
    i_D18  => s_Q(18),
    i_D19  => s_Q(19),
    i_D20  => s_Q(20),
    i_D21  => s_Q(21),
    i_D22  => s_Q(22),
    i_D23  => s_Q(23),
    i_D24  => s_Q(24),
    i_D25  => s_Q(25),
    i_D26  => s_Q(26),
    i_D27  => s_Q(27),
    i_D28  => s_Q(28),
    i_D29  => s_Q(29),
    i_D30  => s_Q(30),
    i_D31  => s_Q(31),
    i_S	   => iRA1,
    o_O	   => oR1);
    

  end structure;