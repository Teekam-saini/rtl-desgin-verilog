module tb_n_bit_subtractor;
 parameter width =4;

 reg[width-1:0] a,b;
 wire borrow;
 wire[width-1:0] diff;


n_bit_subtractor #(.width(width)) dut (
    .a(a),.b(b),.borrow(borrow),.diff(diff)
);

integer pass_count , fail_count;

task check;
input [width-1:0] exp_diff;
input exp_borrow;
input [63:0] test_num;

begin
    #1;
    if((diff == exp_diff) && (borrow == exp_borrow) ) begin 
    $display("pass [test %0d]| a=%0d| b=%0d| borrow=%0d| diff=%0d |",
    test_num,a,b,borrow,diff);
    pass_count = pass_count+1;
    end

    else begin
        $display("fail [test %0d]| a=%0d | b=%0d | borrow=%0d | diff=%0d",
    test_num,a,b,borrow,diff);
        fail_count = fail_count +1;
     end
 end

 endtask

initial begin
    $dumpfile("n_bit_subtractor.vcd");
    $dumpvars(0, tb_n_bit_subtractor);
end

initial begin
    pass_count = 0; fail_count=0;
   a = 4'd8; b = 4'd3; check(5,0,1);
   a = 4'd3;  b = 4'd8;  check(4'd11, 1'b1, 2);
   a = 4'd5;  b = 4'd5;  check(4'd0,  1'b0, 3);
   a = 4'd15; b = 4'd15; check(4'd0,  1'b0, 4);
   a = 4'd0;  b = 4'd0;  check(4'd0,  1'b0, 5);
   a = 4'd0;  b = 4'd1;  check(4'd15, 1'b1, 6);
   a = 4'd1;  b = 4'd0;  check(4'd1,  1'b0, 7);
   $display("-------------------------------");
   $display("total: %0d passed, %0d failed",pass_count , fail_count);
   if (fail_count == 0) begin
    $display("all test passed");    
end
else $display("failuere detected");
$finish;

end

endmodule
