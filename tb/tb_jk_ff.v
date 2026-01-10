
//testbench for jk_ff.v
module tb_jk_ff;

reg clk,j,reset,k;
wire q;

jk_ff dut(
    .clk(clk),
    .j(j),
    .reset(reset),
    .k(k),
    .q(q)

);

initial begin 

    clk = 0;
    forever #5 clk = ~clk;
    
end

initial begin 
    $dumpfile("jk_ff.vcd");
    $dumpvars(0,tb_jk_ff);
    $display("time | clk | reset | j | k | q|");
    $display("-------------------------------");
    $monitor("%4t |  %b  |  %b  | %b | %b | %b ",
            $time, clk , reset , j , k , q);

    //intilize
    reset =1; j=0; k=0; #10;
    reset =0;
    #10;

    //test-1:hold
    j=0; k=0; #20;

    //test-2:set
    j=1; k=0; #20;

    //test-3:reset
    j=0; k=1; #20;

    //test-4:hold again

    j=0; k=0; #20;
    
    //test-5:toggle

    j=1; k=1; #40;

    //test-6:aysnc reset during toggling

    j=1; k=0; #5;
    reset=1;#10;
    reset=0;#10;

    $finish;


end

endmodule