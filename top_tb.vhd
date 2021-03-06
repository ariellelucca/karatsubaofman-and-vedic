library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_tb is
  Generic(
    Size  : natural := 4;
    WSize : natural := 4;
    PSize : natural := 4
  );
end top_tb;

architecture arch_1 of top_tb is
    signal w_X      : STD_LOGIC;
    signal w_Y      : STD_LOGIC;
    signal w_X_V    : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_Y_V    : STD_LOGIC_VECTOR(Size-1 downto 0);
    signal w_CLK    : STD_LOGIC;
    signal w_RSTn   : STD_LOGIC;
    signal w_XY     : STD_LOGIC_VECTOR(2*Size-1 downto 0);
    signal w_I_SHIFT: STD_LOGIC;
    signal w_I_LOAD : STD_LOGIC;
    signal w_RESULT : STD_LOGIC;
begin 

 REGSP_X: entity work.reg_sp
       generic map ( 
         PSize => PSize
       )
       port map(
         i_CLK    => w_CLK,
         i_RSTn   => w_RSTn,
         i_DIN    => w_X,
         i_SHIFT  => w_I_SHIFT, 
         o_DOUT   => w_X_V
       );

    REGSP_Y: entity work.reg_sp
      generic map ( 
        PSize => PSize
      )
      port map(
        i_CLK    => w_CLK,
        i_RSTn   => w_RSTn,
        i_DIN    => w_Y,
        i_SHIFT  => w_I_SHIFT, 
        o_DOUT   => w_Y_V
       );


    KOA: entity work.KaratsubaOfman
      generic map ( 
        Size  => Size,
        WSize => WSize
      )
      port map(
        i_X    => w_X_V,
        i_Y    => w_Y_V,
        i_CLK  => w_CLK,
        i_RSTn => w_RSTn, 
        o_XY   => w_XY
      );

    REGPS_XY: entity work.reg_ps
      generic map ( 
        PSize => PSize
      )
      port map(
        i_CLK    => w_CLK,
        i_RSTn   => w_RSTn,
        i_DIN    => w_XY,
	i_LOAD   => w_I_LOAD,
        i_SHIFT  => w_I_SHIFT, 
        o_DOUT   => w_RESULT
       );
  

  process
  begin
    w_RSTn <= '0';
    wait for 10 ns;
    w_RSTn <= '1';
    wait;
  end process;      

  process
  begin
    w_CLK <= '1';
    wait for 10 ns;
    w_CLK <= '0';
    wait for 10 ns;
  end process;   

  process
  begin
    w_I_SHIFT <= '1';
    wait for 10 ns;
  end process;    

  process
  begin
    w_I_LOAD <= '1';
    wait for 20 ns;
  end process;   


  process 
  -- x => 01010011
  -- y => 11110101
  begin
    w_X <= '0';
    w_Y <= '1';
    wait for 10 ns;

    w_X <= '1';
    w_Y <= '1';
    wait for 10 ns;

    w_X <= '0';
    w_Y <= '1';
    wait for 10 ns;

    w_X <= '1';
    w_Y <= '1';
    wait for 10 ns;

    --w_X <= '0';
    --w_Y <= '0';
    --wait for 10 ns;

    --w_X <= '0';
    --w_Y <= '1';
    --wait for 10 ns;

    --w_X <= '1';
    --w_Y <= '0';
    --wait for 10 ns;

    --w_X <= '1';
    --w_Y <= '1';
    --wait for 10 ns;
  end process;

end arch_1;