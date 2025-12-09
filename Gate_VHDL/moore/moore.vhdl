library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity moore is
port(
    clk,rst,x : in std_logic;
    z : out std_logic
);
end moore;

architecture behavioral of moore is
type type_state is (a,b,c,d);
signal curr_s,next_s : type_state;
begin
process (clk,rst)
begin
    if (rst='0') then
        z <= '0';
        curr_s <= a; 
    elsif(clk'event and clk='1') then
        curr_s <= next_s;
    end if;
end process;

process (curr_s,x) 
begin
    case curr_s is 
        when a => 
            z <= '0';
            if (x='1') then
                next_s <= b;
            end if;
        when b =>
            z <= '0';
            if (x='1') then
                next_s <= c;
            end if;
        when c =>
            z <= '0';
            if (x='1') then
                next_s <= d;
            end if;
        when d =>
            z <= '1';
            if (x='0') then
                next_s <= a;
            else
                next_s <= b;
            end if;
    end case;
end process;
end behavioral;

    
