library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4_1_tb is
end mux4_1_tb;

architecture behavioral of mux4_1_tb is
signal a: std_logic_vector(3 downto 0);
signal s: std_logic_vector(1 downto 0);
signal o: std_logic;
begin
uut: entity work.mux_4_1 port map(
    a => a,
    o => o,
    s => s
);

stim:
process begin
a<="1001";
s<="01"; wait for 10 ns;
s<="11"; wait for 10 ns;
s<="00"; wait for 10 ns;
wait;
end process;
end behavioral;