library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tb is
end uart_tb;

architecture behavioral of uart_tb is
signal clk,rst :std_logic;
signal tx,tx_done: std_logic;
signal tx_start : std_logic;
signal data_in : std_logic_vector(7 downto 0);
signal rx : std_logic;
signal rx_done,parity_err : std_logic;
signal data_out : std_logic_vector(7 downto 0);

begin
top_uut : entity work.uart_top port map(
    clk => clk,
    rst => rst,
    tx => tx,
    tx_done => tx_done,
    tx_start => tx_start,
    data_in => data_in,
    rx => rx,
    rx_done => rx_done,
    parity_err => parity_err,
    data_out => data_out
);

clk_process:
process 
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end loop;
end process;

stim: 
process
begin
rst <= '0';
wait for 10 ns;
rst <= '1';
data_in <= "10101111";
tx_start <= '1';
wait for 10 ns;
tx_start <= '0';
wait for 200000 ns;
wait;
end process;
end behavioral;


