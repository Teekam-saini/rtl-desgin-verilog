// a traffic light controller with moore fsm

module traffic_light(
    input wire clk , rst, timer , 
    output reg red , green , yellow

);

localparam RED = 2'b00;
localparam GREEN = 2'b01;
localparam YELLOW = 2'b10;

reg [1:0] current_state , next_state;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= RED;

    end
    else
    current_state<=next_state;

end

always @(*) begin
    case (current_state)
        RED:next_state = (timer) ? GREEN : RED;
        GREEN: next_state = (timer) ? YELLOW: GREEN;
        YELLOW: next_state = (timer) ? RED : YELLOW;
        default: next_state = RED;
    endcase
end

always @(*) begin
    red = 0 ; yellow = 0 ; green = 0;

    case(current_state) 
    RED: red=1;
    YELLOW: yellow=1;
    GREEN: green=1;

    endcase
end


endmodule