library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity driver_monitor_tb is
end driver_monitor_tb;

architecture behavioral of driver_monitor_tb  is
signal clk,rst : std_logic;
signal cfg_we :  std_logic;
signal cfg_addr : std_logic_vector(3 downto 0);
signal wght_data :  std_logic_vector(15 downto 0);

begin
top_uut : entity work.driver_monitor_top port map(
    clk => clk,
    rst => rst,
    cfg_we => cfg_we,
    cfg_addr => cfg_addr,
    wght_data => wght_data
);

clk_process : process
begin
    clk <= '0';
    wait for 5 ns;
    clk <= not clk;
    wait for 5 ns;
end process;

stim: process

procedure write_cfg (
    constant addr : in std_logic_vector(3 downto 0);
    constant data : in signed(7 downto 0)
) is 
begin
    cfg_addr <= addr;
    wght_data <= (others => '0');
    wght_data(7 downto 0) <= std_logic_vector(data);
    cfg_we <= '1';
    wait for 10 ns;
    cfg_we <= '0';
    wait for 10 ns;
end procedure;

begin
    rst <= '0';

    wait for  20 ns;
    rst <= '1';
    write_cfg("0000", to_signed(2,8)); 
    write_cfg("0001", to_signed(3,8));   
    write_cfg("0010", to_signed(4,8));   
    write_cfg("0011", to_signed(1,8));
    write_cfg("0100", to_signed(120,8));
    write_cfg("0101", to_signed(190,8));
    wait for 500 ns;
    write_cfg("0100", to_signed(100,8));
    write_cfg("0101", to_signed(160,8)); 
    wait;
end process;
end behavioral;
