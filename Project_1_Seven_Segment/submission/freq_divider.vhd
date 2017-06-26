----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2017 04:12:05 PM
-- Design Name: 
-- Module Name: freq_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity freq_divider is
    Port ( 
    input_clk: in STD_LOGIC;
    clk : out STD_LOGIC);
end freq_divider;

architecture Behavioral of freq_divider is
signal q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22 : STD_LOGIC;
signal clock : std_logic := '1';
signal d1,rst1 : STD_LOGIC;


begin
clock <= not clock after 20ns;  --unused temporarily while on board

someRandom:entity work.d_flip_flop port map(rst=>rst1, clk=>input_clk, q=>q1, d=>d1);
someRandom2:entity work.d_flip_flop port map(rst=>rst1, clk=>q1, q=>q2, d=>d1);
someRandom3:entity work.d_flip_flop port map(rst=>rst1, clk=>q2, q=>q3, d=>d1);
someRandom4:entity work.d_flip_flop port map(rst=>rst1, clk=>q3, q=>q4, d=>d1);
someRandom5:entity work.d_flip_flop port map(rst=>rst1, clk=>q4, q=>q5, d=>d1);
someRandom6:entity work.d_flip_flop port map(rst=>rst1, clk=>q5, q=>q6, d=>d1);
someRandom7:entity work.d_flip_flop port map(rst=>rst1, clk=>q6, q=>q7, d=>d1);
someRandom8:entity work.d_flip_flop port map(rst=>rst1, clk=>q7, q=>q8, d=>d1);
someRandom9:entity work.d_flip_flop port map(rst=>rst1, clk=>q8, q=>q9, d=>d1);
someRandom10:entity work.d_flip_flop port map(rst=>rst1, clk=>q9, q=>q10, d=>d1);
someRandom11:entity work.d_flip_flop port map(rst=>rst1, clk=>q10, q=>q11, d=>d1);
someRandom12:entity work.d_flip_flop port map(rst=>rst1, clk=>q11, q=>q12, d=>d1);
someRandom13:entity work.d_flip_flop port map(rst=>rst1, clk=>q12, q=>q13, d=>d1);
someRandom14:entity work.d_flip_flop port map(rst=>rst1, clk=>q13, q=>q14, d=>d1);
someRandom15:entity work.d_flip_flop port map(rst=>rst1, clk=>q14, q=>q15, d=>d1);
someRandom16:entity work.d_flip_flop port map(rst=>rst1, clk=>q15, q=>q16, d=>d1);
someRandom17:entity work.d_flip_flop port map(rst=>rst1, clk=>q16, q=>q17, d=>d1);
someRandom18:entity work.d_flip_flop port map(rst=>rst1, clk=>q17, q=>clk, d=>d1);
--someRandom19:entity work.d_flip_flop port map(rst=>rst1, clk=>q18, q=>q19, d=>d1);
--someRandom20:entity work.d_flip_flop port map(rst=>rst1, clk=>q19, q=>clk, d=>d1);
--someRandom21:entity work.d_flip_flop port map(rst=>rst1, clk=>q20, q=>q21, d=>d1);
--someRandom22:entity work.d_flip_flop port map(rst=>rst1, clk=>q21, q=>clk, d=>d1);

process begin
rst1<='0';
d1<='1';
wait;
end process;

end Behavioral;
