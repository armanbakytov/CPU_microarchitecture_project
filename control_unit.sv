module control_unit(
    input logic [3:0] opcode,

    output logic RegWrite, ALUSrc, Branch,
    output logic [1:0] ALUControl
);


always_comb begin

    case (opcode)
        4'b0000: begin // and
            RegWrite = 1;
            ALUSrc = 0;
            ALUControl = 2'b00;
            Branch = 0;
        end
        4'b0001: begin // or
            RegWrite = 1;
            ALUSrc = 0;
            ALUControl = 2'b01;
            Branch = 0;
        end
        4'b0010: begin // add
            RegWrite = 1;
            ALUSrc = 0;
            ALUControl = 2'b10;
            Branch = 0;
        end
        4'b0011: begin // sub
            RegWrite = 1;
            ALUSrc = 0;
            ALUControl = 2'b11;
            Branch = 0;
        end
        4'b0100: begin // andi
            RegWrite = 1;
            ALUSrc = 1;
            ALUControl = 2'b00;
            Branch = 0;
        end
        4'b0101: begin // ori
            RegWrite = 1;
            ALUSrc = 1;
            ALUControl = 2'b01;
            Branch = 0;
        end
        4'b0110: begin // addi
            RegWrite = 1;
            ALUSrc = 1;
            ALUControl = 2'b10;
            Branch = 0;
        end
        4'b0111: begin // beq
            RegWrite = 0;
            ALUSrc = 0;
            ALUControl = 2'b11;
            Branch = 1;
        end
        default: begin
            RegWrite = 0;
            ALUSrc = 0;
            ALUControl = 2'b00;
            Branch = 0;
        end
    endcase
end

endmodule