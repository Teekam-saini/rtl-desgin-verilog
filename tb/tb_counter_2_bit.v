module tb_counter_2bit;

reg clk,reset;
wire [1:0] q;

counter_2bit dut(

    .clk(clk),
    .reset(reset),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    
    $dumpfile("counter_2_bit.vcd");
    $dumpvars(0,tb_counter_2bit);

    $display("Time | rst | q[1:0] | Decimal");
    $display("--------------------------------");
    $monitor("%4t |  %b  |   %b    |    %d", $time, reset, q, q);

    reset = 1; #10;
    reset =0;
    #90;
    $finish;

end

endmodule