----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2021 10:32:26 PM
-- Design Name: 
-- Module Name: MIPSTB - behavioral
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

entity MIPSTB is
end MIPSTB;

architecture behavioral of MIPSTB is
    component mips is
    port(clk, reset : in std_logic;
         InstructionFetchOut : out std_logic_vector(31 downto 0);
         ALUControlDecodeStage : out std_logic_vector(3 downto 0);
         Read1OutD, Read2OutD : out std_logic_vector(31 downto 0);
         ALUResultE : out std_logic_vector(31 downto 0);
         WriteRegE : out std_logic_vector(4 downto 0);
         WriteDataM : out std_logic_vector(31 downto 0);
         ReadDataM : out std_logic_vector(31 downto 0);
         ResultW : out std_logic_vector(31 downto 0)
        );
    end component;
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal InstructionFetchOut : std_logic_vector(31 downto 0);
    signal Read1OutD, Read2OutD : std_logic_vector(31 downto 0);
    signal ALUControlDecodeStage : std_logic_vector(3 downto 0);
    signal ALUResultE : std_logic_vector(31 downto 0);
    signal WriteRegE : std_logic_vector(4 downto 0);
    signal WriteDataM : std_logic_vector(31 downto 0);
    signal ReadDataM : std_logic_vector(31 downto 0);
    signal ResultW : std_logic_vector(31 downto 0);
begin
    UUT : mips
    port map(clk => clk,
             reset => reset,
             InstructionFetchOut => InstructionFetchOut,
             ALUControlDecodeStage => ALUControlDecodeStage,
             Read1OutD => Read1OutD,
             Read2OutD => Read2OutD,
             ALUResultE => ALUResultE,
             WriteRegE => WriteRegE,
             WriteDataM => WriteDataM,
             ReadDataM => ReadDataM,
             ResultW => ResultW);
             
    clk <= not clk after 40 ns;
    
    reset <= '0' after 80 ns;


end behavioral;
