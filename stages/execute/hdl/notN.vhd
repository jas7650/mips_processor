library ieee;
use ieee.std_logic_1164.all;

entity notN is
    generic (
        NUM_BITS: natural := 4
    );
    port (
        a_value : in std_logic_vector(NUM_BITS-1 downto 0);
        y_value : out std_logic_vector(NUM_BITS-1 downto 0)
    );
end notN;

architecture dataflow of notN is 
begin
    y_value <= not a_value;
end dataflow;