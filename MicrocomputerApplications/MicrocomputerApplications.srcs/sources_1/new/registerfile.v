module regfile (
    input  wire        clk,
    input  wire        WE3,
    input  wire [4:0]  A1,
    input  wire [4:0]  A2,
    input  wire [4:0]  A3,
    input  wire [31:0] WD3,
    output wire [31:0] RD1,
    output wire [31:0] RD2
);

    reg [31:0] rf [31:0];
    integer i;

    // Initialize registers to 0 for clean simulation waveforms (no X values)
    initial begin
        for (i = 0; i < 32; i = i + 1)
            rf[i] = 32'b0;
    end

    // Synchronous write on the FALLING clock edge (negedge clk)
    // Do not write to register 0 ($zero)
    always @(negedge clk) begin
        if (WE3 && (A3 != 5'b00000)) begin
            rf[A3] <= WD3;
        end
    end

    // Combinational (asynchronous) reads; register 0 always returns 0
    assign RD1 = (A1 == 5'b00000) ? 32'b0 : rf[A1];
    assign RD2 = (A2 == 5'b00000) ? 32'b0 : rf[A2];

endmodule