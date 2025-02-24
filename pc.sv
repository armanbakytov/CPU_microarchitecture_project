module PC(
    input logic CLK, reset, PCsrc,
    input logic [7:0] immediate,
    output logic [7:0] PC
);

always_ff @ (posedge CLK or posedge reset) begin
    if (reset)
        PC <= 8'b0;
    else if (PCsrc)
        PC <= immediate;
    else
        PC <= PC + 1;
end

endmodule