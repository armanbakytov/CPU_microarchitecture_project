`timescale 1ns/1ps
`include "reg_file_alu.sv"

module reg_file_alu_tb;
    logic [7:0] ALUResult, cpu_out;
    logic Zero;
    logic [3:0] RA1, RA2, WA;
    logic [7:0] immediate;
    logic write_enable, ALUsrc, CLK;
    logic [1:0] ALUControl;

    reg_file_alu uut (
        .ALUResult(ALUResult),
        .cpu_out(cpu_out),
        .Zero(Zero),
        .RA1(RA1),
        .RA2(RA2),
        .WA(WA),
        .immediate(immediate),
        .write_enable(write_enable),
        .ALUsrc(ALUsrc),
        .CLK(CLK),
        .ALUControl(ALUControl)
    );

    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    initial begin
        $dumpfile("reg_file_alu_tb.vcd");
        $dumpvars(0, reg_file_alu_tb);

        RA1 = 4'd0;
        RA2 = 4'd0;
        WA = 4'd1;
        immediate = 8'h00;
        write_enable = 0;
        ALUsrc = 1;
        ALUControl = 2'b10; // or operation so that ALUResult is not zero and directly shows the immediate value
        #20;

        // writing multiples of 0x11 to registers 1 to 15
        for (int i = 1; i <= 8; i++) begin
            WA = i;
            immediate = i * 8'h11;
            write_enable = 1;
            #20;
            write_enable = 0;
            #20;
        end

        WA = 15;
            immediate = 6 * 8'h11;
            write_enable = 1;
            #20;
            write_enable = 0;
            #20;

        //ALU operations
        RA1 = 4'd1;
        RA2 = 4'd2;
        ALUsrc = 0; 
        ALUControl = 2'b10;
        #20;
        $display("The cpu_out is %h (Expected: 66)", cpu_out);
        $display("Reg1 + Reg2: ALUResult = %h (Expected: 33)", ALUResult);

        RA1 = 4'd3;
        RA2 = 4'd4;
        ALUControl = 2'b10;
        #20;
        $display("Reg3 + Reg4: ALUResult = %h (Expected: 77)", ALUResult);


        // AND operation
        RA1 = 4'd3;
        RA2 = 4'd4;
        ALUControl = 2'b00;
        #20;
        $display("Reg3 & Reg4: ALUResult = %h (Expected: 00)", ALUResult);


        //OR operation
        ALUControl = 2'b01;
        #20;
        $display("Reg3 | Reg4: ALUResult = %h (Expected: 77)", ALUResult);

        $stop;
    end

endmodule