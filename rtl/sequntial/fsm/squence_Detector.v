// a squence detector which detects the patter 101 and use melay transition 
//and overlaping patter recognistion

module squence_detector(
    input wire clk , rst,
    input wire in,
    output reg detected
);

localparam s0 = 2'b00;
localparam s1 = 2'b01;
localparam s10 = 2'b10;

reg [1:0] current_state , next_state;

always @(posedge clk or posedge rst) begin
    if(rst)
    current_state<=s0;
    else
    current_state<=next_state;

end

always @(*) begin
    case (current_state)
       s0 : begin
         if (in) begin
            next_state = s1;
         end
         else
         next_state = s0;
       end 
       s1: begin
         if (in) begin
            next_state = s1;
         end
         else
         next_state = s10;
       end
       s10: begin
         if (in) begin
            next_state = s1;
         end
         else
         next_state = s0;
       end
        default: next_state = s0;
    endcase
end

always @(*) begin
    if (current_state==s10 && in == 1) begin
        detected = 1;
    end
    else
    detected=0;
end
endmodule