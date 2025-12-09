library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ring_cnt is
port(
    clk,rst : in std_logic;
    q : out std_logic_vector(3 downto 0)
);
end ring_cnt;

architecture behavioral of ring_cnt is
signal a : std_logic_vector(3 downto 0);
begin
process (clk,rst) begin
if (rst='0') then
    a <= "1001";
elsif (rising_edge(clk)) then
    a <= a(2 downto 0) & a(3);
end if;
end process;
q <= a;
end behavioral;