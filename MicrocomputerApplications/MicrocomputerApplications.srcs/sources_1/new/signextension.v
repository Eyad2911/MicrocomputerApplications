module signext (
    input  wire [15:0] imm,
    input  wire        ZeroExtD,
    output wire [31:0] SignImmD
);

    assign SignImmD = ZeroExtD ? {16'h0000, imm} : {{16{imm[15]}}, imm};

endmodule