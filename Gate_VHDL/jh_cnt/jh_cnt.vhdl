library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity jh_cnt is
port(
    clk,rst : in std_logic;
    q : out std_logic_vector(3 downto 0)
);
end jh_cnt;

architecture behavioral of jh_cnt is
signal a : std_logic_vector(3 downto 0);
begin
process(clk,rst) begin
    if (rst='0') then
        a <= "1001";
        q <= a;
    elsif(rising_edge(clk)) then
        a <= a(2 downto 0) &  not a(3);
        q <= a;
    end if;
end process;
end behavioral;