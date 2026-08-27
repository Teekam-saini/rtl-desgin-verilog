module tb_n_bit_register;

    reg clk, reset, en;

    reg  [3:0]  d_4;
    reg  [7:0]  d_8;
    reg  [15:0] d_16;

    wire [3:0]  q_4;
    wire [7:0]  q_8;
    wire [15:0] q_16;

    // Instantiate 4-bit register
    reg_param #(.n(4)) reg_4bit (
        .clk(clk),
        .reset(reset),
        .en(en),
        .d(d_4),        // Connect d_4 to module port 'd'
        .q(q_4)         // Connect q_4 to module port 'q'
    );

    // Instantiate 8-bit register
    reg_param #(.n(8)) reg_8bit (
        .clk(clk),
        .reset(reset),
        .en(en),
        .d(d_8),        // Connect d_8 to module port 'd'
        .q(q_8)
    );

    // Instantiate 16-bit register
    reg_param #(.n(16)) reg_16bit (
        .clk(clk),
        .reset(reset),
        .en(en),
        .d(d_16),       // Connect d_16 to module port 'd'
        .q(q_16)
    );

    // Clock generator
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test stimulus
    initial begin
        $dumpfile("parameterized_n_bit_register.vcd");
        $dumpvars(0, tb_n_bit_register);

        $display("Time | rst | en | d_4  | d_8  | d_16 | q_4  | q_8  | q_16");
        $display("--------------------------------------------------------------");
        $monitor("%4t |  %b  | %b | %h   | %h   | %h   | %h   | %h   | %h", 
                 $time, reset, en, d_4, d_8, d_16, q_4, q_8, q_16);

        // Initialize
        reset = 1; en = 0;
        d_4 = 4'h0;
        d_8 = 8'h00;
        d_16 = 16'h0000;
        #10;

        // Release reset
        reset = 0;
        #10;

        // Test 1: Load data with enable=1
      
        en = 1;
        d_4  = 4'hA;        // 4-bit: 1010
        d_8  = 8'h5C;       // 8-bit: 0101_1100
        d_16 = 16'hBEEF;    // 16-bit: 1011_1110_1110_1111
        #10;

        // Test 2: Change data (should load immediately)
        d_4  = 4'hF;
        d_8  = 8'hFF;
        d_16 = 16'hAAAA;
        #10;

        // Test 3: Hold with enable=0
        
        en = 0;
        d_4  = 4'h0;        // Data changes, but registers should HOLD
        d_8  = 8'h00;
        d_16 = 16'h0000;
        #20;                // Hold for 2 clock cycles

        // Test 4: Re-enable and load
       
        en = 1;
        d_4  = 4'h7;
        d_8  = 8'h42;
        d_16 = 16'h1234;
        #10;

        // Test 5: Test maximum values for each width
        
        d_4  = 4'hF;        // Max for 4-bit: 1111
        d_8  = 8'hFF;       // Max for 8-bit: 1111_1111
        d_16 = 16'hFFFF;    // Max for 16-bit
        #10;

        // Test 6: Async reset during operation
       
        d_4  = 4'hA;
        d_8  = 8'hCC;
        d_16 = 16'h9999;
        #5;                 // Mid-cycle
        reset = 1;
        #10;
        reset = 0;
        #10;

        $finish;
    end

endmodule