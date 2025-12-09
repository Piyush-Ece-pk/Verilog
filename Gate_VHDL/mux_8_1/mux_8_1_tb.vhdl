library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux8_1_tb is
end mux8_1_tb;

architecture behavioral of mux8_1_tb is 
signal a: std_logic_vector(7 downto 0);
signal s: std_logic_vector(2 downto 0);
signal o: std_logic;
begin
uut : entity work.mux8_1 port map(
    a => a,
    s => s,
    o => o
);
stim: 
process begin
a <= "10101010"; 
s <= "000";wait for 10 ns;
s <= "011"; wait for  10 ns;
s <= "111"; wait for 10 ns;
wait;
end process;
end behavioral;
