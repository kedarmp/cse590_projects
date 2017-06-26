----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2017 03:13:16 PM
-- Design Name: 
-- Module Name: inverter - Behavioral
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

entity inverter is
    Port ( sw : in std_logic_vector(15 downto 0);
           led : out STD_LOGIC_vector(15 downto 0);
           an: out std_logic_vector(3 downto 0);
           btnC: in std_logic;
           seg: out std_logic_vector(6 downto 0)
           );
end inverter;

architecture Behavioral of inverter is
--signal sw_signal:std_logic_vector(15 downto 0);
signal digit_0: std_logic_vector(3 downto 0);
signal temp:std_logic:='0';
begin
led<=  sw;
--Display 5 on 1st (from left) 7-S D
--an(0)<='1';
--an(1)<='1';
--an(2)<='1';
--an(3)<='0';
--seg(0)<='0';
--seg(5)<='0';
--seg(6)<='0';
--seg(2)<='0';
--seg(3)<='0';

-- OR
an<="0101";

something: process(btnC) begin
--if btnC<='1' then
digit_0 <= sw(3 downto 0);
case digit_0 is
when "0000" => seg<="1000000";
when "0001" => seg<="1111001";
when "0010" => seg<="0100100";
when "0011" => seg<="0110000";
when "0100" => seg<="0011001";
when "0101" => seg<="0010010";
when "0110" => seg<="0000010";
when "0111" => seg<="1111000";
when "1000" => seg<="0000000";
when "1001" => seg<="0011000";
when "1010" => seg<="0001000";
when "1011" => seg<="0000011";
when "1100" => seg<="1000110";
when "1101" => seg<="0100001";
when "1110" => seg<="0000110";
when "1111" => seg<="0001110";

when others=>null;
end case;
--wait;-- for 5000 ms;
--end if;
end process;
end Behavioral;
