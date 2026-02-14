module siso(
    input  wire clk,
    input  wire reset,
    input  wire si,
    output reg  so
);

    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            so        <= 1'b0;
        end else begin
            shift_reg <= {shift_reg[6:0], si}; // shift left, insert si at LSB
            so        <= shift_reg[7];          // output MSB
        end
    end

endmodule
