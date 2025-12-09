library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_comp_tb is
end four_bit_comp_tb;

architecture behavioral of four_bit_comp_tb is
signal a,b : std_logic_vector(3 downto 0);
signal e,l,g : std_logic;
begin
uut : entity work.four_bit_comp port map(
    a=>a,
    b=>b,
    e=>e,
    l=>l,
    g=>g
);
stim: process 
begin
a<="0001"; b<="0001"; wait for 10 ns;
a<="0010"; b<="0001"; wait for 10 ns;
a<="0100"; b<="0101"; wait for 10 ns;
a<="0001"; b<="1001"; wait for 10 ns;
wait;
end process;
end behavioral;