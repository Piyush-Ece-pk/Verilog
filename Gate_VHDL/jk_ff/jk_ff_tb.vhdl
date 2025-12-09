library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jk_ff_tb is
end jk_ff_tb;

architecture behavioral of jk_ff_tb is
signal clk,rst,j,k,q,qb : std_logic;
begin

uut: entity work.jk_ff port map(
    clk => clk,
    rst => rst,
    j => j,
    k => k,
    q => q,
    qb => qb
);

clk_process : process
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process clk_process;

stim: process
begin
rst <= '0'; j <= '0'; k <= '0'; wait for 10 ns;
rst <= '1'; j <= '0'; k <= '0'; wait for 10 ns;
j <= '0'; k <= '1'; wait for 10 ns;
j <= '1'; k <= '0'; wait for 10 ns;
j <= '1'; k <= '1'; wait for 10 ns;
wait;
end process;
end behavioral;

