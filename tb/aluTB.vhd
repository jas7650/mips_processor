----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2021 08:52:40 AM
-- Design Name: 
-- Module Name: aluTB - behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity aluTB is
end aluTB;

architecture behavioral of aluTB is
    Component alu32 is
        port (
            a_value     : in std_logic_vector(31 downto 0);
            b_value     : in std_logic_vector(31 downto 0);
            op_code    : in std_logic_vector(3 downto 0);
            y_value     : out std_logic_vector(31 downto 0)
        );
    end Component;
    
type test_vector is record
	a_value : std_logic_vector(31 downto 0);
	b_value : std_logic_vector(31 downto 0);
	y_value : std_logic_vector(31 downto 0);
end record;

type test_array is array (natural range <>) of test_vector;
constant or_array : test_array := (
	(a_value => x"00000000", b_value => x"00000001", y_value => x"00000001"),
	(a_value => x"00000000", b_value => x"00000002", y_value => x"00000002"),
	(a_value => x"00000000", b_value => x"00000003", y_value => x"00000003"),
	(a_value => x"00000000", b_value => x"00000004", y_value => x"00000004"),
	(a_value => x"00000000", b_value => x"00000005", y_value => x"00000005"),
	(a_value => x"00000000", b_value => x"00000000", y_value => x"00000000"),
	(a_value => x"00000000", b_value => x"0000000f", y_value => x"0000000f"),
	(a_value => x"0000000a", b_value => x"00000005", y_value => x"0000000f"),
	(a_value => x"00000005", b_value => x"0000000a", y_value => x"0000000f")
);

constant and_array : test_array := (
	(a_value => x"ffffffff", b_value => x"00000001", y_value => x"00000001"),
	(a_value => x"ffffffff", b_value => x"00000002", y_value => x"00000002"),
	(a_value => x"ffffffff", b_value => x"00000003", y_value => x"00000003"),
	(a_value => x"ffffffff", b_value => x"00000004", y_value => x"00000004"),
	(a_value => x"ffffffff", b_value => x"00000005", y_value => x"00000005"),
	(a_value => x"00000000", b_value => x"00000000", y_value => x"00000000"),
	(a_value => x"00000000", b_value => x"0000000f", y_value => x"00000000"),
	(a_value => x"0000000f", b_value => x"00000000", y_value => x"00000000"),
	(a_value => x"0000000f", b_value => x"0000000f", y_value => x"0000000f")
);

constant xor_array : test_array := (
	(a_value => x"00000000", b_value => x"00000001", y_value => x"00000001"),
	(a_value => x"00000000", b_value => x"00000002", y_value => x"00000002"),
	(a_value => x"00000000", b_value => x"00000003", y_value => x"00000003"),
	(a_value => x"00000000", b_value => x"00000004", y_value => x"00000004"),
	(a_value => x"00000000", b_value => x"00000005", y_value => x"00000005"),
	(a_value => x"00000000", b_value => x"00000000", y_value => x"00000000"),
	(a_value => x"00000000", b_value => x"0000000f", y_value => x"0000000f"),
	(a_value => x"0000000f", b_value => x"00000000", y_value => x"0000000f"),
	(a_value => x"0000000f", b_value => x"0000000f", y_value => x"00000000"),
	(a_value => x"0000000a", b_value => x"00000005", y_value => x"0000000f"),
	(a_value => x"00000005", b_value => x"0000000a", y_value => x"0000000f")
);

constant sll_array : test_array := (
	(a_value => x"00000001", b_value => x"00000000", y_value => x"00000001"),
	(a_value => x"00000001", b_value => x"00000001", y_value => x"00000002"),
	(a_value => x"00000001", b_value => x"00000002", y_value => x"00000004"),
	(a_value => x"00000001", b_value => x"00000003", y_value => x"00000008"),
	(a_value => x"00000001", b_value => x"00000004", y_value => x"00000010")
);

