module tb_sr_ff;

reg clk, reset, s, r;
wire q, invalid;

sr_ff dut (
    .clk(clk),
    .reset(reset),
    .s(s),
    .r(r),
    .q(q),
    .invalid(invalid)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("sr_ff.vcd");
    $dumpvars(0, tb_sr_ff);
    $display("Time | clk | rst | s | r | q | invalid");
    $display("--------------------------------------");
    $monitor("%4t |  %b  |  %b  | %b | %b | %b |    %b",
             $time, clk, reset, s, r, q, invalid);

    reset = 1; s = 0; r = 0;
    #10;
    reset = 0; #10;

    s=0; r=0; #20;   // hold
    s=0; r=1; #20;   // reset
    s=1; r=0; #20;   // set
    s=0; r=0; #20;   // hold

    $display("warning");
    s=1; r=1; #20;   // forbidden

    s=0; r=0; #20;   // recovery

    s=1; r=0; #5;
    reset=1; #10;
    reset=0; #10;

    $finish;
end

endmodule
