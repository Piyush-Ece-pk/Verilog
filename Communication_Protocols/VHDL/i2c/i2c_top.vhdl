library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity i2c_top is
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
    read_data : out std_logic_vector(7 downto 0)

);
end i2c_top;

architecture behavioral of i2c_top is
    signal sda: std_logic := 'H';
    signal scl : std_logic := 'H';

begin
    master_inst : entity work.i2c_master 
    generic map(
        i2c_freq => 100000,
        clk_freq => 50000000
        )
    port map(
        clk => clk,
        rst => rst,
        start => start,
        rw => rw,
        addr7 => addr7,
        reg_addr => reg_addr,
        data_in => data_in,
        busy => busy,
        done => done,
        ack_err => ack_err,
        read_data => read_data,
        sda => sda,
        scl => scl
    );

slave_inst : entity work.i2c_slave
generic map(
    slave_addr => "1000010"
)
port map(
    clk => clk,
    rst => rst,
    scl => scl,
    sda => sda
 );

end behavioral;
