
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity instruction_memory is
    generic (
        MEM_SIZE : natural := 2048
    );
    port (
        addr  : in std_logic_vector(27 downto 0);
        d_out : out std_logic_vector(31 downto 0)
    );
end instruction_memory;

architecture behavioral of instruction_memory is
    type mem_type is array(0 to MEM_SIZE-1) of std_logic_vector(7 downto 0);
    signal mem : mem_type := (x"21", x"08", x"00", x"00", --addi t0 t0 0
                              x"21", x"29", x"00", x"01", --addi t1 t1 1
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"28", x"50", x"20", --add t2 t1 t0
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"49", x"58", x"20", --add t3 t2 t1
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"6a", x"60", x"20", --add t4 t3 t2
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"8b", x"68", x"20", --add t5 t4 t3
                              x"21", x"28", x"00", x"00",
                              x"8d", x"8b", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"ac", x"70", x"20", --add t6 t5 t4
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"cd", x"78", x"20", --add t7 t6 t5
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"01", x"ee", x"80", x"20", --add s0 t7 t6
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"02", x"0f", x"88", x"20", --add s1 s0 t7
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"00", x"00", x"00", x"00",
                              x"02", x"30", x"90", x"20", --add s2 s1 s0
                              others => (others => '0'));
begin
    process(addr) is 
    begin     
        if addr(27 downto 8) = std_logic_vector(to_unsigned(0,20)) then
            d_out <= mem(to_integer(unsigned(addr(7 downto 0)))) &
                     mem(to_integer(unsigned(addr(7 downto 0)))+1) &
                     mem(to_integer(unsigned(addr(7 downto 0)))+2) &
                     mem(to_integer(unsigned(addr(7 downto 0)))+3);
        else
            d_out <= (others => '0');
        end if;

    end process;

end behavioral;
