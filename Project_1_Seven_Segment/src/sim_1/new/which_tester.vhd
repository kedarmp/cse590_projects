----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/20/2017 11:08:14 AM
-- Design Name: 
-- Module Name: which_tester - Behavioral
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

entity which_tester is
--  Port ( );
end which_tester;

architecture Behavioral of which_tester is

signal reducedClock: std_logic;--:='1';
signal which_out:std_logic_vector(1 downto 0);

signal simulated_clk: std_logic:='1';

begin
simulated_clk <= not simulated_clk after 20ns;

newfreqDivider: entity work.freq_divider port map(input_clk=>simulated_clk,clk=>reducedClock);
finaldivider: entity work.freq_divider_with_ctr port map(clk=>reducedClock, which=>which_out);

end Behavioral;
