// Testbench for if_id: values move one stage per clock; reset clears them.
`timescale 1ns/1ps
module if_id_tb;
    reg         clk = 0, reset = 1;
    reg  [31:0] InstrF = 0, PCPlus4F = 0;
    wire [31:0] InstrD, PCPlus4D;
    integer errors = 0;

    if_id dut (.clk(clk), .reset(reset), .InstrF(InstrF), .PCPlus4F(PCPlus4F),
               .InstrD(InstrD), .PCPlus4D(PCPlus4D));
    always #5 clk = ~clk;

    task expect(input [31:0] i, input [31:0] p, input [127:0] name);
        begin
            #1;
            if (InstrD !== i || PCPlus4D !== p) begin
                $display("FAIL: %0s InstrD=%h (exp %h) PCPlus4D=%h (exp %h)", name, InstrD, i, PCPlus4D, p);
                errors = errors + 1;
            end else
                $display("ok  : %0s InstrD=%h PCPlus4D=%h", name, InstrD, PCPlus4D);
        end
    endtask

    initial begin
        $dumpfile("if_id_tb.vcd"); $dumpvars(0, if_id_tb);
        InstrF = 32'h20080005; PCPlus4F = 32'h4;
        @(posedge clk); expect(32'h0, 32'h0, "held in reset");

        reset = 0;
        @(posedge clk); expect(32'h20080005, 32'h4, "first value after 1 clock");
        InstrF = 32'h2009000A; PCPlus4F = 32'h8;
        #1 expect(32'h20080005, 32'h4, "no change between clock edges");
        @(posedge clk); expect(32'h2009000A, 32'h8, "second value after next clock");

        reset = 1;
        @(posedge clk); expect(32'h0, 32'h0, "reset clears");

        if (errors == 0) $display("if_id_tb: PASS"); else $display("if_id_tb: FAIL (%0d errors)", errors);
        $finish;
    end
endmodule
