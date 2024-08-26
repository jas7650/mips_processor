library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library execute;

entity arithmetic_logic_unit is
    generic (
        NUM_BITS    : natural := 32
    );
    port(
        a_value     : in std_logic_vector(NUM_BITS-1 downto 0);
        b_value     : in std_logic_vector(NUM_BITS-1 downto 0);
        op_code     : in std_logic_vector(3 downto 0);
        y_value     : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end arithmetic_logic_unit;

architecture structural of arithmetic_logic_unit is

    signal sll_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal srl_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal sra_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal and_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal or_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal xor_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal add_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal sub_result : std_logic_vector(NUM_BITS-1 downto 0);
    signal mult_result : std_logic_vector(NUM_BITS-1 downto 0);

begin
    sll_comp: entity execute.logic_shift_left_unit
        generic map (NUM_BITS => NUM_BITS)
        port map (a_value => a_value, shift_amount => b_value, y_value => sll_result);

    srl_comp: entity execute.logic_shift_right_unit
        generic map (NUM_BITS => NUM_BITS)
        port map (a_value => a_value, shift_amount => b_value, y_value => srl_result);

    sra_comp: entity execute.arithmetic_shift_right_unit
        generic map (NUM_BITS => NUM_BITS)
        port map (a_value => a_value, shift_amount => b_value, y_value => sra_result);

    add_comp: entity execute.ripple_carry_full_adder
        generic map(NUM_BITS => NUM_BITS)
        port map (a_value => a_value, b_value => b_value, op_code => '0', sum => add_result);

    sub_comp: entity execute.ripple_carry_full_adder
        generic map(NUM_BITS => NUM_BITS)
        port map (a_value => a_value, b_value => b_value, op_code => '1', sum => sub_result);

    mult_comp : entity execute.multiplier
        generic map(NUM_BITS => NUM_BITS)
        port map (a_value => a_value(15 downto 0), b_value => b_value(15 downto 0), product => mult_result);

    and_result <= a_value and b_value;
    or_result <= a_value or b_value;
    xor_result <= a_value xor b_value;

    y_value <= or_result  when op_code = "1000" else
         and_result when op_code = "1010" else
         xor_result when op_code = "1011" else
         sll_result when op_code = "1100" else
         srl_result when op_code = "1101" else
         sra_result when op_code = "1110" else
         add_result when op_code = "0100" else
         sub_result when op_code = "0101" else
         mult_result when op_code = "0110" else
         (others => '0');

end structural;
