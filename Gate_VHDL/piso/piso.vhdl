library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity piso is
port (
    clk,rst : in std_logic;
    sout : out std_logic;
    sin : in std_logic_vector(3 downto 0)
);
end piso;

architecture behavioral of piso is
signal temp : unsigned(3 downto 0);
begin
process(clk,rst) 
begin
if (rst='0') then
    sout <= '0';
    temp <= "0000";
elsif (rising_edge(clk)) then
    if (to_integer(temp) < 4) then
        sout <= sin(to_integer(temp));
        temp <= temp+1;
    else
        temp <= "0000";
    end if;
end if;
end process;
end behavioral;

