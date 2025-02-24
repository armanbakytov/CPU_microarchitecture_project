`timescale 1ns/1ps
`include "cpu.sv"

module cpu_tb;

    logic CLK, reset;
    logic [7:0] ALUResult, cpu_out;

    cpu uut (
        .CLK(CLK),
        .reset(reset),
        .ALUResult(ALUResult),
        .cpu_out(cpu_out)
    );
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end

    initial begin
        $dumpfile("cpu_tb.vcd");
        $dumpvars(0, cpu_tb);

        reset = 1;

        #10 reset = 0;

        for (int i = 0; i < 32; i++) begin
            #10;
        end

        $finish;
    end

    initial begin
        $monitor("At time %t, ALUResult = %h, cpu_out = %h", $time, ALUResult, cpu_out);
    end

endmodule