module alu (
    input  wire [31:0] SrcAE,
    input  wire [31:0] SrcBE,
    input  wire [4:0]  shamt,
    input  wire [3:0]  ALUControlE,
    output reg  [31:0] ALUOutE,
    output wire        ZeroE
);

    always @(*) begin
        case (ALUControlE)
            4'b0000: ALUOutE = SrcAE & SrcBE;                   // AND
            4'b0001: ALUOutE = SrcAE | SrcBE;                   // OR
            4'b0010: ALUOutE = SrcAE + SrcBE;                   // ADD
            4'b0011: ALUOutE = ~(SrcAE | SrcBE);                // NOR
            4'b0100: ALUOutE = SrcAE ^ SrcBE;                   // XOR
            4'b0110: ALUOutE = SrcAE - SrcBE;                   // SUB
            4'b1000: ALUOutE = SrcBE << shamt;                  // SLL
            4'b1001: ALUOutE = SrcBE >> shamt;                  // SRL (logical)
            4'b1010: ALUOutE = $signed(SrcBE) >>> shamt;        // SRA (arithmetic)
            default: ALUOutE = 32'b0;                           // Default to prevent latches
        endcase
    end
    assign ZeroE = (ALUOutE == 32'b0);

endmodule