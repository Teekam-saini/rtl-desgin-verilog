module tb_door_lock;

reg clk,rst,key;
wire LOCK,UNLOCK;

door_lock dut(
    .clk(clk),.rst(rst) , .key(key),
    .LOCK(LOCK) , .UNLOCK(UNLOCK)
);

initial begin
    clk =0;
    forever #5 clk = ~clk;
end

initial begin 
    $dumpfile("door_lock.vcd");
    $dumpvars(0,tb_door_lock);
    $display("time | rst | key | lock | unlock | state");
    $display("========================================");
    $monitor("%4t | %b |%b |%b |%b |%b |",
    $time,rst,key,LOCK,UNLOCK,dut.current_State);

    //intilize
    rst =1; key =0;
    #10;
    rst = 0; #10;

    //key inserted
    key=1; #20;
    
    //key removed
    key = 0; #20;

    //rst midway
    key = 1; #10;
    rst=1; #5;
    rst=0;
    #5;

    $finish;

end

endmodule