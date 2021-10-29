library ieee;
use ieee.std_logic_1164.all;

entity reg_ps is  
  generic ( 
    PSize  : in natural := 64
  );
  port(
    i_CLK   : in  std_logic;
    i_RSTn  : in  std_logic;
    i_DIN   : in  std_logic_vector(2*PSize-1 downto 0);
    i_LOAD  : in  std_logic; 
    i_SHIFT : in  std_logic; 
    o_DOUT  : out std_logic);
end entity reg_ps;

architecture arch_1 of reg_ps is  
  signal r_DATA : std_logic_vector(2*PSize-1 downto 0);
begin  
  process(i_CLK,i_RSTn)  
  begin  
    if (i_RSTn = '0') then  
      r_DATA <= (others => '0'); 
    elsif rising_edge(i_CLK) then
      if (i_LOAD='1') then
        r_DATA <= i_DIN;
      elsif (i_SHIFT='1') then
        r_DATA <= '0' & r_DATA(2*PSize-1 downto 1);
      end if;
    end if;
  end process;  
	
	o_DOUT <= r_DATA(0);
end arch_1;