library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t_ff_tb is
end t_ff_tb;

architecture behavioral of t_ff_tb is
signal clk,rst,t,q,qb : std_logic;
begin

uut : entity work.t_ff port map(
    clk => clk,
    rst => rst,
    t => t,
    q => q,
    qb => qb
);

clock_process: 
process begin 
while true loop
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end loop;
end process clock_process;

stim:
process begin
rst <= '0'; t <= '0' ; wait for 10 ns;
rst <= '1'; t <= '0' ; wait for 10 ns;
t <= '1'; wait for 10 ns;
wait;
end process;
end behavioral;
