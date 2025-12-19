library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_slave is
    generic (
        slave_addr : std_logic_vector(6 downto 0) := "1000010"
    );
    port(
        clk,rst : in std_logic;
        sda : inout std_logic;
        scl : inout std_logic
    );
end i2c_slave;

architecture behavioral of i2c_slave is
type state_t is (
    idle,
    addr,
    addr_ack,
    reg_addr,
    reg_ack,
    write_data,
    write_ack,
    read_data,
    read_ack
);
signal state : state_t := idle;
signal sda_oe : std_logic := '0';
signal sda_in : std_logic ;
signal bit_count : integer range 0 to 7 := 7;
signal rx_shift : std_logic_vector( 7 downto 0) := (others => '0');
signal tx_shift : std_logic_vector(7 downto 0) := (others => '0');
signal rw : std_logic := '0';
signal reg_ptr : integer range 0 to 255 := 0;
type mem_t is array ( 0 to 255) of std_logic_vector(7 downto 0);
signal mem : mem_t := (others =>(others => '0'));
signal sda_d,scl_d : std_logic;

begin
sda <= '0' when sda_oe = '1' else 'Z';
sda_in <= sda;
process (clk)
begin 
    if rising_edge (clk) then
        sda_d <= sda;
        scl_d <= scl;
    end if;
end process;
process (clk,rst) 
begin
    if (rst = '0') then
        state <= idle;
        sda_oe <= '0';
        bit_count <= 7;
    
    elsif rising_edge(clk) then
        if (sda_d = '1' and sda = '0' and scl = '1') then
            state <= addr;
            bit_count <= 7;
        end if;
        if (sda_d = '0' and sda = '1' and scl = '1') then
            state <= idle;
            sda_oe <= '0';
        end if;
        case state is 
            when idle =>
                sda_oe <= '0';
            
            when addr =>
                if rising_edge(scl) then
                    rx_shift(bit_count) <= sda;
                    if bit_count = 0 then
                        rw <= sda;
                        state <= addr_ack;
                    else 
                        bit_count <= bit_count-1;
                    end if;
                end if;
            
            when addr_ack =>
                if rx_shift(7 downto 1) = slave_addr then
                    sda_oe <= '1';
                    bit_count <= 7;
                    if rw = '0' then
                        state <= reg_addr;
                    else
                        tx_shift <= mem(reg_ptr);
                        state <= read_data;
                    end if;
                else 
                    state <= idle;
                end if;
            
            when reg_addr =>
                if rising_edge(scl) then
                    rx_shift(bit_count) <= sda;
                    if bit_count = 0 then
                        reg_ptr <= to_integer(unsigned(rx_shift));
                        state <= reg_ack;
                    else 
                        bit_count <= bit_count-1;
                    end if;
                end if;
            
            when reg_ack =>
                sda_oe <= '1';
                bit_count <= 7;
                state <= write_data;

            when write_data =>
                if rising_edge(scl) then
                    rx_shift(bit_count) <= sda;
                    if bit_count = 0 then
                        mem(reg_ptr) <= rx_shift;
                        state <= write_ack;
                    else
                        bit_count <= bit_count-1;
                    end if;
                end if;
             
            when write_ack =>
                sda_oe <= '1';
                state <= idle;

            when read_data =>
                if rising_edge(scl) then
                    sda_oe <= not tx_shift(bit_count);
                    if bit_count = 0 then
                        state <= read_ack;
                    else
                        bit_count <= bit_count-1;
                    end if;
                end if;
            
            when read_ack =>
                sda_oe <= '0';
                state <= idle;
            
        end case;
    end if;
end process;
end behavioral;

 




