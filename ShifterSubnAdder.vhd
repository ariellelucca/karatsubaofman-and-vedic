library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- The component ShiftSubnAdder first computes concatenates i_PRODUCT1 and i_PRODUCT2
-- then subtracts i_PRODUCT3 - i_PRODUCT2 - i_PRODUCT1 and shift left the result of the subtraction
-- the final result is the sum of the subtraction plus the previous concatenation

entity ShifterSubnAdder is
  Generic (
    p_K : in natural := 4
   );
  Port ( 
    i_CLK           : in std_logic;
    i_RSTn          : in std_logic;
    i_PRODUCT1      : in  std_logic_vector(2*p_K-1 downto 0);
    i_PRODUCT2      : in  std_logic_vector(2*p_K-1 downto 0);
    i_PRODUCT3      : in  std_logic_vector(2*p_K+1 downto 0);
    o_XY            : out std_logic_vector(4*p_K-1 downto 0)
  );
end ShifterSubnAdder;

architecture Behavioral of ShifterSubnAdder is
  signal w_E        : std_logic_vector (4*p_K-1 downto 0);
  signal w_U        : std_logic_vector (2*p_K+1 downto 0) := (others => '0');
  signal w_USHIFT   : std_logic_vector (3*p_K+1 downto 0) := (others => '0');
  signal w_1SHIFT   : std_logic_vector (4*p_K-1 downto 0) := (others => '0'); 
    
 BEGIN 
 process(i_CLK, i_RSTn)
  begin
    if (i_RSTn = '0') then 
      w_E <= (others => '0');
		elsif (rising_edge(i_CLK)) then
  -- Concatenates i_PRODUCT1 and i_PRODUCT2 instead of shifting i_PRODUCT1 and adding i_PRODUCT2, 
  -- since it will produce the same reuslt
  w_1SHIFT <= i_PRODUCT1 & i_PRODUCT2; 
 
  -- P3 - P2 - P1
  w_U <= i_PRODUCT3 - i_PRODUCT2 - i_PRODUCT1;
 
  -- Shift W_U
  w_USHIFT(3*p_K+1 downto p_K) <= w_U;
  w_E <= w_1SHIFT+w_USHIFT;
    end if;
  end process;
  o_XY <= w_E;
    
end Behavioral;