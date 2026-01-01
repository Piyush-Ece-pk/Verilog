library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ml_core is
port(
    clk,rst : in std_logic;
    accel : in signed(7 downto 0);
    jerk : in signed(7 downto 0);
    steer : in signed(7 downto 0);
    brake : in unsigned(7 downto 0);
    w0,w1,w2,w3 : in signed(7 downto 0);
    score : out unsigned(7 downto 0)
);
end ml_core;

architecture behavioral of ml_core is

signal sum : signed(17 downto 0);
begin
    process (clk,rst)
    variable acc : signed(17 downto 0);
    begin
        if (rst = '0') then
            score <= (others => '0');
            sum <= (others => '0');

        elsif (rising_edge(clk)) then
            acc := resize(w0*accel,18)+resize(w1*jerk,18)+resize(w2*steer,18)+resize(w3* signed(brake),18);
            sum <= acc;
            if (sum < to_signed(0,sum'length)) then
                score <= (others => '0');
            elsif (sum > to_signed(255,sum'length)) then
                score <= to_unsigned(255,8);
            else 
                score <= to_unsigned(to_integer(sum),8);
            end if;
        end if;
    end process;
end behavioral;
