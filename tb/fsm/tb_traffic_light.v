module tb_traffic_light;

reg clk , rst , timer;
wire red , green , yellow;

traffic_light dut(
    .clk(clk), .rst(rst) , .timer(timer),
    .red(red), .green(green), .yellow(yellow)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    $dumpfile("traffic_light.vcd");
    $dumpvars(0,tb_traffic_light);
    $display("time | rst | timer |  R | Y | G | state ");
    $display("========================================");

    rst = 1; timer =0; #10;
    rst = 0 ; #10;
    timer = 1; #10;
    timer = 0; #10;
    timer = 1; #10;
    timer = 0; #10;
    timer = 1; #10;
    timer = 0; #10;
    timer = 1; #10;
    timer = 0; #10;
    timer = 1; #10;
    timer = 0; #10;
    timer = 1; #10;
    timer = 0; #10;

    $finish;

end

always @(posedge clk) begin
    $display("%4t | %b | %b | %b | %b | %b | %s | ",
    $time , rst , timer , red,yellow,green,
    (dut.current_state == 2'b00) ? "RED":
    (dut.current_state == 2'b01) ? "GREEN":
    (dut.current_state == 2'b10) ? "YELLOW":"unkown");
    
end


endmodule