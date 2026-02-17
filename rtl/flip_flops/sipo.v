module sipo(
    input wire clk,reset,si,
    output reg [7:0] po
);
always @(posedge clk or posedge reset) begin 
    if(reset)
    po<=8'b0;
    else
    po<={po[6:0],si};
end

endmodule