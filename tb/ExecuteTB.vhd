----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/21/2021 11:52:16 PM
-- Design Name: 
-- Module Name: ExecuteTB - behavioral
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

entity ExecuteTB is
end ExecuteTB;

architecture behavioral of ExecuteTB is
    component Execute is
        port(reg_write, mem_to_reg, mem_write, alu_source, reg_dest : in std_logic;
            alu_control : in std_logic_vector(3 downto 0);
            reg_source_a, reg_source_b : in std_logic_vector(31 downto 0);
            rt_dest, rd_dest : in std_logic_vector(4 downto 0);
            sign_imm : in std_logic_vector(31 downto 0);
            reg_write_out, mem_to_reg_out, mem_write_out : out std_logic;
            alu_result, write_data : out std_logic_vector(31 downto 0);
            write_reg : out std_logic_vector(4 downto 0)
        );
    end component;
    type test_vector is record
        reg_write : std_logic;
        mem_to_reg : std_logic;
        mem_write : std_logic;
        alu_source : std_logic;
        reg_dest : std_logic;
        alu_control : std_logic_vector(3 downto 0);
        reg_source_a : std_logic_vector(31 downto 0);
        reg_source_b : std_logic_vector(31 downto 0);
        rt_dest : std_logic_vector(4 downto 0);
        rd_dest : std_logic_vector(4 downto 0);
        sign_imm : std_logic_vector(31 downto 0);
        reg_write_out : std_logic;
        mem_to_reg_out : std_logic;
        mem_write_out : std_logic;
        alu_result : std_logic_vector(31 downto 0);
        write_data : std_logic_vector(31 downto 0);
        write_reg : std_logic_vector(4 downto 0); 
    end record;
    type test_array is array (natural range <>) of test_vector;
    constant test_vector_array : test_array := (
        (reg_write => '0',
         mem_to_reg => '0',
         mem_write => '0',
         alu_source => '1',
         reg_dest => '1', 
         alu_control => "1000",
         reg_source_a => x"0000000F",
         reg_source_b => x"00000000",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '0',
         mem_to_reg_out => '0',
         mem_write_out => '0',
         alu_result => x"000000FF",
         write_data => x"00000000",
         write_reg => "00001"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "1010",
         reg_source_a => x"0000000F",
         reg_source_b => x"0000000F",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"0000000F",
         write_data => x"0000000F",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "1011",
         reg_source_a => x"0000000F",
         reg_source_b => x"00000008",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000007",
         write_data => x"00000008",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "1100",
         reg_source_a => x"00000001",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000002",
         write_data => x"00000001",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "1101",
         reg_source_a => x"00000008",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000004",
         write_data => x"00000001",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "1110",
         reg_source_a => x"00000001",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"80000000",
         write_data => x"00000001",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "0100",
         reg_source_a => x"00000001",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000002",
         write_data => x"00000001",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "0101",
         reg_source_a => x"00000002",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000001",
         write_data => x"00000001",
         write_reg => "00000"),
         
         (reg_write => '1',
         mem_to_reg => '1',
         mem_write => '1',
         alu_source => '0',
         reg_dest => '0', 
         alu_control => "0110",
         reg_source_a => x"00000002",
         reg_source_b => x"00000001",
         rt_dest => "00000",
         rd_dest => "00001",
         sign_imm => x"000000F0",
         reg_write_out => '1',
         mem_to_reg_out => '1',
         mem_write_out => '1',
         alu_result => x"00000002",
         write_data => x"00000001",
         write_reg => "00000")
    );
    signal reg_write, mem_to_reg, mem_write, alu_source, reg_dest, reg_write_out, mem_to_reg_out, mem_write_out : std_logic;
    signal alu_control : std_logic_vector(3 downto 0);
    signal reg_source_a, reg_source_b, sign_imm, alu_result, write_data : std_logic_vector(31 downto 0);
    signal rt_dest, rd_dest, write_reg : std_logic_vector(4 downto 0);
    
begin
    UUT : Execute
        port map(reg_write => reg_write,
                 mem_to_reg => mem_to_reg,
                 mem_write => mem_write,
                 alu_source => alu_source,
                 reg_dest => reg_dest,
                 alu_control => alu_control,
                 reg_source_a => reg_source_a,
                 reg_source_b => reg_source_b,
                 rt_dest => rt_dest,
                 rd_dest => rd_dest,
                 sign_imm => sign_imm,
                 reg_write_out => reg_write_out,
                 mem_to_reg_out => mem_to_reg_out,
                 mem_write_out => mem_write_out,
                 alu_result => alu_result,
                 write_data => write_data,
                 write_reg => write_reg
         );
                              
    stim: process is
    begin
        for i in 0 to 8 loop
            reg_write <= test_vector_array(i).reg_write;
            mem_to_reg <= test_vector_array(i).mem_to_reg;
            mem_write <= test_vector_array(i).mem_write;
            alu_source <= test_vector_array(i).alu_source;
            reg_dest <= test_vector_array(i).reg_dest;
            alu_control <= test_vector_array(i).alu_control;
            reg_source_a <= test_vector_array(i).reg_source_a;
            reg_source_b <= test_vector_array(i).reg_source_b;
            rt_dest <= test_vector_array(i).rt_dest;
            rd_dest <= test_vector_array(i).rd_dest;
            sign_imm <= test_vector_array(i).sign_imm;
            wait for 60 ns;
            assert reg_write_out = test_vector_array(i).reg_write_out report "reg_write_out " & time'image(now);
            assert mem_to_reg_out = test_vector_array(i).mem_to_reg_out report "mem_to_reg_out " & time'image(now);
            assert mem_write_out = test_vector_array(i).mem_write_out report "mem_write_out " & time'image(now);
            assert alu_result = test_vector_array(i).alu_result report "alu_result " & time'image(now);
            assert write_data = test_vector_array(i).write_data report "write_data " & time'image(now);
            assert write_reg = test_vector_array(i).write_reg report "write_reg " & time'image(now);
        end loop;
        assert false
		  report "Testbench Concluded"
		  severity failure;
    end process;
end behavioral;
