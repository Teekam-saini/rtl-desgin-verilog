module n_bit_adder #(
    parameter width = 4 )(
        input wire [width-1:0] a,b,
        input wire cin,
        output wire [width-1:0] sum,
        output wire cout
    );

wire [width:0] result_wire;

assign result_wire = {1'b0,a} + {1'b0,b} + cin;

assign sum = result_wire[width-1:0];
assign cout = result_wire[width];

endmodule