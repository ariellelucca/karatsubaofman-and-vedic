library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
  Generic(
    Size  : natural := 256;
    WSize : natural := 16;
    PSize: natural := 16
  );
  Port ( 
   -- i_X     : in  STD_LOGIC_VECTOR(Size-1 downto 0);
   -- i_Y     : in  STD_LOGIC_VECTOR(Size-1 downto 0);
    i_X     : in  STD_LOGIC;
    i_Y     : in  STD_LOGIC;
    i_CLK   : in  STD_LOGIC;
    i_RSTn  : in  STD_LOGIC;
    i_SHIFT : in  STD_LOGIC; 
    i_LOAD  : in  std_logic; 
    o_DOUT  : out STD_LOGIC_VECTOR(Size-1 downto 0);
    o_XY    : out STD_LOGIC
   -- o_XY    : out STD_LOGIC_VECTOR(2*Size-1 downto 0)
  );
end top;

architecture Behavioral of top is
  signal w_X : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_Y : STD_LOGIC_VECTOR(Size-1 downto 0);
  signal w_XY: STD_LOGIC_VECTOR((2*Size)-1 downto 0);
  BEGIN 
    REGSP_X: entity work.reg_sp
       generic map ( 
         PSize => Size
       )
       port map(
         i_CLK    => i_CLK,
         i_RSTn   => i_RSTn,
         i_DIN    => i_X,
         i_SHIFT  => i_SHIFT, 
         o_DOUT   => w_X
       );

    REGSP_Y: entity work.reg_sp
      generic map ( 
        PSize => Size
      )
      port map(
        i_CLK    => i_CLK,
        i_RSTn   => i_RSTn,
        i_DIN    => i_Y,
        i_SHIFT  => i_SHIFT, 
        o_DOUT   => w_Y
       );


    KOA: entity work.KaratsubaOfman
      generic map ( 
        Size  => Size,
        WSize => WSize
      )
      port map(
        i_X    => w_X,
        i_Y    => w_Y,
        i_CLK  => i_CLK,
        i_RSTn => i_RSTn, 
        o_XY   => w_XY
      );

    REGPS_XY: entity work.reg_ps
      generic map ( 
        PSize => Size
      )
      port map(
        i_CLK    => i_CLK,
        i_RSTn   => i_RSTn,
        i_DIN    => w_XY,
	i_LOAD   => i_LOAD,
        i_SHIFT  => i_SHIFT, 
        o_DOUT   => o_XY
       );


end Behavioral;