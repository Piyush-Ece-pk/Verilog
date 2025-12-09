library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipo is
port(
    clk,rst : in std_logic;
    sin : in std_logic_vector(3 downto 0);
    sout : out std_logic_vector(3 downto 0)
);
end pipo;

architecture behavioral of pipo is
begin
process (clk,rst)
begin
if (rst='0') then
    sout <= "0000";
elsif (rising_edge(clk)) then
    sout <= sin;
end if;
end process;
end behavioral;