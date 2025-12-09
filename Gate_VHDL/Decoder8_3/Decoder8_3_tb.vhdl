library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder8_3_tb is
end Decoder8_3_tb;

architecture behavioral of Decoder8_3_tb is
signal a : std_logic_vector(7 downto 0);
signal s : std_logic_vector(2 downto 0);
begin
uut: entity work.Decoder8_3 port map(
    a => a,
    s => s
);

stim: 
process begin
s <= "001"; wait for 10 ns;
s <= "010"; wait for 10 ns;
s <= "011"; wait for 10 ns;
s <= "111"; wait for  10 ns;
wait;
end process;
end behavioral;
