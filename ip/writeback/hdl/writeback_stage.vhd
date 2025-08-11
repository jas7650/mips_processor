library ieee;
use ieee.std_logic_1164.all;

entity writeback_stage is
    port(
        reg_write       : in std_logic; 
        mem_to_reg      : in std_logic;
        alu_result      : in std_logic_vector(31 downto 0);
        read_data       : in std_logic_vector(31 downto 0);
        write_reg       : in std_logic_vector(4 downto 0);
        reg_write_out   : out std_logic;
        write_reg_out   : out std_logic_vector(4 downto 0);
        result          : out std_logic_vector(31 downto 0)
    );
end writeback_stage;

architecture behavioral of writeback_stage is

begin
    result_proc : process(read_data, mem_to_reg, alu_result) is begin
        if mem_to_reg = '1' then
            result <= read_data;
        else
            result <= alu_result;
        end if;
    end process;

    write_reg_out <= write_reg;
    reg_write_out <= reg_write;

end behavioral;
