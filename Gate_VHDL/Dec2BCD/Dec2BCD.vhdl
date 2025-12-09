library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Dec2BCD is 
port(
    a : in std_logic_vector( 3 downto 0);
    b : out std_logic_vector(3 downto 0)
);
end Dec2BCD;

architecture behavioral of Dec2BCD is 
begin
    process(a)
    begin
        case a is
            when "0000" => b <= "0000";
            when "0001" => b <= "0001";
            when "0010" => b <= "0010";
            when "0011" => b <= "0011";
            when "0100" => b <= "0100";
            when "0101" => b <= "0101";
            when "0110" => b <= "0110";
            when "0111" => b <= "0111";
            when "1000" => b <= "1000";
            when "1001" => b <= "1001";
            when others => b <= (others => 'Z');
        end case;
    end process;
end behavioral;
