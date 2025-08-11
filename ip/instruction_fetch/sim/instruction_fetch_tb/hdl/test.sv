`timescale 1ns / 1ps
import INSTRUCTION_FETCH_PKG::*;

module test;

    initial begin
        $display("Running sim");
        repeat (1000) @ (posedge top.clock);
        $display("Finishing");
        $stop();
    end

endmodule