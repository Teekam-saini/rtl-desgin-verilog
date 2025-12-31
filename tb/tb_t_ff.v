module tb_t_ff;
    reg clk, reset, t;
    wire q;

    t_ff dut(
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

   initial begin 
    clk =0;
    forever #5 clk = ~clk;
   end
    initial begin
        $dumpfile("t_ff.vcd");
        $dumpvars(0, tb_t_ff);

        $display("|TIME |clk |rst |t |q |");
        $display("---------------------------");
        $monitor("|%4t | %b | %b | %b | %b |", $time, clk, reset, t, q);

        // initialize
        reset = 1; t = 0; #10;
        reset = 0; #15;

        // test 1 toggle 
        t = 1; #80;
        // test 2 hold the value
        t = 0; #40;
        // test 3 toggle again
        t = 1; #40;
        // test 4 toggle and async reset in mid cycle
        t = 1; #15; reset = 1; #10; reset = 0; #30;

        $finish;
    end
endmodule
