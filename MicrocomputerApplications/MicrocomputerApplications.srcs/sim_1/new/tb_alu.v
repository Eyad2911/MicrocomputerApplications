`timescale 1ns / 1ps

module tb_alu();

    reg  [31:0] SrcAE;
    reg  [31:0] SrcBE;
    reg  [4:0]  shamt;
    reg  [3:0]  ALUControlE;
    wire [31:0] ALUOutE;
    wire        ZeroE;

    alu uut (
        .SrcAE(SrcAE),
        .SrcBE(SrcBE),
        .shamt(shamt),
        .ALUControlE(ALUControlE),
        .ALUOutE(ALUOutE),
        .ZeroE(ZeroE)
    );

    initial begin
        // Initialize inputs: A = 10 (0x0000000A), B = 5 (0x00000005), shamt = 0
        SrcAE = 32'h0000000A; SrcBE = 32'h00000005; shamt = 5'd0;

        // 1. ADD (10 + 5 = 15 -> 0x0000000F)
        ALUControlE = 4'b0010; #10;
        // 2. SUB (10 - 5 = 5 -> 0x00000005)
        ALUControlE = 4'b0110; #10;
        // 3. SUB resulting in Zero flag = 1 (10 - 10 = 0)
        SrcBE = 32'h0000000A; ALUControlE = 4'b0110; #10;

        // Restore B = 5 (0x00000005)
        SrcBE = 32'h00000005;
        // 4. AND (0xA & 0x5 = 0x0 -> ZeroE = 1)
        ALUControlE = 4'b0000; #10;
        // 5. OR  (0xA | 0x5 = 0xF)
        ALUControlE = 4'b0001; #10;
        // 6. XOR (0xA ^ 0x5 = 0xF)
        ALUControlE = 4'b0100; #10;
        // 7. NOR (~(0xA | 0x5) = 0xFFFFFFF0)
        ALUControlE = 4'b0011; #10;

        // 8. SLL: Shift B (0x0000000A) left by shamt=2 -> 0x00000028 (40)
        SrcBE = 32'h0000000A; shamt = 5'd2; ALUControlE = 4'b1000; #10;
        // 9. SRL: Shift negative B (0xFFFFFFF0 = -16) right logically by 2 -> 0x3FFFFFFC (zero-filled)
        SrcBE = 32'hFFFFFFF0; shamt = 5'd2; ALUControlE = 4'b1001; #10;
        // 10. SRA: Shift negative B (0xFFFFFFF0 = -16) right arithmetically by 2 -> 0xFFFFFFFC (-4, sign-filled!)
        SrcBE = 32'hFFFFFFF0; shamt = 5'd2; ALUControlE = 4'b1010; #10;

        $finish;
    end

endmodule