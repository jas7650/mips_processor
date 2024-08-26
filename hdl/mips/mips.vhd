library ieee;
use ieee.std_logic_1164.all;

entity mips is 
    port(
        clk                     : in std_logic;
        reset                   : in std_logic;
        InstructionFetchOut     : out std_logic_vector(31 downto 0);
        Read1OutD               : out std_logic_vector(31 downto 0);
        Read2OutD               : out std_logic_vector(31 downto 0);
        ALUControlDecodeStage   : out std_logic_vector(3 downto 0);
        ALUResultE              : out std_logic_vector(31 downto 0);
        WriteRegE               : out std_logic_vector(4 downto 0);
        WriteDataM              : out std_logic_vector(31 downto 0);
        ReadDataM               : out std_logic_vector(31 downto 0);
        ResultW                 : out std_logic_vector(31 downto 0)
    );
end mips;

architecture behavioral of mips is 

    type fetch_stage_type is record
        clk                 : in std_logic;
        rst                 : in std_logic;
        instruction         : out std_logic_vector(31 downto 0);
    end record fetch_stage_type;

    type decode_stage_type is record
        clk                 : in std_logic;
        instruction         : in std_logic_vector(31 downto 0);
        reg_write_addr      : in std_logic_vector(4 downto 0);
        reg_write_data      : in std_logic_vector(31 downto 0);
        reg_write_en        : in std_logic;
        reg_write           : out std_logic;
        mem_to_reg          : out std_logic;
        mem_write           : out std_logic;
        alu_control         : out std_logic_vector(3 downto 0);
        alu_source          : out std_logic;
        reg_dest            : out std_logic;
        rd1                 : out std_logic_vector(31 downto 0);
        rd2                 : out std_logic_vector(31 downto 0);
        rt_dest             : out std_logic_vector(4 downto 0); 
        rd_dest             : out std_logic_vector(4 downto 0);
        imm_out             : out std_logic_vector(31 downto 0);
    end record decode_stage_type;

    type execute_stage_type is record
        reg_write           : in std_logic;
        mem_to_reg          : in std_logic;
        mem_write           : in std_logic;
        alu_source          : in std_logic;
        reg_dest            : in std_logic;
        alu_control         : in std_logic_vector(3 downto 0);
        reg_source_a        : in std_logic_vector(31 downto 0);
        reg_source_b        : in std_logic_vector(31 downto 0);
        rt_dest             : in std_logic_vector(4 downto 0);
        rd_dest             : in std_logic_vector(4 downto 0);
        sign_imm            : in std_logic_vector(31 downto 0);
        reg_write_out       : out std_logic;
        mem_to_reg_out      : out std_logic;
        mem_write_out       : out std_logic;
        alu_result          : out std_logic_vector(31 downto 0); 
        write_data          : out std_logic_vector(31 downto 0);
        write_reg           : out std_logic_vector(4 downto 0);
    end record execute_stage_type;

    type memory_stage_type is record
        clk                 : in std_logic;
        reg_write           : in std_logic;
        mem_to_reg          : in std_logic;
        mem_write           : in std_logic;
        write_reg           : in std_logic_vector(4 downto 0);
        alu_result          : in std_logic_vector(31 downto 0);
        write_data          : in std_logic_vector(31 downto 0);
        reg_write_out       : out std_logic;
        mem_to_reg_out      : out std_logic;
        write_reg_out       : out std_logic_vector(4 downto 0);
        mem_out             : out std_logic_vector(31 downto 0);
        alu_result_out      : out std_logic_vector(31 downto 0);
    end record memory_stage_type;

    type writeback_stage_type is record
        reg_write       : in std_logic; 
        mem_to_reg      : in std_logic;
        alu_result      : in std_logic_vector(31 downto 0);
        read_data       : in std_logic_vector(31 downto 0);
        write_reg       : in std_logic_vector(4 downto 0);
        reg_write_out   : out std_logic;
        write_reg_out   : out std_logic_vector(4 downto 0);
        result          : out std_logic_vector(31 downto 0);
    end record writeback_stage_type;

    signal fetch_stage : fetch_stage_type;
    signal decode_stage : decode_stage_type;
    signal execute_stage : execute_stage_type;
    signal memory_stage : memory_stage_type;
    signal writeback_stage : writeback_stage_type;

    signal InstructionInD : std_logic_vector(31 downto 0) := x"00000000";
    signal InstructionOutF : std_logic_vector(31 downto 0) := x"00000000";
    signal RegWriteInE, RegWriteInM, RegWriteInW : std_logic := '0';
    signal RegWriteOutD, RegWriteOutE, RegWriteOutM, RegWriteOutW : std_logic := '0';
    signal MemtoRegInE, MemtoRegInM, MemtoRegInW : std_logic := '0';
    signal MemtoRegOutD, MemtoRegOutE, MemtoRegOutM : std_logic := '0';
    signal MemWriteInE, MemWriteInM : std_logic := '0';
    signal MemWriteOutD, MemWriteOutE : std_logic := '0';
    signal ALUControlInE : std_logic_vector(3 downto 0) := "0000";
    signal ALUControlOutD : std_logic_vector(3 downto 0) := "0000";
    signal ALUSrcInE : std_logic := '0';
    signal ALUSrcOutD : std_logic := '0';
    signal RegDstInE : std_logic := '0';
    signal RegDstOutD : std_logic := '0';
    signal ResultOutW : std_logic_vector(31 downto 0) := x"00000000";
    signal WriteRegInM, WriteRegInW : std_logic_vector(4 downto 0) := "00000";
    signal WriteRegOutE, WriteRegOutM, WriteRegOutW : std_logic_vector(4 downto 0) := "00000";
    signal RD1OutD, RD2OutD : std_logic_vector(31 downto 0) := x"00000000";
    signal RD1InE, RD2InE : std_logic_vector(31 downto 0) := x"00000000";
    signal RtDestOutD, RdDestOutD : std_logic_vector(4 downto 0) := "00000";
    signal RtDestInE, RdDestInE : std_logic_vector(4 downto 0) := "00000";
    signal SignImmInE : std_logic_vector(31 downto 0) := x"00000000";
    signal SignImmOutD : std_logic_vector(31 downto 0) := x"00000000";
    signal ALUResultInM, ALUResultInW : std_logic_vector(31 downto 0) := x"00000000";
    signal ALUResultOutE, ALUResultOutM : std_logic_vector(31 downto 0) := x"00000000";
    signal WriteDataOutE : std_logic_vector(31 downto 0) := x"00000000";
    signal WriteDataInM : std_logic_vector(31 downto 0) := x"00000000";
    signal ReadDataOutM : std_logic_vector(31 downto 0) := x"00000000";
    signal ReadDataInW : std_logic_vector(31 downto 0) := x"00000000";
