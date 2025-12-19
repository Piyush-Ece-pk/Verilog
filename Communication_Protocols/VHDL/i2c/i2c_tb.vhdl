library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_tb is
end i2c_tb;

architecture behavioral of i2c_tb is
    signal clk,rst : std_logic := '0';
    signal start :  std_logic;
    signal rw :  std_logic;
    signal addr7 :  std_logic_vector(6 downto 0);
    signal reg_addr :  std_logic_vector(7 downto 0);
    signal data_in : std_logic_vector(7 downto 0);
    signal busy :  std_logic;
    signal ack_err :  std_logic;
    signal done :  std_logic;
    signal read_data :  std_logic_vector(7 downto 0);


begin
clk_process : 
process begin
clk <= '0';
wait for 5 ns;
clk <= not clk;
wait for 5 ns;
end process;

top_inst : entity work.i2c_top port map(
    clk => clk,
    rst => rst,
    start => start,
    rw => rw,
    addr7 => addr7,
    reg_addr => reg_addr,
    data_in => data_in,
    busy => busy,
    done => done,
    ack_err => ack_err,
    read_data => read_data
);

stim : 
process begin
    rst <= '0';
    wait for 100 ns;
    rst <= '1';
    wait for 200 ns;

    start <= '1';
    rw <= '0';
    wait for 40 ns;
    start <= '0';

    wait until done = '1';
    wait for 500 ns;

    start <= '1';
    rw <= '0';
    wait for 40 ns;
    start <= '0';
    wait until done = '1';
    wait for  500 ns;
    wait;
    end process;
end behavioral;


