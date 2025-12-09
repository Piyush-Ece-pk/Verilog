library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_cnt_tb is
end up_cnt_tb;

architecture behavioral of up_cnt_tb is
signal clk,rst : std_logic;
signal q : std_logic_vector(3 downto 0);
begin
uut : entity work.up_cnt port map(
    clk => clk,
    rst => rst,
    q => q
);

clk_process :
process begin
clk <= '0';
wait for 5 ns;
clk <= '1';
wait for 5 ns;
end process;

stim : 
process begin
rst <= '0';
wait for 10 ns;
rst <= '1';
wait for 400 ns;
wait;
end process;
end behavioral;