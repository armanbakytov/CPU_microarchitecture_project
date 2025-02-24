module alu (
    output logic [7:0] ALUResult,
    output logic Zero,
    input logic [7:0] SrcA, SrcB,
    input logic [1:0] ALUControl
);

always_comb begin
    case (ALUControl)
        2'b00: ALUResult = SrcA & SrcB; 
        2'b01: ALUResult = SrcA | SrcB;  
        2'b10: ALUResult = SrcA + SrcB; 
        2'b11: ALUResult = SrcA - SrcB; 
        default: ALUResult = 8'b0;       
    endcase
    
    Zero = (ALUResult == 8'b0) ? 1'b1 : 1'b0;
end

endmodule