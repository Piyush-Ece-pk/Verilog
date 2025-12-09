library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parcheck_tb is
end parcheck_tb;

architecture behavioral of parcheck_tb is
signal clk,rst : std_logic;
signal input_bits : std_logic_vector(8 downto 0);
signal even,odd : std_logic;
begin

uut: entity work.parcheck port map(
    clk => clk,
    rst => rst,
    input_bits => input_bits,
    even => even,
    odd=>odd
);

clk_process : process
begin
while true loop 
    clk <= '1';
    wait for 5 ns;
    clk <= not clk;
    wait for 5 ns;
end loop;
end process;

stim : process
begin
rst <= '0'; wait for 10 ns;
rst <= '1';
input_bits <= "101010101"; wait for 10 ns;
input_bits <= "101111111"; wait for 10 ns;
input_bits <= "100000011"; wait for 10 ns;
input_bits <= "101000011"; wait for 10 ns;
input_bits <= "101001111"; wait for 10 ns;
wait;
end process;
end behavioral;