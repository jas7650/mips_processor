library ieee;
use ieee.std_logic_1164.all;

entity TwoInputXor is
    port(a_value, b_value : in std_logic;
         y_value : out std_logic);
end TwoInputXor;

architecture behavioral of TwoInputXor is   
begin
    y_value <= a_value xor b_value;
end behavioral;
