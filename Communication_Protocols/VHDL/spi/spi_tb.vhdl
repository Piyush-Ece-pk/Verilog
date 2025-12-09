library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_tb is
end spi_tb;

architecture behavioral of spi_tb is
signal clk,rst,start,miso: std_logic;
signal data_in: std_logic_vector(7 downto 0):= x"AA" ;
signal data_out: std_logic_vector(7 downto 0);
signal ss,sck,mosi,done: std_logic;

begin
spi_inst_uut : entity work.spi_tx port map(
    clk => clk,
    rst=>rst,
    start=>start,
    miso=>miso,
    data_in=>data_in,
    data_out=>data_out,
    ss=>ss,
    sck=>sck,
    mosi=>mosi,
    done=>done
); 

clk_process : 
process begin
while true loop
clk <= '0';
wait for 10 ns;
clk <= not clk;
wait for 10 ns;
end loop;
end process;

stim : 
process begin
    start <= '0';
    miso <= '0';
    rst <= '1';
    wait for 10 ns;
    rst <= '0';

    wait for 10 ns;
    start <= '1';
    wait for 10 ns;
    start <= '0';

    wait until ss = '0';
    wait for 10 ns; miso <= '1';
    wait for 40 ns; miso <= '0';
    wait for 40 ns; miso <= '1';
    wait for 40 ns; miso <= '0';
    wait for 40 ns; miso <= '1';
    wait for 40 ns; miso <= '0';
    wait for 40 ns; miso <= '1';
    wait for 40 ns; miso <= '0';
    wait until done = '1';
wait for 50 ns;
end process;
end behavioral;

