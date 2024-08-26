library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity multiplier is
    generic(
        NUM_BITS : natural := 32
    );
    port(
        a_value, b_value : in std_logic_vector((NUM_BITS/2)-1 downto 0);
        product : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end multiplier;

architecture behavioral of multiplier is
    type product_array is array((NUM_BITS/2)-1 downto 0) of std_logic_vector(NUM_BITS-1 downto 0);
    type sum_array is array(NUM_BITS/2 downto 0) of std_logic_vector(NUM_BITS-1 downto 0);
    signal products : product_array := (others => (others => '0'));
    signal sum : sum_array := (others => (others => '0'));

begin
    IG: for i in 0 to (NUM_BITS/2)-1 generate
        JG: for j in 0 to (NUM_BITS/2)-1 generate
            products(i)(i + j) <= a_value(j) and b_value(i);
        end generate;
    end generate;
    
    accumulate: for i in 0 to (NUM_BITS/2)-1 generate
        adder_inst : entity execute_stage.ripple_carry_full_adder
            port map(
                a_value => products(i),
                b_value => sum(i),
                op_code => '0',
                sum => sum(i+1)
            );
    end generate;

    product <= sum(NUM_BITS/2);

end behavioral;
