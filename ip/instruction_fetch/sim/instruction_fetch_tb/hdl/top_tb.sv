`timescale 1ns / 1ps

module top;

logic clock = 0;
logic reset;
logic [31:0] instruction;

always #5 clock = ~clock; // 100 MHz clock

initial begin
    reset = 1;
    #100;
    reset = 0;
end

instruction_fetch_stage dut (
    .clk(clock),
    .rst(reset),
    .instruction(instruction)
);

test u_test();
    
endmodule