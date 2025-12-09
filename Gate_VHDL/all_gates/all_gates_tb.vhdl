library ieee;
use ieee.std_logic_1164.all;
entity all_gates_tb is
end all_gates_tb;
architecture behavioral of all_gates_tb is
signal a,b,
       o_and,o_or,o_not,o_exor,o_exnor,o_nand,o_nor:std_logic;    
begin
uut: entity work.all_gates
port map(
    a=>a,
    b=>b,
    o_and=>o_and,
    o_or=>o_or,
    o_not=>o_not,
    o_exor=>o_exor,
    o_exnor=>o_exnor,
    o_nand=>o_nand,
    o_nor=>o_nor
    );
stim:
process begin
a<='0';b<='0'; wait for 10 ns;
a<='0';b<='1'; wait for  10 ns;
a<='1';b<='0'; wait for 10 ns;
a<='1'; b<='1'; wait for  10 ns;
end process;
end behavioral;