begin

    instruction_fetch_inst : entity instruction_fetch_stage.instruction_fetch
        port map(
            clk => clk,
            rst => reset,
            instruction => InstructionOutF
        );

    FtoD_proc : process(clk) is begin
        if rising_edge(clk) then
            InstructionInD <= InstructionOutF;
        end if;
    end process;

    instruction_decode_inst : entity instruction_decode_stage.instruction_decode
        port map(
            clk => clk,
            instruction => InstructionInD,
            reg_write_addr => WriteRegOutW,
            reg_write_data => ResultOutW,
            reg_write_en => RegWriteOutW,
            reg_write => RegWriteOutD,
            mem_to_reg => MemtoRegOutD,
            mem_write => MemWriteOutD,
            alu_control => ALUControlOutD,
            alu_source => ALUSrcOutD,
            reg_dest => RegDstOutD,
            rd1 => RD1OutD,
            rd2 => RD2OutD,
            rt_dest => RtDestOutD,
            rd_dest => RdDestOutD,
            imm_out => SignImmOutD
        );

    DtoE_proc : process(clk) is begin
        if rising_edge(clk) then
            RegWriteInE <= RegWriteOutD;
            MemtoRegInE <= MemtoRegOutD;
            MemWriteInE <= MemWriteOutD;
            ALUControlInE <= ALUControlOutD;
            ALUSrcInE <= ALUSrcOutD;
            RegDstInE <= RegDstOutD;
            RD1InE <= RD1OutD;
            RD2InE <= RD2OutD;
            RtDestInE <= RtDestOutD;
            RdDestInE <= RdDestOutD;
            SignImmInE <= SignImmOutD;
        end if;
    end process;

    execute_inst : entity execute_stage.execute_stage
        port map(
            reg_write => RegWriteInE,
            mem_to_reg => MemtoRegInE,
            mem_write => MemWriteInE,
            alu_source => ALUSrcInE,
            reg_dest => RegDstInE,
            alu_control => ALUControlInE,
            reg_source_a => RD1InE,
            reg_source_b => RD2InE,
            rt_dest => RtDestInE,
            rd_dest => RdDestInE,
            sign_imm => SignImmInE,
            reg_write_out =>  RegWriteOutE,
            mem_to_reg_out => MemtoRegOutE,
            mem_write_out => MemWriteOutE,
            alu_result => ALUResultOutE,
            write_data => WriteDataOutE,
            write_reg => WriteRegOutE
        );

    EtoM_proc : process(clk) is begin
        if rising_edge(clk) then
            RegWriteInM <= RegWriteOutE;
            MemtoRegInM <= MemtoRegOutE;
            MemWriteInM <= MemWriteOutE;
            ALUResultInM <= ALUResultOutE;
            WriteDataInM <= WriteDataOutE;
            WriteRegInM <= WriteRegOutE;
        end if;
    end process;

    memory_stage_inst : entity memory_stage.memory_stage
        port map(
            clk => clk,
            reg_write => RegWriteInM,
            mem_to_reg => MemtoRegInM,
            mem_write => MemWriteInM, 
            write_reg => WriteRegInM,
            alu_result => ALUResultInM,
            write_data => WriteDataInM,
            reg_write_out => RegWriteOutM,
            mem_to_reg_out => MemtoRegOutM,
            write_reg_out => WriteRegOutM,
            mem_out => ReadDataOutM,
            alu_result_out => ALUResultOutM
        );

    MtoW_proc : process(clk) is begin
        if rising_edge(clk) then
            RegWriteInW <= RegWriteOutM;
            MemtoRegInW <= MemtoRegOutM;
            ALUResultInW <= ALUResultOutM;
            ReadDataInW <= ReadDataOutM;
            WriteRegInW <= WriteRegOutM;
        end if;
    end process;

    writeback_stage_inst : entity writeback_stage.writeback_stage
        port map(
            reg_write => RegWriteInW,
            mem_to_reg => MemtoRegInW,
            alu_result => ALUResultInW,
            read_data => ReadDataInW,
            write_reg => WriteRegInW,
            reg_write_out => RegWriteOutW,
            write_reg_out => WriteRegOutW,
            result => ResultOutW
        );

    InstructionFetchOut <= InstructionOutF;
    Read1OutD <= RD1OutD;
    Read2OutD <= RD2OutD;
    ALUControlDecodeStage <= ALUControlOutD;
    ALUResultE <= ALUResultOutE;
    WriteRegE <= WriteRegOutE;
    WriteDataM <= WriteDataInM;
    ReadDataM <= ReadDataOutM;
    ResultW <= ResultOutW;

end behavioral;