module shift_unit #(
    parameter width = 8
) (
    input wire [width-1:0]a,
    input wire is_right,
    output reg [width-1:0] result,
    output reg c
);

always @(*) begin
    if (is_right==0) begin
        result = a<<1;
        c=a[width-1];
    end
    else begin
        result = a>>1;
        c=a[0];
    end
end


endmodule