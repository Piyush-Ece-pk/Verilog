library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moore_tb is
end moore_tb;

architecture behavioral of moore_tb is
signal clk,rst,x,z : std_logic;
begin
uut : entity work.moore port map(
    clk=>clk,
    rst=>rst,
    x=>x,
    z=>z
);

clk_process :
process begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process;

stim: process
begin
rst <= '0'; wait for 10 ns;
rst <= '1';
x <= '1'; wait for 10 ns;
x <= '1'; wait for 10 ns;
x <= '1'; wait for 10 ns;
x <= '0'; wait for 10 ns;
x <= '1'; wait for 10 ns;
wait;
end process;
end behavioral;