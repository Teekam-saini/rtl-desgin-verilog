module counter_2bit(
    input wire clk,reset,
    output wire [1:0] q
);

  wire t0,t1;
  assign t0 = 1'b1;
  assign t1 = q[0];

  t_ff ff0(

    .clk(clk),
    .t(t0),
    .reset(reset),
    .q(q[0])
  );

t_ff ff1(
    .clk(clk),
    .t(t1),
    .reset(reset),
    .q(q[1])
);


endmodule