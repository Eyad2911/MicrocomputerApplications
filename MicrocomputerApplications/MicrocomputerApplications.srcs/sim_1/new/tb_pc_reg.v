`timescale 1ns / 1ps

module tb_pc_reg();

    // 1. Declare testbench signals (reg for inputs, wire for outputs)
    reg         clk;
    reg         reset;
    reg  [31:0] pc_next;
    wire [31:0] PCF;

    // 2. Instantiate the Unit Under Test (UUT)
    pc_reg uut (
        .clk(clk),
        .reset(reset),
        .pc_next(pc_next),
        .PCF(PCF)
    );

    // 3. Generate a clock (e.g., 10ns period -> toggles every 5ns)
    always #5 clk = ~clk;

    // 4. Stimulus block
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        pc_next = 32'h00000004;

        // Wait 12ns so reset spans across a rising clock edge
        #12;
        // Check that PCF is 0 while reset is active
        $display("Time=%0t | reset=%b | pc_next=%h | PCF=%h", $time, reset, pc_next, PCF);

        // Release reset and feed consecutive addresses on clock edges
        reset = 0;
        
        // Wait for next rising edge, then change pc_next to 8, 12, and a branch target
        @(posedge clk); #1;
        $display("Time=%0t | reset=%b | pc_next=%h | PCF=%h", $time, reset, pc_next, PCF);
        
        pc_next = 32'h00000008;
        @(posedge clk); #1;
        $display("Time=%0t | reset=%b | pc_next=%h | PCF=%h", $time, reset, pc_next, PCF);

        // TODO: Add 1 or 2 more test cases here (e.g., jumping to 32'h00000020, then asserting reset again)

        #10;
        $finish;
    end

endmodule