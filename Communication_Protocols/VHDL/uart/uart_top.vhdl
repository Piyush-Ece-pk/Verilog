library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity uart_top is
port(
    clk,rst : in std_logic;
    tx,tx_done: out std_logic;
    tx_start : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    rx : in std_logic;
    rx_done,parity_err : out std_logic;
    data_out : out std_logic_vector(7 downto 0)
);
end uart_top;

architecture behavioral of uart_top is
signal tx_int : std_logic;
begin
uart_tx_inst : entity work.uart_tx port map(
    clk => clk,
    rst => rst,
    tx => tx_int,
    tx_done => tx_done,
    tx_start => tx_start,
    data_in => data_in
);

uart_rx_inst : entity work.uart_rx port map(
    clk => clk,
    rst => rst,
    rx => tx_int,
    rx_done => rx_done,
    parity_err => parity_err,
    data_out => data_out
);

tx <= tx_int;
end behavioral;
