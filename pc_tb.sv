`timescale 1ns/1ps
`include "pc.sv"

module pc_tb;
    logic CLK, reset, PCsrc;
    logic [7:0] immediate;

    logic [7:0] PC;

    PC uut (
        .CLK(CLK),
        .reset(reset),
        .PCsrc(PCsrc),
        .immediate(immediate),
        .PC(PC)
    );
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
    end
    initial begin
        reset = 1;
        PCsrc = 0;
        immediate = 8'h00;

        #10 reset = 0;
        // Test 1: +1
        #10;
        // Test 2: +1
        #10;
        // Test 3: Load
        PCsrc = 1;
        immediate = 8'h10;
        #10;
        // Test 4: +1
        PCsrc = 0;
        #10;
        // Test 5: Load
        PCsrc = 1;
        immediate = 8'h20;
        #10;
        // Test 6: +1
        PCsrc = 0;
        #10;
        // Test 7: Load
        PCsrc = 1;
        immediate = 8'h30;
        #10;
        // Test 8: +1
        PCsrc = 0;
        #10;

        //reset
        reset = 1;
        #10;
        $finish;
    end

    initial begin
        $monitor("At time %t, PC = %d, reset = %b, PCsrc = %b, immediate = %d", $time, PC, reset, PCsrc, immediate);
    end

endmodule