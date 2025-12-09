library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity up_cnt is
port(
    clk,rst: in std_logic;
    q : out std_logic_vector(3 downto 0)
);
end up_cnt;

architecture behavioral of up_cnt is
signal a : unsigned(3 downto 0);
begin
process(clk,rst)
begin
if (rst = '0') then
    a <= "0000";
elsif (rising_edge(clk)) then
    if (a < "1111") then
        a <= a+1;
    else
        a <= "0000";
    end if;
end if;
end process;
q <= std_logic_vector(a);
end behavioral;
