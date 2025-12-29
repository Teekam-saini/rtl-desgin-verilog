module d_ff(
    input wire clk,
    input wire d,
    input wire reset,
    output reg q
);
always @(posedge clk or posedge reset) begin
    if (reset)
    q <=0;
    else
    q <=d;
end

endmodule