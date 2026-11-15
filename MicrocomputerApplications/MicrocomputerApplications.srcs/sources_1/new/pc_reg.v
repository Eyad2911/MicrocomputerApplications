
module pc_reg (
    input  wire        clk,
    input  wire        reset,
    input  wire [31:0] pc_next,
    output reg  [31:0] PCF     
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PCF <= 32'b0;
        end else begin
            PCF <= pc_next;
        end
    end

endmodule