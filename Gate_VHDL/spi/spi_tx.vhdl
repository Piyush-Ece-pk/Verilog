library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_tx is
port(
    clk      : in std_logic;
    rst      : in std_logic;
    start    : in std_logic;
    data_in  : in std_logic_vector(7 downto 0);
    miso     : in std_logic;

    done     : out std_logic;
    data_out : out std_logic_vector(7 downto 0);
    mosi     : out std_logic;
    ss       : out std_logic;
    sck      : out std_logic
);
end spi_tx;

architecture behavioral of spi_tx is

type state_type is (idle, load, transfer, done_bit);
signal state : state_type := idle;

constant clk_div : integer := 4;

signal bit_count     : integer := 0;
signal shift_reg     : std_logic_vector(7 downto 0);
signal clk_div_count : integer := 0;

signal data_reg : std_logic_vector(7 downto 0);

signal ss_int   : std_logic := '1';
signal done_int : std_logic := '0';
signal mosi_int : std_logic := '0';
signal sck_int  : std_logic := '0';

begin

ss   <= ss_int;
done <= done_int;
mosi <= mosi_int;
sck  <= sck_int;
data_out <= data_reg;

process(clk, rst)
begin
    if (rst = '0') then
        state <= idle;
        bit_count <= 0;
        shift_reg <= (others => '0');
        clk_div_count <= 0;
        data_reg <= (others => '0');
        ss_int <= '1';
        done_int <= '0';
        mosi_int <= '0';
        sck_int <= '0';

    elsif rising_edge(clk) then

        case state is

            when idle =>
                sck_int <= '0';
                done_int <= '0';
                ss_int <= '1';  -- idle = HIGH

                if (start = '1') then
                    state <= load;
                end if;

            when load =>
                ss_int <= '0';  -- active = LOW
                clk_div_count <= 0;
                shift_reg <= data_in;
                bit_count <= 7;
                sck_int <= '0';
                state <= transfer;

            when transfer =>
                clk_div_count <= clk_div_count + 1;

                -- rising edge moment
                if clk_div_count = (clk_div/2)-1 then
                    sck_int <= '1';
                    mosi_int <= shift_reg(bit_count);
                end if;

                -- falling edge moment
                if clk_div_count = clk_div-1 then
                    sck_int <= '0';
                    clk_div_count <= 0;

                    data_reg(bit_count) <= miso;

                    if bit_count = 0 then
                        state <= done_bit;
                    else
                        bit_count <= bit_count - 1;
                    end if;
                end if;

            when done_bit =>
                ss_int <= '1';
                done_int <= '1';
                sck_int <= '0';
                state <= idle;

        end case;

    end if;
end process;

end behavioral;
