module sr_ff (
    input  wire clk,
    input  wire reset,
    input  wire s,
    input  wire r,
    output reg  q,
    output reg  invalid
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 1'b0;
        invalid <= 1'b0;
    end else begin
        case ({s, r})
            2'b00: begin
                q <= q;
                invalid <= 1'b0;
            end
            2'b01: begin
                q <= 1'b0;
                invalid <= 1'b0;
            end
            2'b10: begin
                q <= 1'b1;
                invalid <= 1'b0;
            end
            2'b11: begin
                q <= 1'bx;
                invalid <= 1'b1;
            end
        endcase
    end
end

endmodule
