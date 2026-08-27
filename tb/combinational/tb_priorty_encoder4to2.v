`timescale 1ns/1ps

module tb_priorty_encoder4to2;

reg [3:0] in;
wire [1:0]out;
wire valid;
reg enable;
priorty_encoder4to2 dut(
    .in(in),
    .out(out),
    .valid(valid),
    .enable(enable)
);

integer pass_count;
integer fail_count;
integer total_count;

task check;
    input [1:0] expected;
    input expected_valid;
    input integer test_num;
    begin
        #1;
        total_count = total_count + 1;

        if (out === expected && valid ===expected_valid) begin
            pass_count = pass_count + 1;
            $display("PASS [Test %0d] in=%b out = %0d valid = %b", test_num,in,out,valid);
        end
        else begin
            fail_count = fail_count + 1;
            $display("FAIL [Test %0d]", test_num);
        end
    end
endtask

initial begin
    $dumpfile("tb_priorty_encoder4to2.vcd");
    $dumpvars(0, tb_priorty_encoder4to2);
end

initial begin
    pass_count = 0;
    fail_count = 0;
    total_count = 0;

    // Test cases

    enable = 1'b1;

    in=4'b0000; check(2'b00,1'b0,1);
    in=4'b0001; check(2'b00,1'b1,2);
    in=4'b0010; check(2'b01,1'b1,3);
    in=4'b0100; check(2'b10,1'b1,4);
    in=4'b1000; check(2'b11,1'b1,5);
    in=4'b0011; check(2'b01,1'b1,6);
    in=4'b0111; check(2'b10,1'b1,7);
    in=4'b1001; check(2'b11,1'b1,8);
    in=4'b1111; check(2'b11,1'b1,9);

    enable = 1'b0;
    in=4'b0000; check(2'b00,1'b0,10);
    in=4'b0001; check(2'b00,1'b0,11);
    in=4'b0010; check(2'b00,1'b0,12);
    in=4'b0100; check(2'b00,1'b0,13);
    in=4'b1000; check(2'b00,1'b0,14);
    in=4'b0011; check(2'b00,1'b0,15);
    in=4'b0111; check(2'b00,1'b0,16);
    in=4'b1001; check(2'b00,1'b0,17);
    in=4'b1111; check(2'b00,1'b0,18);






    $display("----------------------");
    $display("Total  : %0d", total_count);
    $display("Passed : %0d", pass_count);
    $display("Failed : %0d", fail_count);

    $finish;
end

endmodule