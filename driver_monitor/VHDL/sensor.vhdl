library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sensor is 
port(
    clk,rst: in std_logic;
    steer,accel : out signed(7 downto 0);
    brake : out unsigned(7 downto 0)
);
end sensor;

architecture behavioral of sensor is
signal counter : unsigned(7 downto 0);
begin
process (clk,rst)
begin   
    if (rst = '0') then
        counter <= (others => '0');
        accel <= (others=>'0');
        steer <= (others=>'0');
        brake <= (others=>'0');
    elsif (rising_edge(clk)) then
        counter <= counter+1;
        if (counter > 200) then
            brake <= (others => '0');
        else
            brake <= counter;
        end if;
        if counter > 127 then
            accel <= to_signed(127,8);
        else
            accel <= to_signed(to_integer(counter), 8);
        end if;

        steer <= signed(counter(6 downto 0) & '0');
    end if;
end process;
end behavioral;


