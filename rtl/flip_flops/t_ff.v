module t_ff(
    input  wire clk,reset,t,
    output  reg q
);

always @(posedge clk or posedge reset) begin
    if (reset)
    q <= 1'b0;
    else if (t)
    q <= ~q;
    else 
    q<=q;


end

endmodule