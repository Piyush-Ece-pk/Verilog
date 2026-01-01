library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity window_mean is
port(
    clk,rst: in std_logic;
    score : in unsigned(7 downto 0);
    avg : out signed(7 downto 0)

);
end window_mean;


architecture behavioral of window_mean is
type buff_array is array (0 to 7) of unsigned ( 7 downto 0);
signal buff : buff_array;
signal sum : signed(10 downto 0);
begin
process(clk,rst,score)
begin   
    if (rst = '0') then
        avg <= (others=> '0');
        sum <= (others => '0');
        buff <= (others =>(others => '0'));
    elsif (rising_edge(clk)) then
        sum <=   sum-resize(signed(buff(7)),sum'length) + resize(signed(score),sum'length);
        for idx in 7 downto 1 loop
            buff(idx) <= buff(idx-1);
        end loop;
        buff(0) <= score;
        avg <=sum(10 downto 3);
    end if;
end process;
end behavioral;


        

