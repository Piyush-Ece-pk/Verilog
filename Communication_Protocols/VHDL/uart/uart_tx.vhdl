library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
port(
    clk,rst : in std_logic;
    tx,tx_done: out std_logic;
    tx_start : in std_logic;
    data_in : in std_logic_vector(7 downto 0)
);
end uart_tx;

architecture behavioral of uart_tx is
constant clk_freq : integer := 1000000;
constant baudrate : integer := 9600;
constant bits_per_clk : integer := clk_freq/baudrate;

type state_type is(
    idle,
    start,
    data_bit,
    parity_bit,
    stop1,
    stop2,
    done
);

signal clk_count : integer :=0;
signal bit_index : integer := 0;
signal state : state_type := idle;
signal data : std_logic_vector(7 downto 0) := (others=>'0');
signal parity : std_logic := '0';
signal tx_reg : std_logic := '1';

begin
    tx <= tx_reg;
    process (clk,rst)
    begin   
        if (rst = '0') then
            clk_count <= 0;
            bit_index <= 0;
            data <= (others => '0');
            parity <= '0';
            tx_reg <= '1';
            state <= idle;
        elsif (rising_edge(clk)) then
            case state is 
                when idle => 
                    tx_done <= '0';
                    tx_reg <= '1';
                    if (tx_start='1') then
                        data <= data_in;
                        clk_count <= 0;
                        bit_index <= 0;
                        state <= start;
                    end if;
                when start =>
                    tx_reg <= '0';
                    if (clk_count = bits_per_clk-1) then
                        clk_count <= 0;
                        state <= data_bit;
                    else
                        clk_count <= clk_count+1;
                    end if;
                when data_bit =>
                    tx_reg <= data(bit_index);
                    if (clk_count = bits_per_clk-1) then
                        clk_count <= 0;
                        if (bit_index = 7) then
                            state <= parity_bit;
                        else 
                            bit_index <= bit_index+1;
                        end if;
                    else 
                        clk_count <= clk_count+1;
                    end if;
                when parity_bit =>
                    parity <= data(0) xor data(1) xor data(2) xor
                              data(3) xor data(4) xor data(5) xor
                              data(6) xor data(7);
                    tx_reg <= parity;
                    if (clk_count = bits_per_clk-1) then
                        clk_count <= 0;
                        state <= stop1;
                    else 
                        clk_count <= clk_count+1;
                    end if;
                when stop1 => 
                    tx_reg <= '1';
                    if (clk_count = bits_per_clk-1) then
                        clk_count <= 0;
                        state <= stop2;
                    else
                        clk_count <= clk_count+1;
                    end if;
                when stop2 =>
                    tx_reg <= '1';
                    if (clk_count = bits_per_clk-1) then
                        clk_count <= 0;
                        state <= done;
                    else 
                        clk_count <= clk_count+1;
                    end if;
                when done =>
                    tx_reg <= '1';
                    tx_done <= '1';
                    state <= idle;
                    clk_count <= 0;
            end case;
        end if;
    end process;
end behavioral;

            


