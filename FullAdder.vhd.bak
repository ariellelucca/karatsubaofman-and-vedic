library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity FullAdder is
  Port ( 
   i_CLK   : in std_logic;
   i_RSTn  : in std_logic;
   i_A    : in  STD_LOGIC_VECTOR(0 downto 0);
   i_B    : in  STD_LOGIC_VECTOR(0 downto 0);
   i_CIN  : in  STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
   o_RES  : out STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
   o_COUT : out STD_LOGIC_VECTOR(0 downto 0) := (others => '0')
  );
end FullAdder;
 
architecture Behavioral of FullAdder is
  SIGNAL r_COUT : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
  SIGNAL w_COUT : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
  SIGNAL w_RES  : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');
  SIGNAL r_RES  : STD_LOGIC_VECTOR(0 downto 0) := (others => '0');

   begin

    process(i_CLK, i_RSTn)
      begin
        if (i_RSTn = '0') then 
          r_COUT <= "0";
        elsif (rising_edge(i_CLK)) then
          r_COUT <= ((i_A AND i_B) OR (i_CIN AND i_A) OR (i_CIN AND i_B));
          r_RES  <= i_A XOR i_B XOR i_CIN ;
        end if;
     o_RES  <= r_RES;
     o_COUT <= r_COUT;
      end process;


end Behavioral;
