library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity four_bit_comp is
port (
    a,b: in std_logic_vector(3 downto 0);
    e,l,g: out std_logic
);
end four_bit_comp;

architecture behavioral of four_bit_comp is
begin
    process(a,b) begin
    e<='0';
    l<='0';
    g<='0';
        if (a=b) then
            e<='1';
        elsif (a<b) then
            l<='1';
        else
            g<='1';
        end if;
    end process;
end behavioral;
