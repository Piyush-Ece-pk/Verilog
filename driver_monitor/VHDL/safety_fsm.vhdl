library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity safety_fsm is
port(
    clk,rst: in std_logic;
    avg_sc,warn_th,emer_th : in signed(7 downto 0);
    emergent,warning : out std_logic
);
end safety_fsm;

architecture behavioral of safety_fsm is
type state_t is(safe,warn,emer,latch);
signal state,next_state : state_t;
begin
process(clk,rst)
begin
    if (rst = '0') then
        state <= safe;
    else 
        state <= next_state;
    end if;
end process;

process (state,avg_sc,emer_th,warn_th) 
begin
    warning <= '0';
    emergent <= '0';
    next_state <= state;
    case state is 
        when safe =>
            if(avg_sc > warn_th) then
                next_state <= warn;
            end if;
        when warn =>
            warning <= '1';
            if (avg_sc > emer_th) then
                next_state <= emer;
            elsif ( avg_sc < warn_th) then
                next_state <= safe;
            end if;
        when emer =>
            emergent <= '1';
            next_state <= latch;
        when latch =>
            emergent <= '1';
    end case;
end process;
end behavioral;
