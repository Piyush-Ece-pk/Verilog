library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity emergency is
port(
    score : in unsigned(7 downto 0);
    warning : out std_logic;
    emergent : out std_logic
);
end emergency;

architecture behavioral of emergency is
begin
process (score)
begin
    warning <= '0';
    emergent <= '0';
    if (score > to_unsigned(180,8)) then
        emergent <= '1';
    elsif (score > to_unsigned(100,8)) then
        warning <= '1';
    else
        warning <= '0';
        emergent <= '0';
    end if;
end process;
end behavioral;
