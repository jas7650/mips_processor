library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity arithmetic_shift_right_unit is 
    generic (
        NUM_BITS        : natural := 4
    );
    port (
        a_value         : in std_logic_vector(NUM_BITS-1 downto 0);
        shift_amount    : in std_logic_vector(NUM_BITS-1 downto 0);
        y_value         : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end arithmetic_shift_right_unit;

architecture behavioral of arithmetic_shift_right_unit is
    type shifty_array_type is array(NUM_BITS-1 downto 0) of std_logic_vector(NUM_BITS-1 downto 0);
    signal arithmetic_shift_right_array : shifty_array_type;
begin

    generate_arithmetic_shift_right_array: for i in 1 to NUM_BITS-1 generate
        arithmetic_shift_right_array(i)(NUM_BITS-1-i downto 0) <= a_value(NUM_BITS-1 downto i);
        arithmetic_shift_right_array(i)(NUM_BITS-1 downto NUM_BITS-i) <= a_value(i-1 downto 0);
    end generate generate_arithmetic_shift_right_array;

    arithmetic_shift_right_array(0) (NUM_BITS-1 downto 0) <= a_value;
    y_value <= arithmetic_shift_right_array(to_integer(unsigned(shift_amount(3 downto 0))));

end behavioral;