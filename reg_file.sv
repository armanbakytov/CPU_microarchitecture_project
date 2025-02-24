module reg_file (
    output logic [7:0] RD1, RD2, cpu_out,
    input  logic [3:0] RA1, RA2, WA,
    input  logic [7:0] ALUResult,
    input  logic write_enable, CLK
);


    logic [7:0] data[0:15];

    assign RD1 = data[RA1];
    assign RD2 = data[RA2];


    always_ff @(posedge CLK) begin
        if (write_enable && WA != 4'd0)
            data[WA] <= ALUResult;
    end

    assign cpu_out = data[15];

    initial begin
        for (int i = 0; i < 16; i++)
            data[i] = 8'd0;
    end

endmodule
