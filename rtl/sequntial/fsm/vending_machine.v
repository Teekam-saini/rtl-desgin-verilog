//vending machine desgin.

module vending_machine(
    input wire clk, rst,
    input wire [1:0] coin,
    output reg [5:0] change,
    output reg item
);

localparam NO_COIN  = 2'b00;
localparam FIVE     = 2'b01;
localparam TEN      = 2'b10;
localparam FIFTEEN  = 2'b11;

localparam S_IDLE  = 1'b0;
localparam S_ITEM  = 1'b1;

reg current_state, next_state;
reg [5:0] amount, next_amount;
reg [5:0] final_amount;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_state <= S_IDLE;
        amount <= 6'd0;
        final_amount <= 6'd0;
    end else begin
        current_state <= next_state;
        amount <= next_amount;

        if (next_state == S_ITEM)
            final_amount <= next_amount;
    end
end

always @(*) begin
    next_state  = current_state;
    next_amount = amount;

    case (current_state)

        S_IDLE: begin
            case (coin)
                NO_COIN:   next_amount = amount;
                FIVE:      next_amount = amount + 6'd5;
                TEN:       next_amount = amount + 6'd10;
                FIFTEEN:   next_amount = amount + 6'd15;
            endcase

            if (next_amount >= 6'd15 && coin == NO_COIN)
                next_state = S_ITEM;
        end

        S_ITEM: begin
            next_state  = S_IDLE;
            next_amount = 6'd0;
        end

    endcase
end

always @(*) begin
    item   = 0;
    change = 0;

    case (current_state)

        S_IDLE: begin
            item = 0;
            change = 0;
        end

        S_ITEM: begin
            item = 1;
            change = final_amount - 6'd15;
        end

    endcase
end

endmodule