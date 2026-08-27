module demux1to4#(
    parameter width = 8
)(
    input wire [width-1:0] in,
    input wire [1:0] sel,
    output reg [width-1:0] out0,out1,out2,out3 
    );

    always @(*) begin
        
        out0 = {width{1'b0}};
        out1 = {width{1'b0}};
        out2 = {width{1'b0}};
        out3 = {width{1'b0}};

        case (sel)
            2'b00: out0 =in;
            2'b01: out1= in;
            2'b10: out2=in;
            2'b11: out3=in; 
            default: ;
        endcase

    end

endmodule