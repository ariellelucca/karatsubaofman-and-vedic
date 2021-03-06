library ieee;
use ieee.std_logic_1164.all;

entity reg_sp is  
  generic ( 
    pSize  : in natural := 64
  );
  port(
    i_CLK   : in  std_logic;
    i_RSTn  : in  std_logic;
    i_DIN   : in  std_logic; 
    i_SHIFT : in  std_logic; 
    o_DOUT  : out std_logic_vector(PSize-1 downto 0));
end entity reg_sp;

architecture arch_1 of reg_sp is  
  signal r_DATA : std_logic_vector(PSize-1 downto 0);
begin  
  process(i_CLK,i_RSTn)  
  begin  
    if (i_RSTn = '0') then  
      r_DATA <= (others => '0'); 
    elsif rising_edge(i_CLK) then
      if (i_SHIFT='1') then
        r_DATA <= i_DIN & r_DATA(PSize-1 downto 1);
      end if;
    end if;
  end process;  
	
  o_DOUT <= r_DATA;
end arch_1;