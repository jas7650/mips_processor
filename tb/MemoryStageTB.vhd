----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2021 02:32:32 PM
-- Design Name: 
-- Module Name: MemoryStageTB - behavioral
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

entity MemoryStageTB is
end MemoryStageTB;

architecture behavioral of MemoryStageTB is
    constant WIDTH : natural := 32;
    constant ADDR_SPACE : natural := 10;
    
    component memory_stage is 
        port(clk, reg_write, mem_to_reg, mem_write : in std_logic;
             write_reg : in std_logic_vector(4 downto 0);
             alu_result : in std_logic_vector(31 downto 0);
             write_data : in std_logic_vector(31 downto 0);
             reg_write_out, mem_to_reg_out : out std_logic;
             write_reg_out : out std_logic_vector(4 downto 0);
             mem_out : out std_logic_vector(31 downto 0);
             alu_result_out : out std_logic_vector(31 downto 0)
        );
    end component;
        
    signal clk : std_logic := '0';
    signal reg_write, mem_to_reg, mem_write : std_logic := '1';
    signal write_reg : std_logic_vector(4 downto 0) := "10000";
    signal alu_result : std_logic_vector(WIDTH-1 downto 0) := x"00000000";
    signal write_data : std_logic_vector(WIDTH-1 downto 0) := x"00000000";
    signal mem_out : std_logic_vector(WIDTH-1 downto 0);
    signal reg_write_out, mem_to_reg_out : std_logic;
    signal write_reg_out : std_logic_vector(4 downto 0);
    signal alu_result_out : std_logic_vector(WIDTH-1 downto 0); 
begin
    MemoryStage_inst : memory_stage
        port map(clk => clk,
                 reg_write => reg_write,
                 mem_to_reg => mem_to_reg,
                 mem_write => mem_write,
                 write_reg => write_reg,
                 alu_result => alu_result,
                 write_data => write_data,
                 reg_write_out => reg_write_out,
                 mem_to_reg_out => mem_to_reg_out,
                 write_reg_out => write_reg_out,
                 mem_out => mem_out,
                 alu_result_out => alu_result_out);
                 
    clk <= not clk after 20 ns;
    
    stim_proc : process is begin
        wait until clk = '0';
        mem_write <= '1';
        alu_result <= x"0000001b";
        write_data <= x"5555aaaa";
        
        wait until clk = '0';
        alu_result <= x"0000001c";
        write_data <= x"5555aaaa";
        
        wait until clk = '0';
        mem_write <= '0';
        alu_result <= x"0000001b";
        
        wait until clk = '1';
        assert mem_out = x"5555aaaa" Report "mem_out at: " & time'image(now);
        
        wait until clk = '0';
        alu_result <= x"0000001c";
        
        wait until clk = '1';
        assert mem_out = x"5555aaaa" Report "mem_out at: " & time'image(now);
        std.env.stop(0);       
    end process;      

end behavioral;
