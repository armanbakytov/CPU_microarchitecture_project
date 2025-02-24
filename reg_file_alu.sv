`include "alu.sv"
`include "reg_file.sv"





module reg_file_alu (
    output logic [7:0] ALUResult, cpu_out,
    output logic Zero,
    input logic [3:0] RA1, RA2, WA,
    input logic [7:0] immediate,
    input logic write_enable, ALUsrc, CLK,
    input logic [1:0] ALUControl
);

logic [7:0] RD1, RD2, SrcA, SrcB;

assign SrcA = RD1;

reg_file u_reg_file (
    RD1,RD2, cpu_out,RA1,RA2, WA, ALUResult, write_enable, CLK
);

alu u_alu (
    ALUResult, Zero, SrcA, SrcB, ALUControl
);

always_comb begin
    case(ALUsrc)
    1'b0: SrcB = RD2;
    1'b1: SrcB = immediate;
endcase
end


endmodule