----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/15/2017 07:29:12 PM
-- Design Name: 
-- Module Name: d_flip_flop_tb - Behavioral
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

entity d_flip_flop_tb is
--  Port ( );
end d_flip_flop_tb;

architecture Behavioral of d_flip_flop_tb is
signal d1,rst1 : STD_LOGIC;
--signal     clk :STD_LOGIC;
signal q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20 : STD_LOGIC;

signal clock : std_logic := '1';
begin
clock <= not clock after 20ns;
someRandom:entity work.d_flip_flop port map(rst=>rst1, clk=>clock, q=>q1, d=>d1);
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
someRandom18:entity work.d_flip_flop port map(rst=>rst1, clk=>q17, q=>q18, d=>d1);
someRandom19:entity work.d_flip_flop port map(rst=>rst1, clk=>q18, q=>q19, d=>d1);
someRandom20:entity work.d_flip_flop port map(rst=>rst1, clk=>q19, q=>q20, d=>d1);


process begin
rst1<='0';
d1<='1';


-- keep reducing frequency. At the last step, the output q of the last d ff is 
--important. That should be the final output of a new entity called
--'frequency divider'. Then in the final stage, use a process block with 
--the final output as its sensitivity element. Whenever that clock signal 
--is driven high/low is out stimulus for strobing something on/off 
wait;
--wait for 100ns;
end process;

end Behavioral;
