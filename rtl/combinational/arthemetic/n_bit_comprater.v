module n_bit_comprater #(
    parameter width = 4)(
        input wire [width-1:0] a,b,
        output wire eq,gt,lt
);

assign eq = (a==b);
assign gt = (a>b);
assign lt = (a<b);

endmodule