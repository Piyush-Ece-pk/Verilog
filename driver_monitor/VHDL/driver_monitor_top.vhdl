library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity  driver_monitor_top is
port(
    clk,rst : in std_logic;
    cfg_we :  in std_logic;
    cfg_addr : in std_logic_vector(3 downto 0);
    wght_data : in std_logic_vector(15 downto 0)
);
end driver_monitor_top;

architecture behavioral of driver_monitor_top is
signal steer,accel : signed(7 downto 0);
signal brake : unsigned(7 downto 0);
signal jerk :  signed(7 downto 0);
signal steer_rate : signed(7 downto 0);
signal brake_sc :  signed(15 downto 0);
signal w0,w1,w2,w3 :  signed(7 downto 0);
signal score :  unsigned(7 downto 0);
signal  avg :  signed(7 downto 0);
signal warn_th,emer_th :  signed(7 downto 0);
signal emergent,warning :  std_logic;
signal irq_ack :  std_logic := '0';
signal irq_mask :  std_logic_vector(1 downto 0) := "00";
signal irq :  std_logic_vector(1 downto 0);

begin  

sensor_uut : entity work.sensor port map(
    clk => clk,
    rst => rst,
    steer => steer,
    accel => accel,
    brake => brake
);

sensor_fusion_uut : entity work.sensor_fusion port map(
    clk => clk,
    rst => rst,
    steer => steer,
    accel => accel,
    brake => brake,
    steer_rate => steer_rate,
    jerk => jerk,
    brake_sc => brake_sc
);

ml_uut : entity work.ml_core port map (
    clk => clk,
    rst => rst,
    steer => steer,
    accel => accel,
    brake => brake,
    jerk => jerk,
    score => score,
    w0 => w0,
    w1 => w1,
    w2 => w2,
    w3 => w3
);

mean_uut : entity work.window_mean port map(
    clk => clk,
    rst => rst,
    score => score,
    avg => avg
);

saety_uut : entity work.safety_fsm port map(
    clk => clk,
    rst => rst,
    avg_sc => avg,
    warn_th => warn_th,
    emer_th => emer_th,
    emergent => emergent,
    warning => warning
);

prior_uut : entity work.priority port map(
    clk => clk,
    rst => rst,
    emergent => emergent,
    warning => warning,
    irq => irq,
    irq_ack => irq_ack,
    irq_mask => irq_mask
);

emer_uut : entity work.emergency port map(
    score => score,
    emergent => emergent,
    warning => warning
);

config_uut : entity work.config_reg port map(
    clk => clk,
    rst => rst,
    cfg_we => cfg_we,
    cfg_addr => cfg_addr,
    wght_data => wght_data,
    w0 => w0,
    w1 => w1,
    w2 => w2,
    w3 => w3,
    warn_th => warn_th,
    emer_th => emer_th
);

end behavioral;
