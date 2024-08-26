----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2021 12:12:14 PM
-- Design Name: 
-- Module Name: MultiplierNTB - behavioral
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

entity MultiplierNTB is
end MultiplierNTB;

architecture behavioral of MultiplierNTB is
    component multiplier is
        generic(NUM_BITS : natural := 32);
        port(a_value, b_value : in std_logic_vector((NUM_BITS/2)-1 downto 0);
             product : out std_logic_vector(NUM_BITS-1 downto 0));
    end component;
    type test_vector is record
        a_value : std_logic_vector(15 downto 0);
        b_value : std_logic_vector(15 downto 0);
        product : std_logic_vector(31 downto 0);
    end record;
    type test_array is array (natural range <>) of test_vector;
    constant test_vector_array : test_array := (
        (a_value => x"00000001", b_value => x"00000000", product => x"00000000"),
	    (a_value => x"00000000", b_value => x"00000001", product => x"00000000"),
	    (a_value => x"00000001", b_value => x"00000001", product => x"00000001"),
	    (a_value => x"00000002", b_value => x"00000002", product => x"00000004"),
	    (a_value => x"00008000", b_value => x"00008000", product => x"40000000")
    );
    signal a_value, b_value : std_logic_vector(15 downto 0);
    signal product : std_logic_vector(31 downto 0);
begin
    UUT : multiplier
        generic map(NUM_BITS => 32)
        port map(a_value => a_value, b_value => b_value, product => product);

    stim: process is
    begin
        for i in 0 to 4 loop
            a_value <= test_vector_array(i).a_value;
            b_value <= test_vector_array(i).b_value;
            wait for 60 ns;
            assert product = test_vector_array(i).product report "product at " & time'image(now);
        end loop;
    end process;
end behavioral;
