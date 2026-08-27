module piso(
    input wire clk,reset,load,
    input wire [7:0] pi,
    output wire so
);

reg [7:0] shift_reg;

always @(posedge clk or posedge reset) begin 
    if(reset)
    shift_reg <= 8'b0;
    else if (load)
    shift_reg <= pi;
    else
    shift_reg <= {shift_reg[6:0],1'b0};
end

assign so = shift_reg[7];

endmodule