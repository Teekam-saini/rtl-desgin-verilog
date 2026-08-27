module airth_unit #(
    parameter width = 8
) (
    input wire [width-1:0] a, b,
    input wire is_sub,
    output wire [width-1:0] result,
    output wire c,
    output wire v
);

    wire [width:0] wide_result;
    wire [width-1:0] b_mux;
    wire cin;

    assign b_mux = is_sub ? ~b : b;
    assign cin = is_sub;

    assign wide_result = {1'b0, a} + {1'b0, b_mux} + cin;

    assign result = wide_result[width-1:0];
    assign c = wide_result[width];
    assign v = a[width-1]==b_mux[width-1]&&result[width-1]!=a[width-1];

endmodule