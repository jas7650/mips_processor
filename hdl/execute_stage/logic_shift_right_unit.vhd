library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity logic_shift_right_unit is 
    generic (
        NUM_BITS : natural := 4
    );
    port (
        a_value         : in std_logic_vector(NUM_BITS-1 downto 0); 
        shift_amount : in std_logic_vector(NUM_BITS-1 downto 0);
        y_value         : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end logic_shift_right_unit;

architecture behavioral of logic_shift_right_unit is
    type shifty_array_type is array(NUM_BITS-1 downto 0) of std_logic_vector(NUM_BITS-1 downto 0);
    signal logic_shift_right_array : shifty_array_type;
begin
    generateSRL: for i in 0 to NUM_BITS-1 generate
        logic_shift_right_array(i)(NUM_BITS-i-1 downto 0) <= a_value(NUM_BITS-1 downto i);
        right_fill: if i > 0 generate
            logic_shift_right_array(i)(NUM_BITS-1 downto NUM_BITS-i) <= (others => '0');
        end generate right_fill;
    end generate generateSRL;
        
    y_value <= logic_shift_right_array(to_integer(unsigned(shift_amount(3 downto 0))));

end behavioral;