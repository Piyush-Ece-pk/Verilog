library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tab3 is
port (
    clk   : in std_logic;
    rst   : in std_logic;
    result : out std_logic_vector(7 downto 0);
    index  : out std_logic_vector(3 downto 0)
);
end tab3;

architecture behavioral of tab3 is
signal counter : unsigned(3 downto 0); 
signal temp_result : unsigned(7 downto 0);
begin

process (clk, rst)
begin
    if rst = '0' then
        counter     <= (others => '0');
        index       <= (others => '0');
        result      <= (others => '0');

    elsif rising_edge(clk) then
        counter <= counter + 1;
        index   <= std_logic_vector(counter);
        temp_result <= resize(counter * 3, 8);
        result <= std_logic_vector(temp_result);
    end if;
end process;

end behavioral;
