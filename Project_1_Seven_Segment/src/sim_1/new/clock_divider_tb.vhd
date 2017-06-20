----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2017 08:36:02 PM
-- Design Name: 
-- Module Name: clock_divider_tb - Behavioral
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

entity clock_divider_tb is
--  Port ( );
end clock_divider_tb;

architecture Behavioral of clock_divider_tb is

signal reducedClock: std_logic:='1';
signal state: std_logic:='0';
signal led0: std_logic;
signal simulated_clk: std_logic;
begin
--freqDivider: entity work.freq_divider port map(clk=>final_clk);
newfreqDivider: entity work.freq_divider port map(input_clk=>simulated_clk,clk=>reducedClock);
simulated_clk <= not simulated_clk after 20ns;
process(reducedClock) begin
if rising_edge(reducedClock) then
led0 <= state;
stat<= not state;
end if;
end process;

end Behavioral;
