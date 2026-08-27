module priorty_encoder4to2(
    input wire  [3:0] in,
    input wire enable,
    output reg [1:0] out,
    output reg valid
);

always @(*) begin
    out = 2'b00;
    valid=1'b0;
    if (enable) begin
        if (in[3]) begin
            out=2'b11;
            valid=1'b1;
        end
        else if (in[2]) begin
            out=2'b10;
            valid=1'b1;
        end
        else if (in[1]) begin 
            out=2'b01;
            valid=1'b1;
            end
            else if (in[0]) begin 
                out=2'b00;
                valid=1'b1;
                end
    end
end

endmodule