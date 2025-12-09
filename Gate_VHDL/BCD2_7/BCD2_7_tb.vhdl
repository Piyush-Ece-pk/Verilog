library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD2_7_tb is
end BCD2_7_tb;

architecture behavioral of BCD2_7_tb is
signal a : std_logic_vector(3 downto 0);
signal s : std_logic_vector(6 downto 0);
begin

uut : entity work.BCD2_7 port map(
    a => a,
    s => s
);

stim: process
begin
a <= "0000"; wait for 10 ns;
a <= "0010"; wait for 10 ns;
a <= "0100"; wait for 10 ns;
a <= "0110"; wait for 10 ns;
wait;
end process;
end behavioral;
