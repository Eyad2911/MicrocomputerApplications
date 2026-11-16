// Testbench for dmem: initial zero, write then read, no write when we = 0.
`timescale 1ns/1ps
module dmem_tb;
    reg         clk = 0, we = 0;
    reg  [31:0] a = 0, wd = 0;
    wire [31:0] rd;
    integer errors = 0;

    dmem #(.WORDS(64)) dut (.clk(clk), .we(we), .a(a), .wd(wd), .rd(rd));
    always #5 clk = ~clk;

    task expect(input [31:0] expected, input [255:0] msg);
        begin
            #1;
            if (rd !== expected) begin
                $display("FAIL: %0s rd=%h expected=%h", msg, rd, expected);
                errors = errors + 1;
            end else
                $display("ok  : %0s rd=%h", msg, rd);
        end
    endtask

    initial begin
        $dumpfile("dmem_tb.vcd"); $dumpvars(0, dmem_tb);
        a = 32'h00; #1; expect(32'h0, "initial word 0 is zero");
        a = 32'h3C; #1; expect(32'h0, "initial word 15 is zero");

        // write 0xDEADBEEF to address 0x08
        a = 32'h08; wd = 32'hDEADBEEF; we = 1;
        @(posedge clk); #1; we = 0;
        expect(32'hDEADBEEF, "read back after write");

        // write is synchronous: value must not change before the clock edge
        a = 32'h0C; wd = 32'h12345678; we = 1; #1;
        expect(32'h0, "no write before clock edge");
        @(posedge clk); #1; we = 0;
        expect(32'h12345678, "write after clock edge");

        // we = 0: no write
        a = 32'h08; wd = 32'hFFFFFFFF; we = 0;
        @(posedge clk); #1;
        expect(32'hDEADBEEF, "no write when we = 0");

        // word addressing: byte addresses 0x08..0x0B map to the same word
        a = 32'h0B; #1; expect(32'hDEADBEEF, "low 2 address bits ignored");

        if (errors == 0) $display("dmem_tb: PASS"); else $display("dmem_tb: FAIL (%0d errors)", errors);
        $finish;
    end
endmodule
