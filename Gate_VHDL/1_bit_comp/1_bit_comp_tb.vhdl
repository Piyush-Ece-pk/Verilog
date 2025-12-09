library ieee;
use ieee.std_logic_1164.all;

entity one_bit_comp_tb is
end one_bit_comp_tb;

architecture behavioral of one_bit_comp_tb is
signal a,b,e,l,g : std_logic;
begin
uut: entity work.one_bit_comp port map(
    a=>a,
    b=>b,
    e=>e,
    l=>l,
    g=>g
);

stim:
process begin
a<='0'; b<='0'; wait for 10 ns;
a<='0'; b<='1'; wait for 10 ns;
a<='1'; b<='0'; wait for 10 ns;
a<='1'; b<='1'; wait for 10 ns;
wait;
end process;
end behavioral;
