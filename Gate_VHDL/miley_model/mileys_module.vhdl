library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mileys_module is
port(
    clk,rst,x : in std_logic;
    z : out std_logic
);
end mileys_module;

architecture behavioral of mileys_module is
type state_type is (s0,s1,s2);
signal current_s, next_s : state_type;
begin
process(clk,rst)
begin
if (rst='0') then
    current_s <= s0;
elsif (rising_edge(clk)) then
    current_s <= next_s;
end if;
end process;

process(clk,rst) 
begin
case current_s is
    when s0 => 
        if (x='0') then
            z <= '0';
            next_s<=s0;
        elsif (x='1') then
            z <= '0';
            next_s <= s1;
        end if;
    when s1 =>
        if (x='0') then
            z <='1';
            next_s <= s2;
        elsif (x='1') then
            z <='0';
            next_s <= s1;
        end if;
    when s2 => 
        if (x='0') then
            z<='0';
            next_s <= s0;
        elsif (x='1') then
            z <= '1';
            next_s <= s1;
        end if;
end case;
end process;
end behavioral;
 