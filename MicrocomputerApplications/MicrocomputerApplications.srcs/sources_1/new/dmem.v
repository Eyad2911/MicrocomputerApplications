`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module : dmem  (data memory)
// Purpose: Combinational read, synchronous (rising edge) write gated by we.
// Inputs : clk, we, a [31:0] byte address, wd [31:0] write data
// Outputs: rd [31:0] - word at index a[7:2]
// Params : WORDS - number of words (>= 64)
// -----------------------------------------------------------------------------
module dmem #(parameter WORDS = 64)
(
    input         clk,
    input         we,
    input  [31:0] a,
    input  [31:0] wd,
    output [31:0] rd
);
    reg [31:0] mem [0:WORDS-1];
    integer i;

    initial for (i = 0; i < WORDS; i = i + 1) mem[i] = 32'h00000000;

    assign rd = mem[a[7:2]];

    always @(posedge clk)
        if (we) mem[a[7:2]] <= wd;
endmodule
