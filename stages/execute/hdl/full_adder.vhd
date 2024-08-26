
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(
        a_value, b_value, c_in : in std_logic;
        sum, c_out : out std_logic
    );
end full_adder;

architecture behavioral of full_adder is

begin
    sum <= (a_value xor b_value) xor c_in;
    c_out <= (c_in and (a_value xor b_value)) or (a_value and b_value);
end behavioral;
