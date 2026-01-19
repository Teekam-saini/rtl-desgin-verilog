module tb_t_ff_from_jk;

    reg clk, reset, t;
    wire q;

    t_ff_from_jk dut(
        .clk(clk),
        .t(t),
        .reset(reset),
        .q(q)
    );

    initial begin 
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        $dumpfile("t_ff_jk.vcd");
        $dumpvars(0, tb_t_ff_from_jk);
        
        $display("time | clk | reset | t | q |");
        $display("----------------------------");
        $monitor("%4t | %b | %b | %b | %b |", $time, clk, reset, t, q);

        reset = 1; t = 0; #10;
        reset = 0; #10;

        t = 0; #20;
        t = 1; #40;
        t = 0; #20;

        $finish;
    end

endmodule