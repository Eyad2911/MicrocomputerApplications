`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module : imem  (instruction memory)
// Purpose: Read-only memory, combinational read, loaded from a hex file.
// Inputs : a  [31:0] - byte address (PC). Bits [1:0] are ignored (word aligned).
// Outputs: rd [31:0] - instruction at word index a[7:2]
// Params : WORDS - number of words (>= 64), HEX - hex file for $readmemh
// -----------------------------------------------------------------------------
module imem #(parameter WORDS = 64, parameter HEX = "program.hex")
(
    input  [31:0] a,
    output [31:0] rd
);
    reg [31:0] mem [0:WORDS-1];
    integer i;

    initial begin
        for (i = 0; i < WORDS; i = i + 1) mem[i] = 32'h00000000; // nop, no X
        $readmemh(HEX, mem);
    end

    assign rd = mem[a[7:2]];
endmodule
