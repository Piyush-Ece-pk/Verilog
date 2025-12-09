library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
port (
    clk,rst : in std_logic;
    rx : in std_logic;
    rx_done,parity_err : out std_logic;
    data_out : out std_logic_vector(7 downto 0) 
);
end uart_rx;

architecture behavioral of uart_rx is
constant clk_freq : integer := 1000000;
constant baudrate : integer := 9600;
constant bits_per_clk : integer := clk_freq/baudrate;
constant mid_sample : integer := bits_per_clk/2;

type state_type is(
    idle,
    start,
    data_bit,
    parity_bit,
    stop1,
    stop2,
    done
);

signal state : state_type := idle;
signal clk_count : integer := 0;
signal bit_index : integer := 0;
signal data : std_logic_vector(7 downto 0) := (others => '0');
signal parity : std_logic := '0';

begin
process (clk,rst) 
begin   
    if (rst = '0') then
        rx_done <= '0';
        data_out <= (others => '0');
        clk_count <= 0;
        bit_index <= 0;
        parity_err <= '0';
        state <= idle;
    elsif (rising_edge(clk)) then
        case state is
            when idle =>
                rx_done <= '0';
                if (rx = '0') then
                    clk_count <= 0;
                    state <= start;
                end if;
            when start =>
                clk_count <= clk_count+1;
                if (clk_count = mid_sample) then
                    if (rx = '0') then
                        clk_count <= 0;
                        bit_index <= 0;
                        state <= data_bit;
                    else
                        state <= idle;
                    end if;
                end if;
            when data_bit =>
                clk_count <= clk_count+1;
                if (clk_count = mid_sample) then
                    data(bit_index) <= rx ;
                end if;
                if (clk_count = bits_per_clk -1) then
                    clk_count <= 0;
                    if (bit_index = 7) then
                        state <= parity_bit;
                    else
                        bit_index <= bit_index+1;
                    end if;
                end if;
            when parity_bit =>
                clk_count <= clk_count+1;
                if (clk_count = mid_sample) then
                    parity <= rx;
                end if;
                if (clk_count = bits_per_clk-1) then
                    clk_count <= 0;
                    state <= stop1;
                end if;
            when stop1 =>
                clk_count <= clk_count+1;
                if (clk_count = bits_per_clk-1) then
                    clk_count <= 0;
                    state <= stop2;
                end if;
            when stop2 =>
                clk_count <= clk_count+1;
                if (clk_count = bits_per_clk-1) then
                    clk_count <= 0;
                    state <= done;
                end if;
            when done =>
                data_out <= data;
                rx_done <= '1';
                parity_err <= parity xor (data(0) xor data(1) xor data(2) xor data(3) xor
                                              data(4) xor data(5) xor data(6) xor data(7));
                state <= idle;
                clk_count <= 0;
        end case;
    end if;
end process;
end behavioral;







