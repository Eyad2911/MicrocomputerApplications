// Testbench for main_dec: every instruction of the control table (Section 3.5).
`timescale 1ns/1ps
module main_dec_tb;
    reg  [5:0] Op;
    wire       RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump, ZeroExt;
    wire [2:0] ALUOp;
    integer errors = 0;

    main_dec dut (.Op(Op), .RegWrite(RegWrite), .RegDst(RegDst), .ALUSrc(ALUSrc),
                  .Branch(Branch), .MemWrite(MemWrite), .MemtoReg(MemtoReg),
                  .Jump(Jump), .ZeroExt(ZeroExt), .ALUOp(ALUOp));

    // expected = {RegWrite,RegDst,ALUSrc,Branch,MemWrite,MemtoReg,Jump,ZeroExt,ALUOp}
    task check(input [5:0] op, input [10:0] expected, input [127:0] name);
        reg [10:0] got;
        begin
            Op = op; #1;
            got = {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump, ZeroExt, ALUOp};
            if (got !== expected) begin
                $display("FAIL: %0s got %b expected %b", name, got, expected);
                errors = errors + 1;
            end else
                $display("ok  : %0s %b", name, got);
        end
    endtask

    initial begin
        $dumpfile("main_dec_tb.vcd"); $dumpvars(0, main_dec_tb);
        check(6'b000000, 11'b1_1_0_0_0_0_0_0_010, "R-type");
        check(6'b100011, 11'b1_0_1_0_0_1_0_0_000, "lw");
        check(6'b101011, 11'b0_0_1_0_1_0_0_0_000, "sw");
        check(6'b000100, 11'b0_0_0_1_0_0_0_0_001, "beq");
        check(6'b001000, 11'b1_0_1_0_0_0_0_0_000, "addi");
        check(6'b001100, 11'b1_0_1_0_0_0_0_1_011, "andi");
        check(6'b001101, 11'b1_0_1_0_0_0_0_1_100, "ori");
        check(6'b001110, 11'b1_0_1_0_0_0_0_1_101, "xori");
        check(6'b000010, 11'b0_0_0_0_0_0_1_0_000, "j");
        check(6'b111111, 11'b0,                   "unknown opcode -> bubble");
        if (errors == 0) $display("main_dec_tb: PASS"); else $display("main_dec_tb: FAIL (%0d errors)", errors);
        $finish;
    end
endmodule
