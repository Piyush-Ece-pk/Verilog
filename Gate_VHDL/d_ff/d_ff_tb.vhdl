library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_ff_tb is
end d_ff_tb;

architecture behavioral of d_ff_tb is
signal clk,rst,d,q,qb : std_logic;
begin

uut : entity work.d_ff port map(
    clk => clk,
    rst => rst,
    d => d,
    q => q,
    qb => qb
);

clk_process : 
process begin
    while true loop 
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
    end loop;
end process clk_process;

stim: 
process begin
rst <= '0' ; d <='0'; wait for  10 ns;
rst <= '1' ; d <= '0' ; wait for 10 ns;
d <= '1' ; wait for  10 ns;
wait;
end process;
end behavioral;

