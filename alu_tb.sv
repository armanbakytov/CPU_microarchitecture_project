`timescale 1ns/1ps
`include "alu.sv"

module alu_tb;
logic [7:0] ALUResult;
logic Zero;
logic [7:0] SrcA, SrcB;
logic [1:0] ALUControl;

alu M1(ALUResult, Zero, SrcA, SrcB, ALUControl);
  initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

       
        SrcA = 8'h10;
        SrcB = 8'h20;
        ALUControl = 2'b10; 
        #10;
        $display("ADD: SrcA = %h, SrcB = %h, ALUResult = %h, Zero = %b", SrcA, SrcB, ALUResult, Zero);


        SrcA = 8'h30;
        SrcB = 8'h10;
        ALUControl = 2'b11; 
        #10;
        $display("SUB: SrcA = %h, SrcB = %h, ALUResult = %h, Zero = %b", SrcA, SrcB, ALUResult, Zero);
        SrcA = 8'hFF;
        SrcB = 8'h0F;
        ALUControl = 2'b00; 
        #10;
        $display("AND: SrcA = %h, SrcB = %h, ALUResult = %h, Zero = %b", SrcA, SrcB, ALUResult, Zero);

      
        SrcA = 8'hF0;
        SrcB = 8'h0F;
        ALUControl = 2'b01; 
        #10;
        $display("OR: SrcA = %h, SrcB = %h, ALUResult = %h, Zero = %b", SrcA, SrcB, ALUResult, Zero);

        $finish;
    end

endmodule