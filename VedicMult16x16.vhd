library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VedicMult16x16 is
  Port ( 
    i_A  : in STD_LOGIC_VECTOR(15 downto 0);
    i_B  : in STD_LOGIC_VECTOR(15 downto 0);
    o_AB : out STD_LOGIC_VECTOR(31 downto 0)
  );
end VedicMult16x16;

architecture Behavioral of VedicMult16x16 is
  type   t_P  is array (31 downto 0) OF std_logic_vector(4 downto 0); -- Custom type vector of vectors
  signal w_R1   : t_P; 						      -- Vector that contains the sum and the carry outs
  signal w_AB1  : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');   -- Vector that contains the result of the multiplication

  begin

    -- Computes i_A(0) * i_B(0)
    w_R1(0)(4 downto 0) <=  "00000" + (
				(i_A(0 downto 0) AND i_B(0 downto 0))
			    );
    w_AB1(0 downto 0)  <= w_R1(0)(0 downto 0);

    -- Computes i_A(0) * i_B(1) + i_A(1) * i_B(0)
    w_R1(1)(4 downto 0) <=  "00000" + (i_A(0 downto 0) AND i_B(1 downto 1)) + 
				"00000" + (i_A(1 downto 1) AND i_B(0 downto 0)) + 
				"00000" + w_R1(0)(4 downto 1);
    w_AB1(1 downto 1)  <= w_R1(1)(0 downto 0);

    -- Computes i_A(0) * i_B(2) + i_A(2) * i_B(0) + i_A(1) * i_B(1)
    w_R1(2)(4 downto 0)   <= "00000" + (i_A(0 downto 0) AND i_B(2 downto 2)) +  
			         "00000" + (i_A(2 downto 2) AND i_B(0 downto 0)) + 
			         "00000" + (i_A(1 downto 1) AND i_B(1 downto 1)) +  
                                 "00000" + w_R1(1)(4 downto 1);
    w_AB1(2 downto 2)  <= w_R1(2)(0 downto 0);


    -- Computes i_A(0) * i_B(3) + i_A(3) * i_B(0) + i_A(1) * i_B(2) + i_A(2) * i_B(1)
    w_R1(3)(4 downto 0)   <= "00000" + (i_A(0 downto 0) AND i_B(3 downto 3)) +
			         "00000" + (i_A(3 downto 3) AND i_B(0 downto 0)) + 
			         "00000" + (i_A(1 downto 1) AND i_B(2 downto 2)) +
			         "00000" + (i_A(2 downto 2) AND i_B(1 downto 1)) + 
                                 "00000" + w_R1(2)(4 downto 1);
    w_AB1(3 downto 3)  <= w_R1(3)(0 downto 0);

    -- Computes i_A(0) * i_B(4) + i_A(4) * i_B(0) + i_A(1) * i_B(3) + i_A(3) * i_B(1) + i_A(2) * i_B(2)
    w_R1(4)(4 downto 0) <=  "00000" + (i_A(0 downto 0) AND i_B(4 downto 4)) +
			    	"00000" + (i_A(4 downto 4) AND i_B(0 downto 0)) +
			    	"00000" + (i_A(1 downto 1) AND i_B(3 downto 3)) +
			    	"00000" + (i_A(3 downto 3) AND i_B(1 downto 1)) +
			    	"00000" + (i_A(2 downto 2) AND i_B(2 downto 2)) +
                             	"00000" + w_R1(3)(4 downto 1);
    w_AB1(4 downto 4)  <= w_R1(4)(0 downto 0);


    -- Computes i_A(0) * i_B(5) + i_A(5) * i_B(0) + i_A(1) * i_B(4) + i_A(4) * i_B(1) + i_A(2) * i_B(3) 
    -- + i_A(3) * i_B(2)
    w_R1(5)(4 downto 0) <=  "00000" + (i_A(0 downto 0) AND i_B(5 downto 5)) +
			    	"00000" + (i_A(5 downto 5) AND i_B(0 downto 0)) +
			    	"00000" + (i_A(1 downto 1) AND i_B(4 downto 4)) +
			    	"00000" + (i_A(4 downto 4) AND i_B(1 downto 1)) +
			    	"00000" + (i_A(2 downto 2) AND i_B(3 downto 3)) +
				"00000" + (i_A(3 downto 3) AND i_B(2 downto 2)) +
				"00000" + w_R1(4)(4 downto 1);
    w_AB1(5 downto 5)    <= w_R1(5)(0 downto 0);

    -- Computes i_A(0) * i_B(6) + i_A(6) * i_B(0) + i_A(1) * i_B(5) + i_A(5) * i_B(1) + i_A(2) * i_B(4) 
    -- + i_A(4) * i_B(2) + i_A(3) * i_B(3)
    w_R1(6)(4 downto 0)  <= "00000" + (i_A(0 downto 0) AND i_B(6 downto 6)) +
			    	"00000" + (i_A(6 downto 6) AND i_B(0 downto 0)) +
			    	"00000" + (i_A(1 downto 1) AND i_B(5 downto 5)) +
			    	"00000" + (i_A(5 downto 5) AND i_B(1 downto 1)) +
 			    	"00000" + (i_A(2 downto 2) AND i_B(4 downto 4)) +
			    	"00000" + (i_A(4 downto 4) AND i_B(2 downto 2)) +
			    	"00000" + (i_A(3 downto 3) AND i_B(3 downto 3)) +
                             	"00000" + w_R1(5)(4 downto 1);
    w_AB1(6 downto 6)    <= w_R1(6)(0 downto 0);

    -- Computes i_A(0) * i_B(7) + i_A(7) * i_B(0) + i_A(1) * i_B(6) + i_A(6) * i_B(1) + i_A(2) * i_B(5) 
    -- + i_A(5) * i_B(2) + i_A(4) * i_B(3) + i_A(3) * i_B(4)
    w_R1(7)(4 downto 0)  <= "00000" + (i_A(0 downto 0) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(6 downto 6)) +
				"00000" + (i_A(6 downto 6) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(5 downto 5)) +
				"00000" + (i_A(5 downto 5) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(4 downto 4)) +
				"00000" + (i_A(4 downto 4) AND i_B(3 downto 3)) +
				"00000" + w_R1(6)(4 downto 1);
    w_AB1(7 downto 7)    <= w_R1(7)(0 downto 0);

    -- Computes i_A(0) * i_B(8) + i_A(8) * i_B(0) + i_A(1) * i_B(7) + i_A(7) * i_B(1) + i_A(2) * i_B(6) 
    -- + i_A(6) * i_B(2) + i_A(4) * i_B(5) + i_A(5) * i_B(4) + i_A(3) * i_B(3)
    w_R1(8)(4 downto 0)  <= "00000" + (i_A(0 downto 0) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(6 downto 6)) +
				"00000" + (i_A(6 downto 6) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(5 downto 5)) +
				"00000" + (i_A(5 downto 5) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(4 downto 4)) +
				"00000" + w_R1(7)(4 downto 1);
    w_AB1(8 downto 8)    <= w_R1(8)(0 downto 0);

    -- Computes i_A(0) * i_B(9) + i_A(9) * i_B(0) + i_A(1) * i_B(8) + i_A(8) * i_B(1) + i_A(2) * i_B(7) 
    -- + i_A(7) * i_B(2) + i_A(3) * i_B(6) + i_A(6) * i_B(3) + i_A(4) * i_B(5) + i_A(5) * i_B(4)
    w_R1(9)(4 downto 0)  <= "00000" + (i_A(0 downto 0) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(0 downto 0)) + 
				"00000" + (i_A(1 downto 1) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(6 downto 6)) +
				"00000" + (i_A(6 downto 6) AND i_B(3 downto 3)) +
				"00000" + (i_A(5 downto 5) AND i_B(4 downto 4)) +
				"00000" + (i_A(4 downto 4) AND i_B(5 downto 5)) +
				"00000" + w_R1(8)(4 downto 1);
    w_AB1(9 downto 9)    <= w_R1(9)(0 downto 0);

    -- Computes i_A(0) * i_B(10) + i_A(10) * i_B(0) + i_A(1) * i_B(9) + i_A(9) * i_B(1) + i_A(2) * i_B(8) 
    -- + i_A(8) * i_B(2) + i_A(3) * i_B(7) + i_A(7) * i_B(3) + i_A(4) * i_B(6) + i_A(6) * i_B(4) + i_A(5) * i_B(5)
    w_R1(10)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(6 downto 6)) +
				"00000" + (i_A(6 downto 6) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(5 downto 5)) +
				"00000" + w_R1(9)(4 downto 1);
    w_AB1(10 downto 10)    <= w_R1(10)(0 downto 0);

    -- Computes i_A(0) * i_B(11) + i_A(11) * i_B(0) + i_A(1) * i_B(10) + i_A(10) * i_B(1) + i_A(2) * i_B(9) 
    -- + i_A(9) * i_B(2) + i_A(3) * i_B(8) + i_A(8) * i_B(3) + i_A(4) * i_B(7) + i_A(7) * i_B(4) + i_A(5) * i_B(6)
    -- + i_A(6) * i_B(5)
    w_R1(11)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(2 downto 2)) + 
				"00000" + (i_A(3 downto 3) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(3 downto 3)) + 
				"00000" + (i_A(4 downto 4) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(4 downto 4)) + 
				"00000" + (i_A(5 downto 5) AND i_B(6 downto 6)) +
				"00000" + (i_A(6 downto 6) AND i_B(5 downto 5)) + 
				"00000" + w_R1(10)(4 downto 1);
    w_AB1(11 downto 11)    <= w_R1(11)(0 downto 0);

    -- Computes i_A(0) * i_B(12) + i_A(12) * i_B(0) + i_A(1) * i_B(11) + i_A(11) * i_B(1) + i_A(2) * i_B(10) 
    -- + i_A(10) * i_B(2) + i_A(3) * i_B(9) + i_A(9) * i_B(3) + i_A(4) * i_B(8) + i_A(8) * i_B(4) + i_A(5) * i_B(7)
    -- + i_A(7) * i_B(5) + i_A(6) * i_B(6)
    w_R1(12)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(6 downto 6)) + 
				"00000" + w_R1(11)(4 downto 1);
    w_AB1(12 downto 12)    <= w_R1(12)(0 downto 0);

    -- Computes i_A(0) * i_B(13) + i_A(13) * i_B(0) + i_A(1) * i_B(12) + i_A(12) * i_B(1) + i_A(2) * i_B(11) 
    -- + i_A(11) * i_B(2) + i_A(3) * i_B(10) + i_A(10) * i_B(3) + i_A(4) * i_B(9) + i_A(9) * i_B(4) + i_A(5) * i_B(8)
    -- + i_A(8) * i_B(5) + i_A(6) * i_B(7) + i_A(7) * i_B(6)
    w_R1(13)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(7 downto 7)) +
				"00000" + (i_A(7 downto 7) AND i_B(6 downto 6)) +
				"00000" + w_R1(12)(4 downto 1);
    w_AB1(13 downto 13)    <= w_R1(13)(0 downto 0);

    -- Computes i_A(0) * i_B(14) + i_A(14) * i_B(0) + i_A(1) * i_B(13) + i_A(13) * i_B(1) + i_A(2) * i_B(12) 
    -- + i_A(12) * i_B(2) + i_A(3) * i_B(11) + i_A(11) * i_B(3) + i_A(4) * i_B(10) + i_A(10) * i_B(4) + i_A(5) * i_B(9)
    -- + i_A(9) * i_B(5) + i_A(6) * i_B(8) + i_A(8) * i_B(6) + i_A(7) * i_B(7)
    w_R1(14)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(7 downto 7)) +
				"00000" + w_R1(13)(4 downto 1);
    w_AB1(14 downto 14)    <= w_R1(14)(0 downto 0);

    -- Computes i_A(0) * i_B(15) + i_A(15) * i_B(0) + i_A(1) * i_B(14) + i_A(14) * i_B(1) + i_A(2) * i_B(13) 
    -- + i_A(13) * i_B(2) + i_A(3) * i_B(12) + i_A(12) * i_B(3) + i_A(4) * i_B(11) + i_A(11) * i_B(4) + i_A(5) * i_B(10)
    -- + i_A(10) * i_B(5) + i_A(6) * i_B(9) + i_A(9) * i_B(6) + i_A(7) * i_B(8) + i_A(8) * i_B(7)
    w_R1(15)(4 downto 0) <= "00000" + (i_A(0 downto 0) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(0 downto 0)) +
				"00000" + (i_A(1 downto 1) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(8 downto 8)) +
				"00000" + (i_A(8 downto 8) AND i_B(7 downto 7)) +
				"00000" + w_R1(14)(4 downto 1);
    w_AB1(15 downto 15)    <= w_R1(15)(0 downto 0);

    -- Computes i_A(1) * i_B(15) + i_A(15) * i_B(1) + i_A(2) * i_B(14) + i_A(14) * i_B(2) + i_A(3) * i_B(13) 
    -- + i_A(13) * i_B(3) + i_A(4) * i_B(12) + i_A(12) * i_B(4) + i_A(5) * i_B(11) + i_A(11) * i_B(5) + i_A(6) * i_B(10)
    -- + i_A(10) * i_B(6) + i_A(7) * i_B(9) + i_A(9) * i_B(7) + i_A(8) * i_B(8)
    w_R1(16)(4 downto 0) <= "00000" + (i_A(1 downto 1) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(1 downto 1)) +
				"00000" + (i_A(2 downto 2) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(2 downto 2)) + 
				"00000" + (i_A(3 downto 3) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(3 downto 3)) + 
				"00000" + (i_A(4 downto 4) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(4 downto 4)) + 
				"00000" + (i_A(5 downto 5) AND i_B(11 downto 11)) + 
				"00000" + (i_A(11 downto 11) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(7 downto 7)) +
				"00000" + (i_A(8 downto 8) AND i_B(8 downto 8)) +
				"00000" + w_R1(15)(4 downto 1);
    w_AB1(16 downto 16)    <= w_R1(16)(0 downto 0);

    -- Computes i_A(2) * i_B(15) + i_A(15) * i_B(2) + i_A(3) * i_B(14) + i_A(14) * i_B(3) + i_A(4) * i_B(13) 
    -- + i_A(13) * i_B(4) + i_A(5) * i_B(12) + i_A(12) * i_B(5) + i_A(6) * i_B(11) + i_A(11) * i_B(6) + i_A(7) * i_B(10)
    -- + i_A(10) * i_B(7) + i_A(8) * i_B(9) + i_A(9) * i_B(8)
    w_R1(17)(4 downto 0) <= "00000" + (i_A(2 downto 2) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(2 downto 2)) +
				"00000" + (i_A(3 downto 3) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(10 downto 10)) +
				"00000" + (i_A(10 downto 10) AND i_B(7 downto 7)) +
				"00000" + (i_A(8 downto 8) AND i_B(9 downto 9)) +
				"00000" + (i_A(9 downto 9) AND i_B(8 downto 8)) +
				"00000" + w_R1(16)(4 downto 1);
    w_AB1(17 downto 17)    <= w_R1(17)(0 downto 0);
	
    -- Computes i_A(3) * i_B(15) + i_A(15) * i_B(3) + i_A(4) * i_B(14) + i_A(14) * i_B(4) + i_A(5) * i_B(13) 
    -- + i_A(13) * i_B(5) + i_A(6) * i_B(12) + i_A(12) * i_B(6) + i_A(7) * i_B(11) + i_A(11) * i_B(7) + i_A(8) * i_B(10)
    -- + i_A(10) * i_B(8) + i_A(9) * i_B(9)
    w_R1(18)(4 downto 0) <= "00000" + (i_A(3 downto 3) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(3 downto 3)) +
				"00000" + (i_A(4 downto 4) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(4 downto 4)) +
				"00000" + (i_A(5 downto 5) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(5 downto 5)) + 
				"00000" + (i_A(6 downto 6) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(7 downto 7)) +
				"00000" + (i_A(8 downto 8) AND i_B(10 downto 10)) + 
				"00000" + (i_A(10 downto 10) AND i_B(8 downto 8)) +
				"00000" + (i_A(9 downto 9) AND i_B(9 downto 9)) +
				"00000" + w_R1(17)(4 downto 1);
    w_AB1(18 downto 18)    <= w_R1(18)(0 downto 0);

    -- Computes i_A(4) * i_B(15) + i_A(15) * i_B(4) + i_A(5) * i_B(14) + i_A(14) * i_B(5) + i_A(6) * i_B(13) 
    -- + i_A(13) * i_B(6) + i_A(7) * i_B(12) + i_A(12) * i_B(7) + i_A(8) * i_B(11) + i_A(11) * i_B(8) + i_A(9) * i_B(10)
    -- + i_A(10) * i_B(9)
    w_R1(19)(4 downto 0) <= "00000" + (i_A(4 downto 4) AND i_B(15 downto 15)) + 
				"00000" + (i_A(15 downto 15) AND i_B(4 downto 4)) + 
				"00000" + (i_A(5 downto 5) AND i_B(14 downto 14)) + 
				"00000" + (i_A(14 downto 14) AND i_B(5 downto 5)) +
				"00000" + (i_A(6 downto 6) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(6 downto 6)) + 
				"00000" + (i_A(7 downto 7) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(7 downto 7)) + 
				"00000" + (i_A(8 downto 8) AND i_B(11 downto 11)) + 
				"00000" + (i_A(11 downto 11) AND i_B(8 downto 8)) +
				"00000" + (i_A(9 downto 9) AND i_B(10 downto 10)) + 
				"00000" + (i_A(10 downto 10) AND i_B(9 downto 9)) + 
				"00000" + w_R1(18)(4 downto 1);
    w_AB1(19 downto 19)    <= w_R1(19)(0 downto 0);

    -- Computes i_A(5) * i_B(15) + i_A(15) * i_B(5) + i_A(6) * i_B(14) + i_A(14) * i_B(6) + i_A(7) * i_B(13) 
    -- + i_A(13) * i_B(7) + i_A(8) * i_B(12) + i_A(12) * i_B(8) + i_A(9) * i_B(11) + i_A(11) * i_B(9) + i_A(10) * i_B(10)
    w_R1(20)(4 downto 0) <= "00000" + (i_A(5 downto 5) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(5 downto 5)) + 
				"00000" + (i_A(6 downto 6) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(7 downto 7)) +
				"00000" + (i_A(8 downto 8) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(8 downto 8)) + 
				"00000" + (i_A(9 downto 9) AND i_B(11 downto 11)) +
				"00000" + (i_A(11 downto 11) AND i_B(9 downto 9)) +  
				"00000" + (i_A(10 downto 10) AND i_B(10 downto 10)) + 
				"00000" + w_R1(19)(4 downto 1);
    w_AB1(20 downto 20)    <= w_R1(20)(0 downto 0);

    -- Computes i_A(6) * i_B(15) + i_A(15) * i_B(6) + i_A(7) * i_B(14) + i_A(14) * i_B(7) + i_A(8) * i_B(13) 
    -- + i_A(13) * i_B(8) + i_A(9) * i_B(12) + i_A(12) * i_B(9) + i_A(10) * i_B(11) + i_A(11) * i_B(10)
    w_R1(21)(4 downto 0) <= "00000" + (i_A(6 downto 6) AND i_B(15 downto 15)) + 
				"00000" + (i_A(15 downto 15) AND i_B(6 downto 6)) +
				"00000" + (i_A(7 downto 7) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(7 downto 7)) + 
				"00000" + (i_A(8 downto 8) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(8 downto 8)) +
				"00000" + (i_A(9 downto 9) AND i_B(12 downto 12)) + 
				"00000" + (i_A(12 downto 12) AND i_B(9 downto 9)) + 
				"00000" + (i_A(10 downto 10) AND i_B(11 downto 11)) + 
				"00000" + (i_A(11 downto 11) AND i_B(10 downto 10)) + 
				"00000" + w_R1(20)(4 downto 1);
    w_AB1(21 downto 21)    <= w_R1(21)(0 downto 0);
	
    -- Computes i_A(7) * i_B(15) + i_A(15) * i_B(7) + i_A(8) * i_B(14) + i_A(14) * i_B(8) + i_A(9) * i_B(13) 
    -- + i_A(13) * i_B(9) + i_A(10) * i_B(12) + i_A(12) * i_B(10) + i_A(11) * i_B(11)
    w_R1(22)(4 downto 0) <= "00000" + (i_A(7 downto 7) AND i_B(15 downto 15)) + 
				"00000" + (i_A(15 downto 15) AND i_B(7 downto 7)) +
				"00000" + (i_A(8 downto 8) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(8 downto 8)) +
				"00000" + (i_A(9 downto 9) AND i_B(13 downto 13)) + 
				"00000" + (i_A(13 downto 13) AND i_B(9 downto 9)) +
				"00000" + (i_A(10 downto 10) AND i_B(12 downto 12)) + 
				"00000" + (i_A(12 downto 12) AND i_B(10 downto 10)) +
				"00000" + (i_A(11 downto 11) AND i_B(11 downto 11)) +
				"00000" + w_R1(21)(4 downto 1);
    w_AB1(22 downto 22)    <= w_R1(22)(0 downto 0);

    -- Computes i_A(8) * i_B(15) + i_A(15) * i_B(8) + i_A(9) * i_B(14) + i_A(14) * i_B(9) + i_A(10) * i_B(13) 
    -- + i_A(13) * i_B(10) + i_A(11) * i_B(12) + i_A(12) * i_B(11)
    w_R1(23)(4 downto 0) <= "00000" + (i_A(8 downto 8) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(8 downto 8)) + 
				"00000" + (i_A(9 downto 9) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(9 downto 9)) +
				"00000" + (i_A(10 downto 10) AND i_B(13 downto 13)) +
				"00000" + (i_A(13 downto 13) AND i_B(10 downto 10)) +
				"00000" + (i_A(11 downto 11) AND i_B(12 downto 12)) +
				"00000" + (i_A(12 downto 12) AND i_B(11 downto 11)) +
				"00000" + w_R1(22)(4 downto 1);
    w_AB1(23 downto 23)    <= w_R1(23)(0 downto 0);

    -- Computes i_A(9) * i_B(15) + i_A(15) * i_B(9) + i_A(10) * i_B(14) + i_A(14) * i_B(10) + i_A(11) * i_B(13) 
    -- + i_A(13) * i_B(11) + i_A(12) * i_B(12)
    w_R1(24)(4 downto 0) <= "00000" + (i_A(9 downto 9) AND i_B(15 downto 15)) + 
				"00000" + (i_A(15 downto 15) AND i_B(9 downto 9)) +
				"00000" + (i_A(10 downto 10) AND i_B(14 downto 14)) + 
				"00000" + (i_A(14 downto 14) AND i_B(10 downto 10)) +
				"00000" + (i_A(11 downto 11) AND i_B(13 downto 13)) + 
				"00000" + (i_A(13 downto 13) AND i_B(11 downto 11)) + 
				"00000" + (i_A(12 downto 12) AND i_B(12 downto 12)) + 
				"00000" + w_R1(23)(4 downto 1);
    w_AB1(24 downto 24)    <= w_R1(24)(0 downto 0);

    -- Computes i_A(10) * i_B(15) + i_A(15) * i_B(10) + i_A(11) * i_B(14) + i_A(14) * i_B(11) + i_A(12) * i_B(13) 
    -- + i_A(13) * i_B(12)
    w_R1(25)(4 downto 0) <= "00000" + (i_A(10 downto 10) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(10 downto 10)) + 
				"00000" + (i_A(11 downto 11) AND i_B(14 downto 14)) + 
				"00000" + (i_A(14 downto 14) AND i_B(11 downto 11)) +
				"00000" + (i_A(12 downto 12) AND i_B(13 downto 13)) + 
				"00000" + (i_A(13 downto 13) AND i_B(12 downto 12)) + 
				"00000" + w_R1(24)(4 downto 1);
    w_AB1(25 downto 25)    <= w_R1(25)(0 downto 0);
    	
    -- Computes i_A(11) * i_B(15) + i_A(15) * i_B(11) + i_A(12) * i_B(14) + i_A(14) * i_B(12) + i_A(13) * i_B(13)
    w_R1(26)(4 downto 0) <= "00000" + (i_A(11 downto 11) AND i_B(15 downto 15)) + 
				"00000" + (i_A(15 downto 15) AND i_B(11 downto 11)) + 
				"00000" + (i_A(12 downto 12) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(12 downto 12)) +
				"00000" + (i_A(13 downto 13) AND i_B(13 downto 13)) +
				"00000" + w_R1(25)(4 downto 1);
    w_AB1(26 downto 26)    <= w_R1(26)(0 downto 0);

    -- Computes i_A(12) * i_B(15) + i_A(15) * i_B(12) + i_A(13) * i_B(14) + i_A(14) * i_B(13)
    w_R1(27)(4 downto 0) <= "00000" + (i_A(12 downto 12) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(12 downto 12)) +
				"00000" + (i_A(13 downto 13) AND i_B(14 downto 14)) +
				"00000" + (i_A(14 downto 14) AND i_B(13 downto 13)) +
				"00000" + w_R1(26)(4 downto 1);
    w_AB1(27 downto 27)    <= w_R1(27)(0 downto 0);

    -- Computes i_A(13) * i_B(15) + i_A(15) * i_B(13) + i_A(14) * i_B(14)
    w_R1(28)(4 downto 0) <= "00000" + (i_A(13 downto 13) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(13 downto 13)) +
				"00000" + (i_A(14 downto 14) AND i_B(14 downto 14)) +
				"00000" + w_R1(27)(4 downto 1);
    w_AB1(28 downto 28)    <= w_R1(28)(0 downto 0);

    -- Computes i_A(14) * i_B(15) + i_A(15) * i_B(14)
    w_R1(29)(4 downto 0) <= "00000" + (i_A(14 downto 14) AND i_B(15 downto 15)) +
				"00000" + (i_A(15 downto 15) AND i_B(14 downto 14)) +
				"00000" + w_R1(28)(4 downto 1);
    w_AB1(29 downto 29)    <= w_R1(29)(0 downto 0);

    -- Computes i_A(15) * i_B(15)
    w_R1(30)(4 downto 0)  <= "00000" + (i_A(15 downto 15) AND i_B(15 downto 15)) +
			     	  "00000" + w_R1(29)(4 downto 1);

    w_AB1(31 downto 30)  <= w_R1(30)(1 downto 0);
   
    -- FINAL
    o_AB <= w_AB1;

end Behavioral;