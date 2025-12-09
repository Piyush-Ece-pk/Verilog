library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity piso_tb is
end piso_tb;

architecture behavioral of piso_tb is
signal clk,rst,sout : std_logic;
signal sin : std_logic_vector( 3 downto 0);
begin

uut: entity work.piso port map(
    clk => clk,
    rst => rst,
    sin => sin,
    sout => sout
);

clk_process : process
begin
while true loop
clk <= '0';
wait for 5 ns;
clk <= not clk ;
wait for 5 ns;
end loop;
end process;

stim: process
begin
rst <='0';
wait for 10 ns;
rst <= '1'; 
sin <= "1001";
wait for 400 ns;
wait;
end process;
end behavioral;
