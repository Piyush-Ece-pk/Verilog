library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity priority is 
port(
    clk,rst: in std_logic;
    emergent,warning : in std_logic;
    irq_ack : in std_logic;
    irq_mask : in std_logic_vector(1 downto 0);
    irq : out std_logic_vector(1 downto 0)
);
end priority;

architecture behavioral of priority is
signal emer_det : std_logic;
begin
process (clk,rst) 
begin
    if (rst = '0') then
        irq <= (others => '0');
    elsif (irq_ack = '1') then
        irq <= "00";
    elsif (rising_edge(clk)) then
        if  (emergent = '1') and (irq_mask(1) = '0') and (emer_det = '0') then  
            irq <= "10";
        elsif (warning = '1' and (irq_mask(0)='0')) then
            irq <= "01";
        end if;
    end if;

end process;
end behavioral;



        