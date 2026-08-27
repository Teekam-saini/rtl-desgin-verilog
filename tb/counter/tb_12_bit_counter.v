module tb_12_bit_counter;

reg clk, rst , en , load;
reg [3:0] data;
wire [3:0] count;

div12_bit_counter dut(
    .clk(clk),
    .rst(rst),
    .en(en),
    .load(load),
    .data(data),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;

end
initial begin
    $dumpfile("12_bit_counter.vcd");
    $dumpvars(0,tb_12_bit_counter);
    $display("time | rst | en | load | data | count | ");
    $display("---------------------------------------");
    $monitor("%4t | %3d | %3d | %3d | %3d | %3d |",$time,rst,en,load,data,count);

    //intilize
    
    rst =1 ; en = 1 ; load = 0 ; data =4'd8;
    #10;
    
    rst=0;
    #10;
    
    //count up
    
    en = 1 ; load = 0; data = 4'd8;
    #50;
    
    //disable enable
    
    en = 0 ; load = 0; data = 4'd8;
    #50;
    
    //load the value
    
    en = 0; load = 1; data = 4'd8;
    #50;
    
    //enable again
    
    en = 1; load = 0; data = 4'd8;

    #95;
    
    //async reset 
    rst = 1; load = 1 ; en = 1; data = 4'd5;
    #20;
    
    $finish;

end

endmodule