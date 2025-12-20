library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light_tb is
end traffic_light_tb;

architecture behavioral of traffic_light_tb is
signal clk,rst :  std_logic;
signal sns,nss,wes,ews : std_logic;
signal n,s,w,e :  std_logic_vector( 1 downto 0);
begin
traffic_uut : entity work.traffic_light port map(
    clk => clk,
    rst => rst,
    n => n,
    s => s,
    e => e,
    w => w,
    sns => sns,
    nss => nss,
    wes => wes,
    ews => ews
);

clk_process : process
begin
    clk <= '0';
    wait for 5 ns;
    clk <= not clk;
    wait for 5 ns;
end process;

stim : process
begin
    rst <= '0'; 
    nss <= '0';sns <= '0';ews <= '0';wes <= '0';
    wait for 10 ns;
    rst <= '1';
    wait for 20 ns;
    wes <= '1';
    wait for 200 ns;
    wes <= '0';
    nss <= '1';
    wait for 150 ns;
    nss <= '0';
    sns <= '1';
    wait for 100 ns;
    sns <= '0';
    ews <= '1';
    wait for 100 ns;
    ews <= '0';
    wait for 10 ns;
    wait;
end process;
end behavioral;
