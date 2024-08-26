library ieee;
use ieee.std_logic_1164.all;

library execute;

entity execute_stage is
    port(
        reg_write       : in std_logic;
        mem_to_reg      : in std_logic;
        mem_write       : in std_logic;
        alu_source      : in std_logic;
        reg_dest        : in std_logic;
        alu_control     : in std_logic_vector(3 downto 0);
        reg_source_a    : in std_logic_vector(31 downto 0);
        reg_source_b    : in std_logic_vector(31 downto 0);
        rt_dest         : in std_logic_vector(4 downto 0);
        rd_dest         : in std_logic_vector(4 downto 0);
        sign_imm        : in std_logic_vector(31 downto 0);
        reg_write_out   : out std_logic;
        mem_to_reg_out  : out std_logic;
        mem_write_out   : out std_logic;
        alu_result      : out std_logic_vector(31 downto 0); 
        write_data      : out std_logic_vector(31 downto 0);
        write_reg       : out std_logic_vector(4 downto 0)
    );
end execute_stage;

architecture behavioral of execute_stage is

    signal b_source_temp : std_logic_vector(31 downto 0);
begin
    alu_inst : entity execute.arithmetic_logic_unit
        generic map(NUM_BITS => 32)
        port map(
            a_value => reg_source_a,
            b_value => b_source_temp,
            op_code => alu_control,
            y_value => alu_result
        );
        
        
    b_source_temp_proc : process(alu_source, reg_source_b, sign_imm) is begin
        if alu_source = '1' then
            b_source_temp <= sign_imm;
        else
            b_source_temp <= reg_source_b;
        end if;
    end process;
    
    write_reg_proc : process(rt_dest, rd_dest, reg_dest) is begin
        if reg_dest = '1' then
            write_reg <= rd_dest;
        else
            write_reg <= rt_dest;
        end if;
    end process;
    
    write_data <= reg_source_b;
    reg_write_out <= reg_write;
    mem_to_reg_out <= mem_to_reg;
    mem_write_out <= mem_write;

end behavioral;
