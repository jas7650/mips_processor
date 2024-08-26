library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
    generic (
        BIT_DEPTH       : natural := 8; 
        LOG_PORT_DEPTH  : natural := 3
    );
    port (
        clk_n           : in std_logic; --falling edge triggered
        write_en        : in std_logic; --Register contents can be written when active
        addr1           : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --Addresses of registers to read from
        addr2           : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --Addresses of registers to read from
        addr3           : in std_logic_vector(LOG_PORT_DEPTH-1 downto 0); --Addresses of registers to read from
        write_data      : in std_logic_vector(BIT_DEPTH-1 downto 0); --Data to be written to destination register
        rd1             : out std_logic_vector(BIT_DEPTH-1 downto 0) --Parallel outputs containing the data from the selected registers
        rd2             : out std_logic_vector(BIT_DEPTH-1 downto 0) --Parallel outputs containing the data from the selected registers
    );
end register_file;

architecture behavioral of register_file is
    type reg_data_type is array((2**LOG_PORT_DEPTH)-1 downto 0) of std_logic_vector(BIT_DEPTH-1 downto 0);
    signal reg_data : reg_data_type := (others => (others => '0'));
begin

rd1 <= reg_data(to_integer(unsigned(addr1)));
rd2 <= reg_data(to_integer(unsigned(addr2)));

write_proc : process(clk_n)
begin
    if falling_edge(clk_n) then
        if write_en = '1' then
            if to_integer(unsigned(addr3)) /= 0 then
                reg_data(to_integer(unsigned(addr3))) <= write_data;
            end if;
        end if;
    end if;
end process;

end behavioral;
