module reg_param #(
    parameter n = 8     // No semicolon here!
)(
    input wire clk, reset, en,
    input wire [n-1:0] d,
    output reg [n-1:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= {n{1'b0}};
        else if (en)
            q <= d;
        else
            q <= q;
    end

endmodule