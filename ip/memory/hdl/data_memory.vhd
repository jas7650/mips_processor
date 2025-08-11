library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is 
    generic(
        WIDTH           : natural := 32;
        ADDR_SPACE      : natural := 10
    );
    port(
        clk             : in std_logic;
        write_enable    : in std_logic;
        addr            : in std_logic_vector(ADDR_SPACE-1 downto 0);
        write_data      : in std_logic_vector(WIDTH-1 downto 0);
        rd              : out std_logic_vector(WIDTH-1 downto 0)
    );
end data_memory;

architecture oh_behave of data_memory is
    type mips_mem_type is array((2**ADDR_SPACE)-1 downto 0) of std_logic_vector(WIDTH-1 downto 0);
    signal mips_mem : mips_mem_type := (others => (others => '0'));
begin
    write_proc : process(clk) is begin
        if rising_edge(clk) then
            if write_enable = '1' then
                mips_mem(to_integer(unsigned(addr))) <= write_data;
            end if;
        end if;
    end process;

    rd_proc : process(addr) is begin
        if addr = "1111111110" then
            rd <= x"00000000"; 
        else
            rd <= mips_mem(to_integer(unsigned(addr)));
        end if;
    end process;
end oh_behave;