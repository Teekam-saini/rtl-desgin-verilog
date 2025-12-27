module tb_dff_async;
    reg clk, reset, d;
    wire q;
    
    d_ff dut(
        .clk(clk),
        .reset(reset),
        .d(d),
        .q(q)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test sequence
    initial begin
        $dumpfile("d_flip_flop_async.vcd");
        $dumpvars(0, tb_dff_async);
        
        $display("Time | clk | reset | d | q");
        $display("-----|-----|-------|---|---");
        $monitor("%4t |  %b  |   %b   | %b | %b", $time, clk, reset, d, q);
        
        // Test 1: Initial reset
        reset = 1; d = 0;
        #12;  // Time 12
        
        // Test 2: Release reset, load d=1
        reset = 0; d = 1;
        #10;  // Time 22
        
        // Test 3: KEY TEST - Reset BETWEEN clock edges
        #1;   // Time 23 (clock is LOW here, not at edge)
        reset = 1;  // Activate reset when clk=0
        #10;  // Time 33
        
        // Test 4: Release and continue
        reset = 0; d = 0;
        #10;  // Time 43
        
        d = 1;
        #10;  // Time 53
        
        $finish;
    end
endmodule