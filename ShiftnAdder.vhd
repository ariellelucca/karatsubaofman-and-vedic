library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- The component ShiftnAdd first computes the sum S as SXL + SYL, SXL, SYL, or 0 
-- depending on the values of CX and CY, then computes P3 wherein T represents CX.CY.
-- The computation implemented by component ShiftSubnAdd can be performed efficiently 
-- if the execution order of the operations constituting it is chosen carefully.

entity ShiftnAdder is
  Generic (
    p_K : in natural := 4
  );
  Port (   
    i_CLK     : in std_logic; 			   -- Clock
    i_RSTn    : in std_logic; 			   -- Reset
    i_SXL     : in STD_LOGIC_VECTOR(p_K-1 downto 0);   -- Sum of XH + XL
    i_SYL     : in STD_LOGIC_VECTOR(p_K-1 downto 0);   -- Sum of YH + YL
    i_CX      : in STD_LOGIC; 			   -- Carry X that comes from the first adder on the recursion  ADDl
    i_CY      : in STD_LOGIC;			   -- Carry Y that comes from the second adder on the recursion ADD2
    i_P       : in STD_LOGIC_VECTOR(2*p_K-1 downto 0); -- o_XY that comes from the result of KOA3
    o_PRODUCT3: out STD_LOGIC_VECTOR(2*p_K+1 downto 0) 
  );
end ShiftnAdder;

architecture Behavioral of ShiftnAdder is
-- Registers
  signal r_D1, r_D2  : STD_LOGIC_VECTOR(p_K-1 downto 0);
  signal r_D3, r_D4  : STD_LOGIC;
  signal r_D5        : STD_LOGIC_VECTOR(2*p_K-1 downto 0);
  signal r_OUT       : STD_LOGIC_VECTOR(2*p_K+1 downto 0);

  signal w_S         : STD_LOGIC_VECTOR(p_K downto 0);
  signal w_S1        : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
  signal w_CONCATS   : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
  signal w_T         : STD_LOGIC;
  signal w_TP        : STD_LOGIC_VECTOR(2*p_K+1 downto 0) := (others => '0');
  signal w_DES       : STD_LOGIC_VECTOR(p_K-1 downto 0):= (others => '0');
  signal w_ADD1_X    : STD_LOGIC_VECTOR(p_K-1 downto 0); 
  signal w_CX        : STD_LOGIC;

  BEGIN 


  -- Adds the sum of XH+XL and YH+YL together with a 0 carry
  ADDl: entity work.Adder
    generic map ( 
      p_K => p_K
    )
    port map(
      i_X1    => i_SXL,
      i_X2    => i_SYL,
      i_CARRY => '0',
      o_XX    => w_ADD1_X, 
      o_CARRY => w_CX
    );


  -- Computes the sum S as SXl+ SYl,SXl,SYl
  w_S <= (w_CX & w_ADD1_X) when (i_CX = '1' AND i_CY = '1') else 
         '0'&i_SXL when (i_CX = '0' AND i_CY = '1') else
         '0'&i_SYL when (i_CX = '1' AND i_CY= '0') else
         (others => '0');
   
  
  
    process(i_CLK, i_RSTn)
    begin
      if (i_RSTn = '0') then 
        r_D1 <= (others => '0');
        r_D2 <= (others => '0');
        r_D3 <= '0';
        r_D4 <= '0';
        r_D5 <= (others => '0'); 
      elsif (rising_edge(i_CLK)) then
		  -- T represents CarryX(CX). CarryY(CY)
  w_T <= i_CX AND i_CY;

  -- w_S1 represents w_S with concat (2*p_K+1 downto 0, all zeros)
  w_S1 <= w_CONCATS + (w_S & w_DES);

  -- TP represents w_T (CarryX(CX). CarryY(CY)) concatenated with 
  -- i_P (the result of KOA3) with concat (2*p_K+1 downto 0, all zeros)
  w_TP <= w_CONCATS + (w_T & i_P);
  
  -- PRODUCT3 represents the sum of w_TP with w_S1
  r_OUT <= w_TP + w_S1;
      end if;
  end process;
  
  o_PRODUCT3 <= r_OUT;

end Behavioral;
