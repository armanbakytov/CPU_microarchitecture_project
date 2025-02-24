`timescale 1ns/1ps
`include "reg_file.sv"

module reg_file_tb;

        logic [3:0] RA1, RA2, WA;
        logic [7:0] ALUResult;
        logic write_enable, CLK;
        logic [7:0] RD1, RD2, cpu_out;


    reg_file uut ( //turns out you can reference the inputs by name instead of order
    .RA1(RA1),
    .RA2(RA2),
    .WA(WA),
    .ALUResult(ALUResult),
    .write_enable(write_enable),
    .CLK(CLK),
    .RD1(RD1),
    .RD2(RD2),
    .cpu_out(cpu_out)
    );


    initial begin

        CLK = 0;

        forever #10 CLK = ~CLK;

    end


    initial begin
        RA1 = 4'd0;
        RA2 = 4'd0;
        WA = 4'd0;
        ALUResult = 8'h00;
        write_enable = 0;

        #20;

        for (int i = 1; i <= 15; i++) begin
            WA = i;
            ALUResult = i * 8'h11; // 11, 22, 33, .
            write_enable = 1;
            #20;
            write_enable = 0;
            RA1 = i;
            RA2 = i-1;
            #20;
            $display("Register %0d: RD1 = %h, Previous: RD2 = %h", i, RD1, RD2);
        end

        //check register 15 and cpu_out
        RA1 = 4'd15;
        #20;
        $display("Register 15 = %h, cpu_out = %h (Expected: FF)", RD1, cpu_out);

        $stop;
    end

    initial begin //googled this command for the it to create vcd file for the gtkwave
        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0,reg_file_tb);
    end

endmodule