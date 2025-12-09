library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sipo is
port(
    clk,rst,sin : in std_logic;
    sout : out std_logic_vector(3 downto 0)
);
end sipo;

architecture behavioral of sipo is
signal temp : std_logic_vector(3 downto 0);
begin
process (clk,rst)
begin
if (rst='0') then
    temp <= "0000";
elsif (rising_edge(clk)) then
    temp <= temp(2 downto 0) & sin;
end if;
end process;
sout <= std_logic_vector(temp);
end behavioral;