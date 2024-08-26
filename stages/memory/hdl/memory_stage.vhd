library ieee;
use ieee.std_logic_1164.all;

library memory;

entity memory_stage is
    generic(
        WIDTH               : natural := 32;
        ADDR_SPACE          : natural := 10
    );
    port(
        clk                 : in std_logic;
        reg_write           : in std_logic;
        mem_to_reg          : in std_logic;
        mem_write           : in std_logic;
        write_reg           : in std_logic_vector(4 downto 0);
        alu_result          : in std_logic_vector(31 downto 0);
        write_data          : in std_logic_vector(31 downto 0);
        reg_write_out       : out std_logic;
        mem_to_reg_out      : out std_logic;
        write_reg_out       : out std_logic_vector(4 downto 0);
        mem_out             : out std_logic_vector(31 downto 0);
        alu_result_out      : out std_logic_vector(31 downto 0)
    );
end memory_stage;

architecture behavioral of memory_stage is
begin
    mem_inst : entity memory.data_memory
        generic map(
            WIDTH => WIDTH,
            ADDR_SPACE => ADDR_SPACE
        )
        port map(
            clk => clk,
            write_enable => mem_write,
            addr => alu_result(ADDR_SPACE-1 downto 0),
            write_data => write_data,
            rd => mem_out
        );

    reg_write_out <= reg_write;
    mem_to_reg_out <= mem_to_reg;
    write_reg_out <= write_reg;
    alu_result_out <= alu_result;

end behavioral;
