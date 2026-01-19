module t_ff_from_jk(
    input wire clk , reset, t,
    output  wire q
);

wire j , k;

assign j = t;
assign k = t;

jk_ff jk_inst(

    .clk(clk),
    .reset(reset),
    .j(j),
    .k(k),
    .q(q)
);



endmodule