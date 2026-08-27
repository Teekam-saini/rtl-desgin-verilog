module tb_d_ff;
    reg clk, d, reset;
    wire q;

    d_flip_flop dut(
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );

    // Clock generation (automatic toggling)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Period = 10 time units
    end

    // Stimulus
    initial begin
        $dumpfile("d_flip_flop.vcd");
        $dumpvars(0, tb_d_ff);
        
        $display("Time | clk | d | reset | q");
        $display("-----|-----|---|-------|---");
        
        // Initialize
        reset = 1; d = 0;
        #10;  // Wait for clock edge
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        // Release reset
        reset = 0; d = 0;
        #10;
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        // Change d to 1
        d = 1;
        #10;
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        // Keep d at 1
        #10;
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        // Change d to 0
        d = 0;
        #10;
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        // Test reset
        reset = 1;
        #10;
        $display("%4t |  %b  | %b |   %b   | %b", $time, clk, d, reset, q);
        
        $finish;
    end

endmodule