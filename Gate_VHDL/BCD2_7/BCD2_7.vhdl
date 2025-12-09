library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BCD2_7 is
port (
    a : in std_logic_vector(3 downto 0);
    s : out std_logic_vector(6 downto 0)
);
end BCD2_7;

architecture behavioral of BCD2_7 is
begin
process (a) 
begin 
    case a is
        when "0000" => s <= "1111110";
        when "0001" => s <= "0110000";
        when "0010" => s <= "1101101";
        when "0011" => s <= "1111001";
        when "0100" => s <= "0110011";
        when "0101" => s <= "1011011";
        when "0110" => s <= "1011111";
        when "0111" => s <= "0111000";
        when "1000" => s <= "1111111";
        when "1001" => s <= "1111011";
        when others => s <= "0000000";
    end case;
end process;
end behavioral;
