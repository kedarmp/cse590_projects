----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/20/2017 10:14:28 AM
-- Design Name: 
-- Module Name: freq_divider_with_ctr - Behavioral
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

entity freq_divider_with_ctr is
    Port ( 
            clk : in STD_LOGIC;
           which : out STD_LOGIC_VECTOR(1 DOWNTO 0)
           );
end freq_divider_with_ctr;

architecture Behavioral of freq_divider_with_ctr is

signal which_val:std_logic_vector(1 downto 0):="00";

begin
process(clk) begin
if rising_edge(clk) then
case which_val is
when "00"=> which<="00";
            which_val<="01";
when "01"=> which<="01";
            which_val<="10";
when "10"=> which<="10";
            which_val<="11";
when "11"=> which<="11";
            which_val<="00";
when others=>null;            
end case;
end if;
end process;


end Behavioral;
