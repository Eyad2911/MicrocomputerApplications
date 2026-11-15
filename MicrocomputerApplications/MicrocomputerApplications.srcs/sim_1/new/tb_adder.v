`timescale 1ns / 1ps

module tb_adder();

    reg  [31:0] a;
    reg  [31:0] b;
    wire [31:0] y;

    adder uut (
        .a(a),
        .b(b),
        .y(y)
    );

    initial begin
        // Test 1: PC + 4 calculation
        a = 32'h00000000; b = 32'h00000004; #10;
        $display("a=%h + b=%h = y=%h", a, b, y);

        // Test 2: Standard addition
        a = 32'h00000010; b = 32'h00000024; #10;
        $display("a=%h + b=%h = y=%h", a, b, y);

        // Test 3: Backward branch offset (adding a negative two's complement offset)
        a = 32'h00000020; b = 32'hFFFFFFF8; #10; // 0x20 + (-8) = 0x18
        $display("a=%h + b=%h = y=%h", a, b, y);

        // Test 4: Overflow wrap-around (required by Table 3.7)
        a = 32'hFFFFFFFC; b = 32'h00000004; #10; // Wraps to 0x00000000
        $display("a=%h + b=%h = y=%h", a, b, y);

        $finish;
    end

endmodule