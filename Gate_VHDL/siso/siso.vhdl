library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity siso is
port(
    clk,rst : in std_logic;
    sin : in std_logic_vector(3 downto 0);
    sout : out std_logic_vector(3 downto 0)
);
end siso;

architecture behavioral of siso is 
signal temp : std_logic_vector(3 downto 0);
begin
process (clk,rst)
begin
if (rst='0') then
    temp <= sin;
    sout <= "0000";
elsif (rising_edge(clk)) then
    sout <= temp;
    temp <= temp(2 downto 0) & temp(3);
end if;
end process;
end behavioral;
