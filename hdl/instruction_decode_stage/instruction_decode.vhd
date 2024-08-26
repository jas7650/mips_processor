library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_decode is
    port(
        clk             : in std_logic;
        instruction     : in std_logic_vector(31 downto 0);
        reg_write_addr  : in std_logic_vector(4 downto 0);
        reg_write_data  : in std_logic_vector(31 downto 0);
        reg_write_en    : in std_logic;
        reg_write       : out std_logic;
        mem_to_reg      : out std_logic;
        mem_write       : out std_logic;
        alu_control     : out std_logic_vector(3 downto 0);
        alu_source      : out std_logic;
        reg_dest        : out std_logic;
        rd1             : out std_logic_vector(31 downto 0);
        rd2             : out std_logic_vector(31 downto 0);
        rt_dest         : out std_logic_vector(4 downto 0); 
        rd_dest         : out std_logic_vector(4 downto 0);
        imm_out         : out std_logic_vector(31 downto 0)
    );  
end instruction_decode;

architecture behavioral of instruction_decode is

begin
    control_unit_inst : entity instruction_decode_stage.control_unit
        port map(
            op_code => instruction(31 downto 26),
            funct => instruction(5 downto 0),
            reg_write => reg_write,
            mem_to_reg => mem_to_reg,
            mem_write => mem_write,
            alu_control => alu_control,
            alu_source => alu_source,
            reg_dest => reg_dest
        );

    register_file_inst : entity instruction_decode_stage.register_file
        generic map(
            BIT_DEPTH => 32,
            LOG_PORT_DEPTH => 5
        )
        port map(
            clk_n => clk,
            write_en => reg_write_en,
            addr1 => instruction(25 downto 21),
            addr2 => instruction(20 downto 16),
            addr3 => reg_write_addr,
            write_data => reg_write_data,
            rd1 => rd1,
            rd2 => rd2
         );

    rt_dest <= instruction(20 downto 16);
    rd_dest <= instruction(15 downto 11);

    ImmOut_proc : process(instruction) is begin 
        if instruction(15) = '0' then
            imm_out <= x"0000" & instruction(15 downto 0);
        else
            imm_out <= x"FFFF" & instruction(15 downto 0);
        end if;
    end process;

end behavioral;
