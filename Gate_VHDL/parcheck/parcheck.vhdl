library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parcheck is
    port(
        clk  : in  std_logic;
        rst  : in  std_logic;
        input_bits : in std_logic_vector(8 downto 0);
        even : out std_logic;
        odd  : out std_logic
    );
end parcheck;

architecture behavioral of parcheck is
    signal count : unsigned(3 downto 0); 
begin

process(clk, rst)
    variable temp_count : unsigned(3 downto 0); 
    begin
    if rst = '0' then
        count <= (others => '0');
        even  <= '0';
        odd   <= '0';

    elsif rising_edge(clk) then
        temp_count := (others => '0');

        for i in 0 to 8 loop
            if input_bits(i) = '1' then
                temp_count := temp_count + 1;
            end if;
        end loop;

        count <= temp_count;

        if (temp_count mod 2) = 0 then
            even <= '1';
            odd  <= '0';
        else
            even <= '0';
            odd  <= '1';
        end if;

    end if;
end process;

end behavioral;
