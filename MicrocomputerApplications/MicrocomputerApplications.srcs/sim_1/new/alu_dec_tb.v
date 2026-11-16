// Testbench for alu_dec: every ALUOp and every R-type funct.
`timescale 1ns/1ps
module alu_dec_tb;
    reg  [2:0] ALUOp;
    reg  [5:0] Funct;
    wire [3:0] ALUControl;
    integer errors = 0;

    alu_dec dut (.ALUOp(ALUOp), .Funct(Funct), .ALUControl(ALUControl));

    task check(input [2:0] op, input [5:0] f, input [3:0] expected, input [127:0] name);
        begin
            ALUOp = op; Funct = f; #1;
            if (ALUControl !== expected) begin
                $display("FAIL: %0s got %b expected %b", name, ALUControl, expected);
                errors = errors + 1;
            end else
                $display("ok  : %0s -> %b", name, ALUControl);
        end
    endtask

    initial begin
        $dumpfile("alu_dec_tb.vcd"); $dumpvars(0, alu_dec_tb);
        check(3'b000, 6'b000000, 4'b0010, "ALUOp 000 add");
        check(3'b001, 6'b000000, 4'b0110, "ALUOp 001 sub");
        check(3'b011, 6'b000000, 4'b0000, "ALUOp 011 and");
        check(3'b100, 6'b000000, 4'b0001, "ALUOp 100 or");
        check(3'b101, 6'b000000, 4'b0100, "ALUOp 101 xor");
        check(3'b000, 6'b100010, 4'b0010, "ALUOp 000 ignores funct");
        check(3'b010, 6'b100000, 4'b0010, "R add");
        check(3'b010, 6'b100010, 4'b0110, "R sub");
        check(3'b010, 6'b100100, 4'b0000, "R and");
        check(3'b010, 6'b100101, 4'b0001, "R or");
        check(3'b010, 6'b100110, 4'b0100, "R xor");
        check(3'b010, 6'b100111, 4'b0011, "R nor");
        check(3'b010, 6'b000000, 4'b1000, "R sll");
        check(3'b010, 6'b000010, 4'b1001, "R srl");
        check(3'b010, 6'b000011, 4'b1010, "R sra");
        if (errors == 0) $display("alu_dec_tb: PASS"); else $display("alu_dec_tb: FAIL (%0d errors)", errors);
        $finish;
    end
endmodule
