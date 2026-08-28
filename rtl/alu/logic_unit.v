module logic_unit #(
    parameter width =8
) (
    input wire[width-1:0] a,b,
    input wire[2:0] op,
    output reg [width-1:0] result
);

always @(*) begin
    case (op)
       3'h0 : result = a&b;//and
       3'h1 : result = a|b;//or
       3'h2 : result = a^b;//xor
       3'h3 : result = ~(a&b);//nand
       3'h4 : result = ~(a|b);//nor
       3'h5 : result = ~(a^b);//xnor
       3'h6 : result = ~a;//not
        default: result = {width{1'b0}};
    endcase
end
    
endmodule