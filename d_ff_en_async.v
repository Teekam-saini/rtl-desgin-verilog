module d_ff_en(
    input wire clk ,
    input wire d ,
    input wire reset ,
    input wire en,
    output reg q
);



always @(posedge clk or posedge reset) begin
    if (reset)
    q <=0;
    else if (en)
    q<=d;
    else
    q<=q;
    
end



endmodule