module n_bit_subtractor #(
    parameter width = 4)(
        input wire [width-1:0] a,b,
        output wire borrow,
        output wire [width-1:0] diff
);
wire [width:0] result_wire;

assign result_wire = {1'b0,a} + {1'b0,~b} + 1'b1;
assign diff = result_wire[width-1:0];
assign borrow = ~ (result_wire[width]);

endmodule