library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tab3_tb is
end tab3_tb;

architecture behavioral of tab3_tb is
signal clk,rst : std_logic;
signal result : std_logic_vector(7 downto 0);
signal index : std_logic_vector(3 downto 0);
begin
uut : entity work.tab3 port map(
    clk => clk,
    rst => rst,
    result => result,
    index => index
);

clk_process : process
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process;

stim : process
begin
rst <= '0';
wait for 10 ns;
rst <= '1';
wait for 200 ns;
wait;
end process;
end behavioral;