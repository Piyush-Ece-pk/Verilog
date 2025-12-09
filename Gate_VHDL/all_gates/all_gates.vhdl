library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity all_gates is
port(
    a,b:in std_logic;
    o_and,o_or,o_not,o_exor,o_exnor,o_nand,o_nor:out std_logic
    );
end all_gates;
architecture behavioral of all_gates is
begin
o_and <= a and b;
o_or <= a or b;
o_not <= not a;
o_exor <= a xor b;
o_exnor <= a xnor b;
o_nand <= a nand b;
o_nor <= a nor b;
end behavioral;
