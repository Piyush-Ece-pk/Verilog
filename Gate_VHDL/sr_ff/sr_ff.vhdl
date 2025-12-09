library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sr_ff is
port(
    clk,rst,s,r : in std_logic;
    q,qb : out std_logic
);
end sr_ff;

architecture behavioral of sr_ff is
signal wq : std_logic := '0';

begin
process (clk,rst)
begin   
    if (rst = '0') then
        wq <= '0';
    elsif (rising_edge(clk)) then
        if (s ='0' and r = '0') then
            wq <= wq; 
        elsif (s ='0' and r = '1') then
            wq <= '0';
        elsif (s ='1' and r = '0') then
            wq <= '1';
        else 
            wq <= 'X';
        end if;
    end if;
end process;
q <= wq;
qb <= not wq;
end behavioral;


    