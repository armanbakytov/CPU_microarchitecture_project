`timescale 1ns/1ps
`include "instruction_memory.sv"


module instruction_memory_tb;

    logic [7:0] PC;
    logic [23:0] Instr;

    instruction_memory uut (
        .Instr(Instr),
        .PC(PC)
    );

    initial begin
    $dumpfile("instruction_memory_tb.vcd");
    $dumpvars(0, instruction_memory_tb);
    end
    initial begin

        PC = 0;

        for (int i = 0; i < 8; i++) begin // running a full cycle
            #10;
            PC = i;
        end
        

        #10 $finish;
    end

    initial begin
        $monitor("PC = %h, Instr = %h", PC, Instr);
    end

endmodule
