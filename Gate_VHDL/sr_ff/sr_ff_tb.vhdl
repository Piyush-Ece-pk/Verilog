library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sr_ff_tb is
end sr_ff_tb;

architecture behavioral of sr_ff_tb is
signal s, r, clk, rst, q, qb : std_logic;
begin
uut : entity work.sr_ff port map(
    s => s,
    r => r,
    clk => clk,
    rst => rst,
    q => q,
    qb => qb
);

-- Clock generation
clk_process : process
begin
    while true loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
end process clk_process;

-- Stimulus
stim: 
process
begin
    rst <= '0' ; s <= '0' ; r <= '0'; wait for 20 ns;
    rst <= '1' ; s <= '0'; r <= '0'; wait for 10 ns;
    s <= '0'; r <= '1'; wait for 10 ns;
    s <= '1'; r <= '0'; wait for 10 ns;
    s <= '1'; r <= '1'; wait for 10 ns;

    assert false report "Simulation finished" severity failure;
end process;

end behavioral;
