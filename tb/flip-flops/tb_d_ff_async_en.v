module tb_d_ff_async_en;

reg clk,reset,d,en;
wire q;

d_ff_en dut(

    .clk(clk),
    .d(d),
    .reset(reset),
    .q(q),
    .en(en)

);

initial begin
    clk =0;
    forever #5 clk = ~clk;
end

initial begin 
    $dumpfile("d_ff_en_async.vcd");
    $dumpvars(0,tb_d_ff_async_en);
    en=0; d=0; #10;
    $display("|time | clk | reset | d | q |");
    $display("------------------------------");
    $monitor("%4t  | %b || %b || %b || %b |", $time , clk,reset,d,q);

    en=1;
    d=1; #10; d =0; #10; d =1; #10;
    
    en =0;
    d =0; #10; d =1; #10; d =0; #10;

    en =1;
    reset = 1; d = 1; #10; 
    reset = 1; d = 1; #10; 
    reset = 0; d = 1; #10; 
    reset = 0; d = 1; #10;

    en=0; 
    reset = 1; d = 1; #10; 
    reset = 1; d = 0; #10; 
    reset = 0; d = 0; #10; 
    reset = 1; d = 0; #10; 

    $finish;
    
    

end

endmodule