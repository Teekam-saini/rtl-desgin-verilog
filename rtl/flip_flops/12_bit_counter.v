module div12_bit_counter(
    input wire clk , rst , en , load,
    input wire [3:0] data,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin

    if(rst)
    count <= 4'd0;
    else if (load)
    count <= data;
    else if (en) begin
        if(count == 4'd11 )
        count <= 4'd0;
        else
        count <= count + 1'd1;
    end
    
end

endmodule