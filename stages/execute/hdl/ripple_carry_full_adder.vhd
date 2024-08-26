library ieee;
use ieee.std_logic_1164.all;

library execute;

entity ripple_carry_full_adder is
    generic(
        NUM_BITS            : natural := 32
    );
    port(
        a_value, b_value    : in std_logic_vector(NUM_BITS-1 downto 0);
        op_code             : in std_logic;
        sum                 : out std_logic_vector(NUM_BITS-1 downto 0)
    );
         
 end ripple_carry_full_adder;
 
 architecture structural of ripple_carry_full_adder is
     
     signal c_outs : std_logic_vector(NUM_BITS-1 downto 0);
     signal b_temp : std_logic_Vector(NUM_BITS-1 downto 0);
 begin
    full_adder_one: entity execute.full_adder
        port map(
            a_value => a_value(0), 
            b_value => b_temp(0), 
            c_in => op_code, 
            sum => sum(0), 
            c_out => c_outs(0)
        );
    generate_full_adders: for i in 1 to NUM_BITS-1 generate
        full_adder: entity execute.full_adder
            port map(
                a_value => a_value(i), 
                b_value => b_temp(i), 
                c_in => c_outs(i-1), 
                sum => sum(i), 
                c_out => c_outs(i)
            );
    end generate;
    
    generate_xors: for i in 0 to NUM_BITS-1 generate
        xors: entity execute.TwoInputXor
            port map(
                a_value => b_value(i),
                b_value => op_code,
                y_value => b_temp(i)
            );
     end generate;
end structural;