library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity siso_tb is
end siso_tb;

architecture behavioral of siso_tb is
signal clk,rst  : std_logic;
signal sin,sout : std_logic_vector(3 downto 0);
begin

uut: entity work.siso port map(
    clk => clk,
    rst => rst,
    sin => sin,
    sout => sout
);

clk_process: process
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process;

stim: process
begin
rst <= '0'; sin <="1100";
wait for 10 ns;
rst <='1';
wait for 400 ns;
wait;
end process;
end behavioral;
