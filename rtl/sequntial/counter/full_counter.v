// full counter with all feauters . 
// it can load value and can wrap around.
// it can count till n.
//it can count up and down.
module full_counter #(
    parameter n = 100 
)(
    input wire clk, rst, 
    input wire en, load, updown,
    input wire [$clog2(n)-1:0] data,
    output reg [$clog2(n)-1:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 0;
    end
    else if (load) begin 
        count <= (data < n) ? data : 0;  // safe load
    end
    else if (en) begin 
        if (updown) begin
            // COUNT UP
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end 
        else begin
            // COUNT DOWN
            if (count == 0)
                count <= n-1;
            else
                count <= count - 1;
        end
    end
end

endmodule