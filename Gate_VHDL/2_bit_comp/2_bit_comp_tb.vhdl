library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity two_bit_comp_tb is
end two_bit_comp_tb;

architecture behavioral of two_bit_comp_tb is
signal a,b:std_logic_vector(1 downto 0);
signal e,l,g: std_logic;
begin 
uut: entity work.two_bit_comp port map(
    a =>a,
    b=>b,
    e=>e,
    l=>l,
    g=>g   
);

stim:
process begin
a <= "01"; b <= "10"; wait for 10 ns;
a <= "00"; b <= "10"; wait for 10 ns;
a <= "11"; b <= "11"; wait for 10 ns;
a <= "10"; b <= "01"; wait for 10 ns;
wait;
end process;
end behavioral;
