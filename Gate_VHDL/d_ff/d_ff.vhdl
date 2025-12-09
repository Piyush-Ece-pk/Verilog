library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity d_ff is
port(
    clk,rst,d : in std_logic;
    q,qb : out std_logic
);
end d_ff;

architecture behavioral of d_ff is
signal wq : std_logic := '0';
begin
process (clk,rst) 
begin
if (rst = '0') then
    wq <= '0';
elsif (rising_edge(clk)) then
    wq <= d;
end if;
end process;
q <= wq;
qb <= not wq;
end behavioral;
