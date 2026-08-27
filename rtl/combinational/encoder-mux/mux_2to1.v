module mux_2to1#(
    parameter width = 8
   )(
        input wire [width-1:0] in0,in1,
        input wire sel,
        output wire [width-1:0] out
    );
    assign out = sel ? in1 : in0;



endmodule