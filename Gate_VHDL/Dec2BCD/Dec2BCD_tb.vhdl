library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dec2BCD_tb is 
end Dec2BCD_tb;

architecture behavioral of Dec2BCD_tb is 
signal a,b : std_logic_vector(3 downto 0);
begin
uut : entity work.Dec2BCD port map (
    a => a,
    b => b
);

stim: process
begin
a<="1001"; wait for 10 ns;
a<="1101"; wait for 10 ns;
a<="1111"; wait for 10 ns;
wait;
end process;
end behavioral;

