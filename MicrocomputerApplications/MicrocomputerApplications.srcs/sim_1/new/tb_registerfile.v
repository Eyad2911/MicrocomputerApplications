`timescale 1ns / 1ps

module tb_regfile();

    reg         clk;
    reg         WE3;
    reg  [4:0]  A1, A2, A3;
    reg  [31:0] WD3;
    wire [31:0] RD1, RD2;

    regfile uut (
        .clk(clk),
        .WE3(WE3),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // 10ns clock period (rising edge at 5, 15, 25... falling edge at 10, 20, 30...)
    always #5 clk = ~clk;

    initial begin
        clk = 0; WE3 = 0;
        A1 = 5'd0; A2 = 5'd0; A3 = 5'd0; WD3 = 32'h00000000;

        // 1. Write 0x00000005 to $t0 (reg 8) on falling edge at 10ns, and read it on A1
        #2;
        WE3 = 1; A3 = 5'd8; WD3 = 32'h00000005; A1 = 5'd8; A2 = 5'd0;
        #10; // Passes falling edge at 10ns -> RD1 should become 00000005 at 10ns!

        // 2. Write 0x0000000A to $t1 (reg 9) on falling edge at 20ns, and read on A2
        A3 = 5'd9; WD3 = 32'h0000000A; A2 = 5'd9;
        #10; // Passes falling edge at 20ns -> RD2 should become 0000000A at 20ns!

        // 3. Attempt to write 0xFFFFFFFF to $zero (reg 0) with WE3 = 1
        A3 = 5'd0; WD3 = 32'hFFFFFFFF; A1 = 5'd0;
        #10; // Passes falling edge at 30ns -> RD1 (reading reg 0) MUST stay 00000000!

        // 4. Test WE3 = 0 (disable write): try overwriting reg 8 ($t0) with 0x12345678
        WE3 = 0; A3 = 5'd8; WD3 = 32'h12345678; A1 = 5'd8;
        #10; // Passes falling edge at 40ns -> RD1 (reg 8) MUST remain 00000005!

        #8;
        $finish;
    end

endmodule