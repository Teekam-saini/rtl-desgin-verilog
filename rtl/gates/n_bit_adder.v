module n_bit_adder #(
    parameter  WIDTH = 4 )(
        input wire [WIDTH-1:0] a,b,
        input wire cin,
        output wire [WIDTH-1:0] sum,
        output wire cout
    );

wire [WIDTH:0] result_wire;

assign result_wire = {1'b0,a} + {1'b0,b} + cin;

assign sum = result_wire[WIDTH-1:0];
assign cout = result_wire[WIDTH];

endmodule