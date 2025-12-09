library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity t_ff is
port (
    clk,rst,t : in std_logic;
    q,qb : out std_logic
);
end t_ff;

architecture behavioral of t_ff is
signal wq :std_logic := '0';
begin
process(clk,rst)
begin
if (rst='0') then
    wq <= '0';
elsif (rising_edge(clk)) then   
    wq <= not t;
end if;
end process;
q <= wq;
qb <= not wq;
end behavioral;