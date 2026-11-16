// Testbench for imem: checks that the hex file is read correctly.
`timescale 1ns/1ps
module imem_tb;
    reg  [31:0] a;
    wire [31:0] rd;
    integer errors = 0;

    imem #(.WORDS(64), .HEX("imem_test.hex")) dut (.a(a), .rd(rd));

    task check(input [31:0] addr, input [31:0] expected);
        begin
            a = addr; #1;
            if (rd !== expected) begin
                $display("FAIL: a=%h rd=%h expected=%h", addr, rd, expected);
                errors = errors + 1;
            end else
                $display("ok  : a=%h rd=%h", addr, rd);
        end
    endtask

    initial begin
        $dumpfile("imem_tb.vcd"); $dumpvars(0, imem_tb);
        check(32'h00, 32'h20080005);
        check(32'h04, 32'h2009000A);
        check(32'h08, 32'h00000000);
        check(32'h0C, 32'h01095020);
        check(32'h10, 32'h08000000);
        check(32'h14, 32'h00000000); // beyond file: nop
        check(32'h3C, 32'h00000000); // last word of the 64-word memory
        if (errors == 0) $display("imem_tb: PASS"); else $display("imem_tb: FAIL (%0d errors)", errors);
        $finish;
    end
endmodule
