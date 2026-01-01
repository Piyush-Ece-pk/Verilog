library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sensor_fusion is 
port(
    clk,rst : in std_logic;
    accel : in signed(7 downto 0);
    steer : in signed(7 downto 0);
    brake : in unsigned(7 downto 0);
    jerk : out signed(7 downto 0);
    steer_rate : out signed(7 downto 0);
    brake_sc : out signed(15 downto 0)
);
end sensor_fusion;

architecture behavioral of sensor_fusion is
signal accel_prev : signed(7 downto 0);
signal steer_prev : signed(7 downto 0);
begin
    process (clk,rst) 
    begin
        if (rst = '0') then
            jerk <= (others=>'0');
            steer_rate <= (others => '0');
            brake_sc <= (others=> '0');
        elsif (rising_edge(clk)) then
            jerk <= accel-accel_prev;
            steer_rate <= steer-steer_prev;
            brake_sc <= signed(brake)*accel;
            accel_prev <= accel;
            steer_prev <= steer;
        end if;
    end process;
end behavioral;

