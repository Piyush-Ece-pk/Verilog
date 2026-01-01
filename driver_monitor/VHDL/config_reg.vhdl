library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity config_reg is
port(
    clk,rst : in std_logic;
    cfg_we : in std_logic;
    cfg_addr : in std_logic_vector(3 downto 0);
    wght_data : in std_logic_vector(15 downto 0);
    w0,w1,w2,w3 : out signed(7 downto 0);
    warn_th : out signed(7 downto 0);
    emer_th : out signed(7 downto 0)
);
end config_reg;

architecture behavioral of config_reg is
begin
    process(clk,rst) 
    begin
        if (rst = '0') then
            w0 <= to_signed(4,8);
            w1 <= to_signed(4,8);
            w2 <= to_signed(4,8);
            w3 <= to_signed(4,8);
            warn_th <= to_signed(110,8);
            emer_th <= to_signed(180,8);
        elsif (rising_edge(clk)) then
            if (cfg_we = '1') then
                case cfg_addr is
                    when "0000" =>
                        w0 <= signed(wght_data(7 downto 0));
                    when "0001" =>
                        w1 <= signed(wght_data(7 downto 0));
                    when "0010" =>
                        w2 <= signed(wght_data(7 downto 0));
                    when "0011" =>
                        w3 <= signed(wght_data(7 downto 0));
                    when "0100" =>
                        warn_th <= signed(wght_data(7 downto 0));
                    when "0101" => 
                        emer_th <= signed(wght_data(7 downto 0));
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process;
end behavioral;

                     
