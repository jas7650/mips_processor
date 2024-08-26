library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is
    port(
        op_code         : in std_logic_vector(5 downto 0);
        funct           : in std_logic_vector(5 downto 0);
        reg_write       : out std_logic;
        mem_to_reg      : out std_logic;
        mem_write       : out std_logic;
        alu_control     : out std_logic_vector(3 downto 0);
        alu_source      : out std_logic;
        reg_dest        : out std_logic
    );
end control_unit;

architecture behavioral of control_unit is
begin
    reg_write <= '0' when op_code = "101011" else
                '1';

    mem_to_reg <= '1' when op_code = "100011" else
                '0';

    mem_write <= '1' when op_code = "101011" else
                '0';

    alu_control_proc : process(op_code, funct) is begin
        if op_code = "000000" then
            case funct is
                when "100000" => alu_control <= "0100"; --ADD
                when "100100" => alu_control <= "1010"; --AND
                when "011001" => alu_control <= "0110"; --MULTU
                when "100101" => alu_control <= "1000"; --OR
                when "000000" => alu_control <= "1100"; --SLL
                when "000011" => alu_control <= "1110"; --SRA
                when "000010" => alu_control <= "1101"; --SRL
                when "100010" => alu_control <= "0101"; --SUB
                when "100110" => alu_control <= "1011"; --XOR
                when others   => alu_control <= "0000";
            end case;
        else 
            case op_code is
                when "001000" | "101011" | "100011" => alu_control <= "0100"; --ADDI, SW, LW 
                when "001100" => alu_control <= "1010"; --ANDI
                when "001101" => alu_control <= "1000"; --ORI
                when "001110" => alu_control <= "1011"; --XORI
                when others   => alu_control <= "0000";
            end case;
        end if;
    end process;


    alu_source <= '0' when op_code = "000000" else
              '1';

    reg_dest <= '1' when op_code = "000000" else
              '0';


end behavioral;
