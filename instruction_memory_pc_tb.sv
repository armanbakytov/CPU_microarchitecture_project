`timescale 1ns/1ps
`include "instruction_memory_pc.sv"

module instruction_memory_pc_tb;
    logic CLK, reset, PCsrc;
    logic [7:0] immediate;
    logic [23:0] Instr;


    instruction_memory_pc uut (
        .Instr(Instr),
        .CLK(CLK),
        .reset(reset),
        .PCsrc(PCsrc),
        .immediate(immediate)
    );
    // Clock generation
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    initial begin
        $dumpfile("instruction_memory_pc_tb.vcd");
        $dumpvars(0, instruction_memory_pc_tb);
        reset = 1;
        PCsrc = 0;
        immediate = 8'h00;
        #10 reset = 0;
        for (int i = 0; i < 8; i++) begin // running a full cycle
            #10;
        end
        

        for (int i = 0; i < 4; i++) begin // Testing immediates
        #10;
        PCsrc = 1;
        immediate = i*2;
        #10;
        end
        $finish;
    end


    initial begin
        $monitor("Instr = %h, reset = %b, PCsrc = %b, immediate = %d", Instr, reset, PCsrc, immediate); // did not display time since redundant
    end

endmodule