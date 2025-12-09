library ieee;
use ieee.std_logic_1164.all;

entity one_bit_comp is
port (
    a,b : in std_logic;
    e,l,g : out std_logic
);
end one_bit_comp;

architecture behavioral of one_bit_comp is
begin
process(a,b)
begin
e <= '0'; l <= '0'; g <= '0';
if (a = b ) then e <= '1';
elsif (a >b)  then g <= '1';
else l <= '1';
end if ;
end process;
end behavioral;

