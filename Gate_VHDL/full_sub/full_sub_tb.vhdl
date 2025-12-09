library ieee;
use ieee.std_logic_1164.all;

entity full_sub_tb is
end full_sub_tb;

architecture behavioral of full_sub_tb is
signal a,b,bin,diff,bo : std_logic;
begin

uut : entity work.full_sub port map(
    a => a,
    b => b,
    bin => bin,
    diff => diff,
    bo => bo
);

stim: 
process begin
a <= '0'; b<='0'; bin<='0'; wait for 10 ns;
a <= '0'; b<='0'; bin<='1'; wait for 10 ns;
a <= '0'; b<='1'; bin<='0'; wait for 10 ns;
a <= '0'; b<='1'; bin<='1'; wait for 10 ns;
a <= '1'; b<='0'; bin<='0'; wait for 10 ns;
a <= '1'; b<='0'; bin<='1'; wait for 10 ns;
a <= '1'; b<='1'; bin<='0'; wait for 10 ns;
a <= '1'; b<='1'; bin<='1'; wait for 10 ns;
wait;
end process;
end behavioral;

