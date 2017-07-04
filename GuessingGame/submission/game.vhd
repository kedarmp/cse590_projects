----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2017 04:13:13 PM
-- Design Name: 
-- Module Name: game - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;




entity game is
  Port ( 
    an: out std_logic_vector(3 downto 0);
    seg: out std_logic_vector(6 downto 0);
    sw: in std_logic_vector(15 downto 0);
    led: out std_logic_vector(15 downto 0):="0000000000000000";
    btnD: in std_logic;
    basys_clk: in std_logic
  );
end game;

architecture Behavioral of game is
signal slow_clk: std_logic;
shared variable state:integer:=1;
shared variable howmany: integer:=0;


--signals for each 7 SS

--signal digit_2: std_logic_vector(3 downto 0);
--signal digit_3: std_logic_vector(3 downto 0);

begin
div: entity work.freq_divider port map(input_clk=>basys_clk,clk=>slow_clk);

process (slow_clk, sw) 
variable which:integer:=0;
variable pl_1_number: std_logic_vector(15 downto 0);
variable pl_2_number: std_logic_vector(15 downto 0);
variable tries:integer:=0;
variable triesBinary:std_logic_vector(15 downto 0);
--signals for each 7 SS
variable digit_0: std_logic_vector(3 downto 0);
variable digit_1: std_logic_vector(3 downto 0);
variable digit_2: std_logic_vector(3 downto 0);
variable digit_3: std_logic_vector(3 downto 0);

variable initial_sw: std_logic_vector(15 downto 0);
variable i:integer:=0;

begin
if rising_edge(slow_clk) then
howmany := howmany + 1;

--store initial value of switches
if i=0 then initial_sw:=sw; end if;
i:=i+1;

if sw/= initial_sw then
--switch has changed
--update led
initial_sw:=sw;
digit_0 := sw(3 downto 0);
digit_1 := sw(7 downto 4);
digit_2 := sw(11 downto 8);
digit_3 := sw(15 downto 12);
if (state = 1 or state = 6) then
state:=6;
elsif state = 2 or state = 3 or state = 4 or state = 7 then
state:=7;
end if;
end if;



if btnD = '1' and howmany>381 then
--store number entered in switches into a variable
if state = 1 or state = 6 then
pl_1_number := sw;
-- then show PL2
state := 2;
howmany:=0;

elsif state = 2 or state = 3 or state = 4 or state = 7 then
--start comparing
tries:=tries + 1;
--led <= "0000000000000000";
pl_2_number := sw;
    if pl_2_number > pl_1_number then
--        led <= "1111111100000000";
        state:=3;   --2 HI
        howmany:=0;

        elsif pl_2_number < pl_1_number then
--        led <= "0000000011111111";
        state:=4;   --2 LO
        howmany:=0;
        else
        state:=5;   --WIN
        howmany:=0;

    end if;
    
end if;
-- chang state
end if;



if state = 1 then
--show PL 1 on screen
case which is
    when 0=> seg <= "1111001"; an <= "1110"; which := which + 1; -- 1 
    when 1=> seg <= "0111111"; an <= "1101"; which := which + 1;-- -
    when 2=> seg <= "1000111"; an <= "1011"; which := which + 1;-- L
    when 3=> seg <= "0001100"; an <= "0111"; which := 0;-- P
    when others=>null;
end case;

--else states..
elsif state = 2 then
--show PL 2 on screen
case which is
    when 0=> seg <= "0100100"; an <= "1110"; which := which + 1; -- 2
    when 1=> seg <= "0111111"; an <= "1101"; which := which + 1;-- -
    when 2=> seg <= "1000111"; an <= "1011"; which := which + 1;-- L
    when 3=> seg <= "0001100"; an <= "0111"; which := 0;-- P
    when others=>null;
end case;

elsif state = 3 then
--show 2 HI on screen
case which is
    when 0=> seg <= "1001111"; an <= "1110"; which := which + 1; -- I
    when 1=> seg <= "0001001"; an <= "1101"; which := which + 1;-- H
    when 2=> seg <= "1111111"; an <= "1011"; which := which + 1;-- (space)
    when 3=> seg <= "0100100"; an <= "0111"; which := 0;-- 2
    when others=>null;
end case;

elsif state = 4 then
--show 2 LO on screen
case which is
    when 0=> seg <= "1000000"; an <= "1110"; which := which + 1; -- 0
    when 1=> seg <= "1000111"; an <= "1101"; which := which + 1;-- L
    when 2=> seg <= "1111111"; an <= "1011"; which := which + 1;-- (space)
    when 3=> seg <= "0100100"; an <= "0111"; which := 0;-- 2
    when others=>null;
end case;

elsif state = 5 then --or state = 6 then
--show number of tries on screen(currently shown in hex). And flash LEDs.
--if state = 5 then --only when player has won
    triesBinary := std_logic_vector(to_unsigned(tries, triesBinary'length));
    digit_0 := triesBinary(3 downto 0);
    digit_1 := triesBinary(7 downto 4);
    digit_2 := triesBinary(11 downto 8);
    digit_3 := triesBinary(15 downto 12);
--else
--    digit_0 := sw(3 downto 0);
--    digit_1 := sw(7 downto 4);
--    digit_2 := sw(11 downto 8);
--    digit_3 := sw(15 downto 12);
--end if;

case which is
    
    when 0=> 
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
    which := which + 1; -- (space)
    
    when 1=>
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
    which := which + 1;-- Y
    
    when 2=> 
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
    which := which + 1;-- A
    
    when 3=> 
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
     which := 0;-- Y
    when others=>null;
end case;
--led <= "1111111111111111" ;--maybe flash?

elsif state = 6 then

--live display
case which is
    
    when 0=> 
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
    which := which + 1; -- (space)
    
    when 1=>
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
    which := which + 1;-- Y
    
    when 2=> 
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
    which := which + 1;-- A
    
    when 3=> 
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
     which := 0;-- Y
    when others=>null;
end case;
--led <= "1111111111111111" ;--maybe flash?


--live display end


--case 7
elsif state = 7 then

--live display
case which is
    
    when 0=> 
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
    which := which + 1; -- (space)
    
    when 1=>
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
    which := which + 1;-- Y
    
    when 2=> 
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
    which := which + 1;-- A
    
    when 3=> 
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
     which := 0;-- Y
    when others=>null;
end case;

end if;
end if;
end process;

--blinker
process (slow_clk) 
variable ledstate:integer:=1;
variable howmany: integer:=0;

begin
if rising_edge(slow_clk) then
howmany := howmany + 1;

if state = 5 and howmany>190 then
--store number entered in switches into a variable
if ledstate = 1 then
led <= "1111111111111111";
ledstate := 0;
else
led <= "0000000000000000";
ledstate := 1;
end if;
howmany:=0;


-- chang state
end if;

end if;
end process;

--process(btnD) --remove sw!!

----variable pl_1_number: std_logic_vector(15 downto 0);
----variable pl_2_number: std_logic_vector(15 downto 0);
--begin
----led(0) <= btnD;



----if btnD = '1' and howmany>1905 then
------store number entered in switches into a variable
----if state = 1 then
----pl_1_number := sw;
------ then show PL2
----state := 2;
----howmany:=0;

----elsif state = 2 then
------start comparing
------led <= "0000000000000000";
----pl_2_number := sw;
----    if pl_1_number = pl_2_number then
----        led <= "1111111111111111";
------            led (5) <= '1';
----        else
----        led <= "0000000110000000" ;
------            led (12) <= '1';
----    end if;
    
----end if;
------ chang state
----end if;

--end process;

end Behavioral;
