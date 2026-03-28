module tb_full_counter;

reg clk , rst, load , en , updown;
reg [6:0] data;
wire [6:0] count;

full_counter dut(
    .clk(clk) , .rst(rst) , .load(load) , .en(en) , .updown(updown),
    .data(data) , .count(count)
);

initial begin 
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 

    $dumpfile("full_counter.vcd");
    $dumpvars(0,tb_full_counter);
    $display("time | rst | load | en | updown | data | count |");
    $display("-------------------------------------------------");
    $monitor("%4t | %d |%d |%d |%d |%d |%d |",$time,rst,load,en,updown,data,count);

    rst = 1; en = 0; load = 0 ; data = 0; updown = 0;
    #10;

    rst =0;
    #10;

    
    en = 1; load =0 ; updown =1;
    #70;

    load = 1; data = 7'd15; 
    #30;

    en=0; load =0; 
    #20;

    en = 1; updown = 0;
    #30;

    load = 1; data = 7'd95; updown =1;
    #50;

    load = 0;
    #50;

    load = 1; data = 7'd0; updown = 0; 
    #70;
    load = 0; #70;
    rst=1;
    #20;





    $finish;


end

endmodule