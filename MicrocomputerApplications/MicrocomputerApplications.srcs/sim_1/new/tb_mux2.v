`timescale 1ns / 1ps

module tb_mux2();

    reg  [31:0] d0;
    reg  [31:0] d1;
    reg         s;
    wire [31:0] y;

    // Instantiate 32-bit mux2
    mux2 #(32) uut (
        .d0(d0),
        .d1(d1),
        .s(s),
        .y(y)
    );

    initial begin
        // Set two distinct 32-bit patterns on d0 and d1
        d0 = 32'h00000004; 
        d1 = 32'h00000020;

        // Case 1: s = 0 -> y should equal d0 (00000004)
        s = 0; #10;
        $display("s=%b | d0=%h | d1=%h | y=%h", s, d0, d1, y);

        // Case 2: s = 1 -> y should equal d1 (00000020)
        s = 1; #10;
        $display("s=%b | d0=%h | d1=%h | y=%h", s, d0, d1, y);

        // Case 3: Change d0 and d1 while s = 1 -> y should track new d1 (55555555)
        d0 = 32'hAAAAAAAA;
        d1 = 32'h55555555; #10;
        $display("s=%b | d0=%h | d1=%h | y=%h", s, d0, d1, y);

        // Case 4: Switch s back to 0 -> y should track new d0 (AAAAAAAA)
        s = 0; #10;
        $display("s=%b | d0=%h | d1=%h | y=%h", s, d0, d1, y);

        $finish;
    end

endmodule