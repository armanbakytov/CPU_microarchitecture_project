`timescale 1ns/1ps
`include "control_unit.sv"


module control_unit_tb;

    logic [3:0] opcode;

    logic RegWrite, ALUSrc, Branch;
    logic [1:0] ALUControl;

    control_unit uut (

         .opcode(opcode),

        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),

        .Branch(Branch),
        .ALUControl(ALUControl)
    );

    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        opcode = 4'b0000;

        for (int i = 0; i < 8; i++) begin
            opcode = i;

            #10;
        end

        $finish;
    end

    initial begin
        $monitor("opcode = %b, RegWrite = %b,  ALUSrc = %b, ALUControl = %b, Branch = %b", opcode, RegWrite, ALUSrc, ALUControl, Branch);
    end

endmodule