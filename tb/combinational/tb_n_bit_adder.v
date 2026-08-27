// FILE: tb_adder_n.v
`timescale 1ns/1ps

module tb_n_bit_adder;

    parameter WIDTH = 4;   // small width — easy to hand-verify every case

    reg  [WIDTH-1:0] a, b;
    reg              cin;
    wire [WIDTH-1:0] sum;
    wire             cout;

    n_bit_adder #(.WIDTH(WIDTH)) dut (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );

    integer pass_count, fail_count;

    task check;
        input [WIDTH-1:0] exp_sum;
        input              exp_cout;
        input [63:0]       test_num;
        begin
            #1;
            if (sum === exp_sum && cout === exp_cout) begin
                $display("PASS [Test %0d]| a=%0d| b=%0d| cin=%b| sum=%0d| cout=%b",
                         test_num, a, b, cin, sum, cout);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL [Test %0d]| a=%0d| b=%0d| cin=%b| | sum=%0d(exp %0d)| cout=%b(exp %b)",
                         test_num, a, b, cin, sum, exp_sum, cout, exp_cout);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        pass_count = 0; fail_count = 0;

        // Simple addition, no carry expected
        a=4'd2;  b=4'd3;  cin=0; check(4'd5,  1'b0, 1);

        // Addition that exactly fills 4 bits, no overflow
        a=4'd7;  b=4'd8;  cin=0; check(4'd15, 1'b0, 2);

        // Addition that overflows 4 bits -> carry must be 1
        // 15 + 1 = 16 -> doesn't fit in 4 bits -> wraps to 0, cout=1
        a=4'd15; b=4'd1;  cin=0; check(4'd0,  1'b1, 3);

        // cin=1 pushes a result into overflow that wouldn't otherwise
        a=4'd15; b=4'd0;  cin=1; check(4'd0,  1'b1, 4);

        // Max + Max -> definitely overflows
        a=4'd15; b=4'd15; cin=1; check(4'd15, 1'b1, 5);

        // Zero case
        a=4'd0;  b=4'd0;  cin=0; check(4'd0,  1'b0, 6);

        $display("----------------------------");
        $display("TOTAL: %0d passed, %0d failed", pass_count, fail_count);
        if (fail_count == 0) $display("ALL TESTS PASSED");
        else $display("FAILURE DETECTED");

        $finish;
    end

    initial begin
        $dumpfile("n_bit_adder.vcd");
        $dumpvars(0, tb_n_bit_adder);
    end

endmodule