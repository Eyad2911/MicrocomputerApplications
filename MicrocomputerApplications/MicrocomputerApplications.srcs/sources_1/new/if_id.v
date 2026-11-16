`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// Module : if_id  (IF/ID pipeline register)
// Purpose: Holds the fetched instruction and PC+4 for the Decode stage.
// Inputs : clk, reset, InstrF [31:0], PCPlus4F [31:0]
// Outputs: InstrD [31:0], PCPlus4D [31:0]
// Updates on the rising edge; reset clears to zero (a nop).
// -----------------------------------------------------------------------------
module if_id
(
    input             clk,
    input             reset,
    input      [31:0] InstrF,
    input      [31:0] PCPlus4F,
    output reg [31:0] InstrD,
    output reg [31:0] PCPlus4D
);
    always @(posedge clk) begin
        if (reset) begin
            InstrD   <= 32'h00000000;
            PCPlus4D <= 32'h00000000;
        end else begin
            InstrD   <= InstrF;
            PCPlus4D <= PCPlus4F;
        end
    end
endmodule
