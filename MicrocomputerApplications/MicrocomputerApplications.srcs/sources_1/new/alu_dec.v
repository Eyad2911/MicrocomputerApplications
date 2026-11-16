`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module : alu_dec  (ALU decoder)
// Purpose: Turns ALUOp (from main_dec) and Funct into the 4-bit ALUControl.
// Inputs : ALUOp [2:0], Funct [5:0]
// Outputs: ALUControl [3:0]
// ALUOp: 000 add | 001 sub | 010 R-type (use Funct) | 011 and | 100 or | 101 xor
// -----------------------------------------------------------------------------
module alu_dec
(
    input      [2:0] ALUOp,
    input      [5:0] Funct,
    output reg [3:0] ALUControl
);
    always @(*) begin
        case (ALUOp)
            3'b000: ALUControl = 4'b0010; // add  (lw, sw, addi)
            3'b001: ALUControl = 4'b0110; // sub  (beq)
            3'b011: ALUControl = 4'b0000; // and  (andi)
            3'b100: ALUControl = 4'b0001; // or   (ori)
            3'b101: ALUControl = 4'b0100; // xor  (xori)
            3'b010: begin                 // R-type
                case (Funct)
                    6'b100000: ALUControl = 4'b0010; // add
                    6'b100010: ALUControl = 4'b0110; // sub
                    6'b100100: ALUControl = 4'b0000; // and
                    6'b100101: ALUControl = 4'b0001; // or
                    6'b100110: ALUControl = 4'b0100; // xor
                    6'b100111: ALUControl = 4'b0011; // nor
                    6'b000000: ALUControl = 4'b1000; // sll
                    6'b000010: ALUControl = 4'b1001; // srl
                    6'b000011: ALUControl = 4'b1010; // sra
                    default:   ALUControl = 4'b0000;
                endcase
            end
            default: ALUControl = 4'b0000;
        endcase
    end
endmodule
