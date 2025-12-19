library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_master is 
    generic(
        clk_freq : integer := 50000000;
        i2c_freq : integer := 100000
    );
    port(
        clk,rst : in std_logic;
        start : in std_logic;
        rw : in std_logic;
        addr7 : in std_logic_vector(6 downto 0);
        reg_addr : in std_logic_vector(7 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        busy : out std_logic;
        ack_err : out std_logic;
        done : out std_logic;
        read_data : out std_logic_vector(7 downto 0);
        sda : inout std_logic;
        scl : inout std_logic
    );
end i2c_master;

architecture behavioral of i2c_master is
    constant clk_per_half : integer := clk_freq/(i2c_freq*2);
    
    type state_t is(
        idle,start_bit,
        send_addr,ack1,
        send_reg, ack2,
        send_data, ack3,
        stop_bit, done_bit
    );

    signal state : state_t := idle;
    signal half_cnt : integer range 0 to clk_per_half := 0;
    signal scl_tick : std_logic := '0';
    signal phase : std_logic := '0';

    signal sda_oe : std_logic := '0';
    signal scl_oe : std_logic := '0';

    signal tx_shift : std_logic_vector(7 downto 0);
    signal bit_count : integer range 0 to 7 := 7 ;
    signal sda_in : std_logic;
    signal scl_in : std_logic;
    begin
    sda <= '0' when sda_oe = '1' else 'Z';
    scl <= '0' when scl_oe = '1' else 'Z';

    sda_in <= sda;
    scl_in <= scl;

    process(clk,rst)
    begin
        if (rst = '0') then
            half_cnt <= 0;
            scl_tick <= '0';
            phase <= '0';
        elsif rising_edge(clk) then
            if half_cnt = clk_per_half-1 then
                half_cnt <= 0;
                scl_tick <= '1';
                phase <= not phase;
            else
                half_cnt <= half_cnt+1;
                scl_tick <= '0';
            end if;
        end if;
    end process;

    process (clk,rst)
    begin
        if rst = '0' then
            state <= idle;
            busy <= '0';
            ack_err <= '0';
            done <= '0';
            sda_oe <= '0';
            scl_oe <= '0';
            bit_count <= 7;
            read_data <= (others => '0');
        elsif rising_edge(clk) then
            done <= '0';
            case state is 
                when idle =>
                    busy <= '0';
                    ack_err <= '0';
                    if (start='1') then
                        busy <= '1';
                        state <= start_bit;
                    end if;
                
                when start_bit =>
                    scl_oe <= '0';
                    if (phase = '0') then
                        sda_oe <= '1';
                    end if;
                    if (scl_tick = '1' and phase = '1') then
                        scl_oe <= '1';
                        tx_shift <= addr7 & rw;
                        bit_count <= 7;
                        state <= send_addr;
                    end if;

                when send_addr =>
                    if scl_tick = '1' and phase = '0' then
                        sda_oe <= not tx_shift(bit_count);
                        scl_oe <= '0';
                    elsif scl_tick = '1' and phase = '1' then
                        scl_oe <= '1';
                        if bit_count = 0 then
                            sda_oe <= '0';
                            state <= ack1;
                        else
                            bit_count <= bit_count-1;
                        end if;
                    end if;

                when ack1 =>
                    if scl_tick = '1' and phase = '1' then
                        if sda_in = '1' then
                            ack_err <= '1';
                        end if;
                        tx_shift <= reg_addr;
                        bit_count <= 7;
                        state <= send_reg;
                    end if;
                
                when send_reg =>
                    if scl_tick = '1' and phase = '0' then
                        sda_oe <= not tx_shift(bit_count);
                        scl_oe <= '0';
                    elsif scl_tick = '1' and phase = '1' then
                        scl_oe <= '1';
                        if bit_count = 0 then
                            sda_oe <= '0';
                            state <= ack2;
                        else
                            bit_count <= bit_count-1;
                        end if;
                    end if;
                
                when ack2 =>
                    if scl_tick = '1' and phase = '1' then
                        if sda_in = '1' then
                            ack_err <= '1';
                        end if;
                        tx_shift <= data_in;
                        bit_count <= 7;
                        state <=send_data;
                    end if;

                when send_data =>
                    if scl_tick = '1' and phase = '0' then
                        sda_oe <= not tx_shift(bit_count);
                        scl_oe <= '0';
                    elsif scl_tick = '1' and phase = '1' then
                        scl_oe <= '1';
                        if bit_count = 0 then
                            sda_oe <= '0'; 
                            state <= ack3;
                        else
                            bit_count <= bit_count-1;
                        end if;
                    end if;

                when ack3 =>
                    if scl_tick='1' and phase = '1' then
                        if sda_in = '1' then
                            ack_err <= '1';
                        end if;
                        state <= stop_bit;
                    end if;

                when done_bit =>
                    busy <= '0';
                    done <= '1';
                    state <= idle;
                when stop_bit =>
                    if scl_tick = '1' and phase = '0' then
                        scl_oe <= '0';  -- release SCL
                        sda_oe <= '1';  -- keep SDA low
                    elsif scl_tick = '1' and phase = '1' then
                        sda_oe <= '0';  -- SDA goes high while SCL high = STOP
                        state <= done_bit;
                    end if;
            end case;
        end if;
    end process;
    
end behavioral;
