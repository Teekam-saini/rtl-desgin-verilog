module door_lock(
    input wire clk , rst,
    input wire key,
    output reg LOCK, UNLOCK
);

localparam lock = 2'b00 ;
localparam unlock = 2'b01;

reg [1:0] current_State;
reg [1:0] next_state;

always @(posedge clk or posedge rst) begin
    if(rst)
    current_State <= lock;
    else
    current_State <= next_state;
end

always @(*) begin
    case (current_State)
        lock: begin 
            if(key)
            next_state = unlock;
            else
            next_state = lock;
        end 
        unlock:begin
          if(!key)
          next_state = lock;
          else
          next_state = unlock;
        end
        default: next_state = lock; 
    endcase
end

always @(*) begin
    LOCK = 0;
    UNLOCK =0;

    case (current_State)
        lock: LOCK =1;
        unlock: UNLOCK=1;
        
    endcase
end

endmodule