constant srl_array : test_array := (
	(a_value => x"00000008", b_value => x"00000000", y_value => x"00000008"),
	(a_value => x"00000008", b_value => x"00000001", y_value => x"00000004"),
	(a_value => x"00000008", b_value => x"00000002", y_value => x"00000002"),
	(a_value => x"00000008", b_value => x"00000003", y_value => x"00000001"),
	(a_value => x"00000008", b_value => x"00000004", y_value => x"00000000"),
	(a_value => x"00000006", b_value => x"00000002", y_value => x"00000001")
);

constant sra_array : test_array := (
	(a_value => x"00000008", b_value => x"00000000", y_value => x"00000008"),
	(a_value => x"00000008", b_value => x"00000001", y_value => x"00000004"),
	(a_value => x"00000008", b_value => x"00000002", y_value => x"00000002"),
	(a_value => x"00000008", b_value => x"00000003", y_value => x"00000001"),
	(a_value => x"00000008", b_value => x"00000004", y_value => x"80000000"),
	(a_value => x"00000006", b_value => x"00000001", y_value => x"00000003"),
	(a_value => x"00000006", b_value => x"00000002", y_value => x"80000001"),
	(a_value => x"f0000000", b_value => x"00000001", y_value => x"78000000")
);

constant add_array : test_array := (
	(a_value => x"00000001", b_value => x"00000000", y_value => x"00000001"),
	(a_value => x"00000000", b_value => x"00000001", y_value => x"00000001"),
	(a_value => x"00000001", b_value => x"00000001", y_value => x"00000002"),
	(a_value => x"80000000", b_value => x"80000000", y_value => x"00000000"),
	(a_value => x"80000000", b_value => x"00000000", y_value => x"80000000")
);

constant sub_array : test_array := (
	(a_value => x"00000001", b_value => x"00000000", y_value => x"00000001"),
	(a_value => x"00000000", b_value => x"00000001", y_value => x"ffffffff"),
	(a_value => x"00000001", b_value => x"00000001", y_value => x"00000000"),
	(a_value => x"80000000", b_value => x"80000000", y_value => x"00000000"),
	(a_value => x"f0000000", b_value => x"10000000", y_value => x"e0000000")
);

constant mult_array : test_array := (
	(a_value => x"00000001", b_value => x"00000000", y_value => x"00000000"),
	(a_value => x"00000000", b_value => x"00000001", y_value => x"00000000"),
	(a_value => x"00000001", b_value => x"00000001", y_value => x"00000001"),
	(a_value => x"00000002", b_value => x"00000002", y_value => x"00000004"),
	(a_value => x"00008000", b_value => x"00008000", y_value => x"40000000")
);
    
    constant delay : time := 60 ns;
    signal OR_A, AND_A, XOR_A, SLL_A, SRL_A, SRA_A, ADD_A, SUB_A, MULT_A : std_logic_vector(31 downto 0) := (others => '0');
    signal OR_B, AND_B, XOR_B, SLL_B, SRL_B, SRA_B, ADD_B, SUB_B, MULT_B : std_logic_vector(31 downto 0) := (others => '0');
    signal OR_Y, AND_Y, XOR_Y, SLL_Y, SRL_Y, SRA_Y, ADD_Y, SUB_Y, MULT_Y : std_logic_vector(31 downto 0) := (others => '0');
    signal OR_OP       : std_logic_vector(3 downto 0) := "1000";
    signal AND_OP      : std_logic_vector(3 downto 0) := "1010";
    signal XOR_OP      : std_logic_vector(3 downto 0) := "1011";
    signal SLL_OP      : std_logic_vector(3 downto 0) := "1100";
    signal SRL_OP      : std_logic_vector(3 downto 0) := "1101";
    signal SRA_OP      : std_logic_vector(3 downto 0) := "1110";
    signal ADD_OP      : std_logic_vector(3 downto 0) := "0100";
    signal SUB_OP      : std_logic_vector(3 downto 0) := "0101";
    signal MULT_OP      : std_logic_vector(3 downto 0) := "0110";
    
