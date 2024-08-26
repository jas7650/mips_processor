library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_shift_left_unit is 
    generic (
        NUM_BITS : natural := 4
    );
    port (
        a_value         : in std_logic_vector(NUM_BITS-1 downto 0);
        shift_amount : in std_logic_vector(NUM_BITS-1 downto 0);
        y_value         : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end logic_shift_left_unit;

architecture behavioral of logic_shift_left_unit is
    type shifty_array_type is array(NUM_BITS-1 downto 0) of std_logic_vector(NUM_BITS-1 downto 0);
    signal logic_shift_left_array : shifty_array_type;
begin
    generateSLL: for i in 0 to NUM_BITS-1 generate
        logic_shift_left_array(i)(NUM_BITS-1 downto i) <= a_value(NUM_BITS-1-i downto 0);
        left_fill: if i > 0 generate
            logic_shift_left_array(i)(i-1 downto 0) <= (others => '0');
        end generate left_fill;
    end generate generateSLL;
        
    y_value <= logic_shift_left_array(to_integer(unsigned(shift_amount(3 downto 0))));

end behavioral;