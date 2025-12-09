library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipo_tb is
end pipo_tb;

architecture behavioral of pipo_tb is
signal clk,rst: std_logic;
signal sin,sout : std_logic_vector(3 downto 0);
begin

uut: entity work.pipo port map(
    clk => clk,
    rst => rst,
    sin => sin,
    sout => sout
);

clk_process : process
begin
while true loop
clk <= '0' ;
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process;

stim: process
begin
rst <= '0'; wait for 10 ns;
rst <= '1'; 
sin <= "1001"; wait for 10 ns;
sin <= "1101"; wait for 10 ns;
wait;
end process;
end behavioral;

