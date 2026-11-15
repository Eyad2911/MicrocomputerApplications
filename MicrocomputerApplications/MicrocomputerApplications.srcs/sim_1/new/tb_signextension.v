`timescale 1ns / 1ps

module tb_signext();

    reg  [15:0] imm;
    reg         ZeroExtD;
    wire [31:0] SignImmD;

    signext uut (
        .imm(imm),
        .ZeroExtD(ZeroExtD),
        .SignImmD(SignImmD)
    );

    initial begin
        // Case 1: Positive immediate (0x0005), Sign-Extend (ZeroExtD = 0)
        // Expected: 0x00000005
        imm = 16'h0005; ZeroExtD = 0; #10;
        $display("ZeroExtD=%b | imm=%h | SignImmD=%h", ZeroExtD, imm, SignImmD);

        // Case 2: Negative immediate (0xFFFC = -4), Sign-Extend (ZeroExtD = 0)
        // Expected: 0xFFFFFFFC (upper 16 bits filled with F)
        imm = 16'hFFFC; ZeroExtD = 0; #10;
        $display("ZeroExtD=%b | imm=%h | SignImmD=%h", ZeroExtD, imm, SignImmD);

        // Case 3: Positive immediate (0x0005), Zero-Extend (ZeroExtD = 1)
        // Expected: 0x00000005
        imm = 16'h0005; ZeroExtD = 1; #10;
        $display("ZeroExtD=%b | imm=%h | SignImmD=%h", ZeroExtD, imm, SignImmD);

        // Case 4: Negative/MSB=1 immediate (0xFFFC), Zero-Extend (ZeroExtD = 1, e.g. for andi/ori/xori)
        // Expected: 0x0000FFFC (upper 16 bits filled with 0 instead of F!)
        imm = 16'hFFFC; ZeroExtD = 1; #10;
        $display("ZeroExtD=%b | imm=%h | SignImmD=%h", ZeroExtD, imm, SignImmD);

        $finish;
    end

endmodule