library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

library instruction_fetch;

entity instruction_fetch_stage is
    port(
        clk             : in std_logic;
        rst             : in std_logic;
        instruction     : out std_logic_vector(31 downto 0)
    );
end instruction_fetch_stage;

architecture behavioral of instruction_fetch_stage is
    signal pc : std_logic_vector(27 downto 0) := (others => '0');
begin

    instruction_memory_inst : entity instruction_fetch.instruction_memory
        generic map(MEM_SIZE => 2048)
        port map(
            addr => pc,
            d_out => instruction
        );

    pc_proc : process(clk, rst) is begin
        if rst = '1' then 
            pc <= (others => '0');
        else 
            if rising_edge(clk) then
                pc <= std_logic_vector(to_unsigned(to_integer(unsigned(pc)) + 4, 28));
            end if;
        end if;
    end process;

end behavioral;
