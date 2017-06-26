----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/17/2017 10:43:38 PM
-- Design Name: 
-- Module Name: led_tester - Behavioral
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

entity led_tester is
    Port ( basys_clk : in STD_LOGIC;
            btnC: in std_logic;
            an: out std_logic_vector(3 downto 0);
            sw : in std_logic_vector(15 downto 0);
            seg: out std_logic_vector(6 downto 0);
           led : out STD_LOGIC_VECTOR(15 downto 0));
           
end led_tester;
    
architecture Behavioral of led_tester is
signal state: std_logic:='0';   --for led
signal reducedClock: std_logic;--:='1';

--signals for each 7 SS
signal digit_0: std_logic_vector(3 downto 0);
signal digit_1: std_logic_vector(3 downto 0);
signal digit_2: std_logic_vector(3 downto 0);
signal digit_3: std_logic_vector(3 downto 0);

--signal show_0: std_logic:='0';
--signal show_1: std_logic:='0';
--signal show_2: std_logic:='0';
--signal show_3: std_logic:='0';

signal which_out:std_logic_vector(1 downto 0);


begin
led<=  sw;

newfreqDivider: entity work.freq_divider port map(input_clk=>basys_clk,clk=>reducedClock);
finaldivider: entity work.freq_divider_with_ctr port map(clk=>reducedClock, which=>which_out);
--need to change second reducedClock to sometingn else? delays



process(reducedClock,btnC)
variable holder: std_logic_vector (15 downto 0):="0000000000000000";

begin



if rising_edge(reducedClock) then
if btnC<='0' then
--led(0) <= state;
--state<= not state;
--if btnC<='1' then
--holder := sw;
--end if;

--split input
digit_0 <= holder(3 downto 0);
digit_1 <= holder(7 downto 4);
digit_2 <= holder(11 downto 8);
digit_3 <= holder(15 downto 12);
else

digit_0 <= sw(3 downto 0);
digit_1 <= sw(7 downto 4);
digit_2 <= sw(11 downto 8);
digit_3 <= sw(15 downto 12);
holder:=sw;
end if;
--detech which digit to display(and set appropriate anode)
if which_out<="00" then
--show digit0
an<="1110";
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

elsif which_out<="01" then
--show digit1
an<="1101";

case digit_1 is
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


elsif which_out<="10" then
--show digit2
an<="1011";
case digit_2 is
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

elsif which_out<="11" then
--show digit3
an<="0111";

case digit_3 is
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

end if;

end if;
end process;
end Behavioral;
