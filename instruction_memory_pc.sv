`include "pc.sv"
`include "instruction_memory.sv"


module instruction_memory_pc (
    output logic [23:0] Instr,

    input logic CLK, reset, PCsrc,
    input logic [7:0] immediate

);

logic [7:0] PC;

PC u_pc (
    .CLK(CLK),

    .reset(reset),
    .PCsrc(PCsrc),
    .immediate(immediate),
    .PC(PC)
);

instruction_memory u_instruction_memory (

    .Instr(Instr),
    .PC(PC)
);

endmodule