`include "instruction_memory_pc.sv"
`include "control_unit.sv"
`include "reg_file_alu.sv"
module cpu(
    output logic [7:0] ALUResult, cpu_out,

    input logic CLK, reset
);
//Creating the reg_file_alu
logic Zero;
logic [3:0] RA1, RA2, WA;
logic [7:0] immediate;
logic write_enable;
logic ALUSrc_1, ALUSrc_2;
logic [1:0] ALUControl;
//Creating the control_unit
logic [3:0] opcode;
logic RegWrite, Branch;
//Creating the instruction_memory_pc
logic [23:0] Instr;
logic PCsrc;
//logic [7:0] immediate;
instruction_memory_pc u_instruction_memory_pc (
    .Instr(Instr),
    .CLK(CLK),
    .reset(reset),
    .PCsrc(PCsrc),
    .immediate(immediate)
);
control_unit u_control_unit (
    .opcode(opcode),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc_1),
    .Branch(Branch),
    .ALUControl(ALUControl)
);
assign ALUSrc_2 = ALUSrc_1;
reg_file_alu u_reg_file_alu (
    .ALUResult(ALUResult),
    .cpu_out(cpu_out),
    .Zero(Zero),
    .RA1(RA1),
    .RA2(RA2),
    .WA(WA),
    .immediate(immediate),
    .write_enable(write_enable),
    .ALUsrc(ALUSrc_2),
    .CLK(CLK),
    .ALUControl(ALUControl)
);
//wires connecting the Reg_file_alu
assign write_enable = RegWrite;
assign RA1 = Instr[15:12];
assign RA2 = Instr[11:8];
assign WA = Instr[19:16];
assign immediate = Instr[7:0];
//wires connecting the control_unit
assign opcode = Instr[23:20];
//wires connecting the instruction_memory_pc
assign PCsrc = Branch & Zero;
endmodule