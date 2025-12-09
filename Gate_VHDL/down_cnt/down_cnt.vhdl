library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity down_cnt is
port(
    clk,rst : in std_logic;
    q : out std_logic_vector(3 downto 0)
);
end down_cnt;

architecture behavioral of down_cnt is
signal a : unsigned(3 downto 0);
begin
process (clk,rst)
begin
if (rst='0') then
    a <= "1111";
elsif (rising_edge(clk)) then
    if (a > "0000") then
        a <= a-1;
    end if;
end if;
end process;
q <= std_logic_vector(a);
end behavioral;