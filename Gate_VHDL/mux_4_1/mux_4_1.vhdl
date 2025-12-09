library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity mux_4_1 is
port(
    a:in std_logic_vector(3 downto 0);
    s:in std_logic_vector(1 downto 0);
    o:out std_logic
);
end mux_4_1;
architecture behavioral of mux_4_1 is
begin
    process(s,a) begin
        if (s="00") then
            o <= a(0);
        elsif (s="01") then
            o <= a(1);
        elsif (s="10") then
            o <= a(2);
        else
            o <= a(3);
        end if;
    end process;
end behavioral;

