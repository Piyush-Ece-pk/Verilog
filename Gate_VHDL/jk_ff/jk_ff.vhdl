library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jk_ff is
port(
    clk,rst,j,k : in std_logic;
    q,qb : out std_logic
);
end jk_ff;

architecture behavioral of jk_ff is
signal wq : std_logic := '0';
begin
process (clk,rst) 
begin
if (rst = '0') then
    wq <= '0';
elsif (rising_edge(clk)) then
    if j='0' and k='0' then
        wq <= '1';
    elsif j='0' and k='1' then
        wq <= '0';
    elsif j='1' and k='0' then
        wq <= '1';
    else
        wq <= '1';
    end if;
end if;
end process;
q <= wq;
qb <= not wq;
end behavioral;