begin
    or_inst: alu32 port map (
        a_value => OR_A,
        b_value => OR_B,
        op_code => OR_OP,
        y_value => OR_Y
    );
    
    and_inst: alu32 port map (
        a_value => AND_A,
        b_value => AND_B,
        op_code => AND_OP,
        y_value => AND_Y
    );
    
    xor_inst: alu32 port map (
        a_value => XOR_A,
        b_value => XOR_B,
        op_code => XOR_OP,
        y_value => XOR_Y
    );
    
    sll_inst: alu32 port map (
        a_value => SLL_A,
        b_value => SLL_B,
        op_code => SLL_OP,
        y_value => SLL_Y
    );
    
    srl_inst: alu32 port map (
        a_value => SRL_A,
        b_value => SRL_B,
        op_code => SRL_OP,
        y_value => SRL_Y
    );
    
    sra_inst: alu32 port map (
        a_value => SRA_A,
        b_value => SRA_B,
        op_code => SRA_OP,
        y_value => SRA_Y
    );
    
    add_inst: alu32 port map (
        a_value => ADD_A,
        b_value => ADD_B,
        op_code => ADD_OP,
        y_value => ADD_Y
    );
    
    sub_inst: alu32 port map (
        a_value => SUB_A,
        b_value => SUB_B,
        op_code => SUB_OP,
        y_value => SUB_Y
    );
    
    mult_inst: alu32 port map (
        a_value => MULT_A,
        b_value => MULT_B,
        op_code => MULT_OP,
        y_value => MULT_Y
    );
    
    or_cases: process is
    begin
        for i in 0 to 8 loop
            OR_A <= or_array(i).a_value;
            OR_B <= or_array(i).b_value;
            wait for delay;
            assert OR_Y = or_array(i).y_value report "OR at " & time'image(now);
        end loop;
        wait;
    end process;
    
    and_cases: process is
    begin
        for i in 0 to 8 loop
            AND_A <= and_array(i).a_value;
            AND_B <= and_array(i).b_value;
            wait for delay;
            assert AND_Y = and_array(i).y_value report "AND at " & time'image(now);
        end loop;
        wait;
    end process;
        
    xor_cases: process is
    begin
        for i in 0 to 10 loop
            XOR_A <= xor_array(i).a_value;
            XOR_B <= xor_array(i).b_value;
            wait for delay;
            assert XOR_Y = xor_array(i).y_value report "XOR at " & time'image(now);
        end loop;
        assert false
		  report "Testbench Concluded"
		  severity failure;
    end process;
        
    sll_cases: process is
    begin
        for i in 0 to 4 loop
            SLL_A <= sll_array(i).a_value;
            SLL_B <= sll_array(i).b_value;
            wait for delay;
            assert SLL_Y = sll_array(i).y_value report "SLL at " & time'image(now);
        end loop;
        wait;
    end process;
    
    srl_cases: process is
    begin
        for i in 0 to 5 loop
            SRL_A <= srl_array(i).a_value;
            SRL_B <= srl_array(i).b_value;
            wait for delay;
            assert SRL_Y = srl_array(i).y_value report "SRL at " & time'image(now);
        end loop;
        wait;
    end process;
    
    sra_cases: process is 
    begin
        for i in 0 to 7 loop
            SRA_A <= sra_array(i).a_value;
            SRA_B <= sra_array(i).b_value;
            wait for delay;
            assert SRA_Y = sra_array(i).y_value report "SRA at " & time'image(now);
        end loop;
        wait;
    end process;
    
    add_cases: process is
    begin
        for i in 0 to 4 loop
            ADD_A <= add_array(i).a_value;
            ADD_B <= add_array(i).b_value;
            wait for delay;
            assert ADD_Y = add_array(i).y_value report "ADD at " & time'image(now);
        end loop;
        wait;
    end process;
    
    sub_cases: process is
    begin
        for i in 0 to 4 loop
            SUB_A <= sub_array(i).a_value;
            SUB_B <= sub_array(i).b_value;
            wait for delay;
            assert SUB_Y = sub_array(i).y_value report "SUB at " & time'image(now);
        end loop;
        wait;
    end process;
    
    mult_cases: process is
    begin
        for i in 0 to 4 loop
            MULT_A <= mult_array(i).a_value;
            MULT_B <= mult_array(i).b_value;
            wait for delay;
            assert MULT_Y = mult_array(i).y_value report "MULT at " & time'image(now);
        end loop;
        wait;
    end process;
    
end behavioral;
