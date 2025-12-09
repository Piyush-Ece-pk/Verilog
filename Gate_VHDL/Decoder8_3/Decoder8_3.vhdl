library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder8_3 is
port(
    a: out std_logic_vector(7 downto 0);
    s: in std_logic_vector(2 downto 0)
);
end Decoder8_3;

architecture behavioral of Decoder8_3 is
begin
    process(s) begin
        case s is
            when "000" => a <= "00000001";
            when "001" => a <= "00000010";
            when "010" => a <= "00000100";
            when "011" => a <= "00001000";
            when "100" => a <= "00010000";
            when "101" => a <= "00100000";
            when "110" => a <= "01000000";
            when "111" => a <= "10000000";
            when others => a <= (others => '0');
        end case;
    end process;
end behavioral;
          
