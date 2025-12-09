library IEEE;
use IEEE.std_logic_1164.all;

entity full_sub  is 
port (
        a,b,bin: in std_logic;
        diff,bo: out std_logic
);
end full_sub;

architecture behavioral of full_sub is
begin
diff <= a xor b xor bin;
bo <= ((not a) and b) or (((not a) or bin) and b); 
end behavioral;