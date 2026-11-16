`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module : main_dec  (main decoder)
// Purpose: Decodes Op (bits 31:26) into the control signals ending with D.
// Inputs : Op [5:0]
// Outputs: RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump, ZeroExt,
//          ALUOp [2:0]
// Don't-cares of the spec table are driven to 0 so no X appears in waveforms.
// Unknown opcodes give an all-zero (harmless bubble) control word.
// -----------------------------------------------------------------------------
module main_dec
(
    input  [5:0] Op,
    output       RegWrite,
    output       RegDst,
    output       ALUSrc,
    output       Branch,
    output       MemWrite,
    output       MemtoReg,
    output       Jump,
    output       ZeroExt,
    output [2:0] ALUOp
);
    reg [10:0] controls;
    assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite,
            MemtoReg, Jump, ZeroExt, ALUOp} = controls;

    always @(*) begin
        case (Op)
            //            RW RD AS BR MW MR JP ZE  ALUOp
            6'b000000: controls = 11'b1_1_0_0_0_0_0_0_010; // R-type
            6'b100011: controls = 11'b1_0_1_0_0_1_0_0_000; // lw
            6'b101011: controls = 11'b0_0_1_0_1_0_0_0_000; // sw
            6'b000100: controls = 11'b0_0_0_1_0_0_0_0_001; // beq
            6'b001000: controls = 11'b1_0_1_0_0_0_0_0_000; // addi
            6'b001100: controls = 11'b1_0_1_0_0_0_0_1_011; // andi
            6'b001101: controls = 11'b1_0_1_0_0_0_0_1_100; // ori
            6'b001110: controls = 11'b1_0_1_0_0_0_0_1_101; // xori
            6'b000010: controls = 11'b0_0_0_0_0_0_1_0_000; // j
            default:   controls = 11'b0_0_0_0_0_0_0_0_000; // bubble
        endcase
    end
endmodule
