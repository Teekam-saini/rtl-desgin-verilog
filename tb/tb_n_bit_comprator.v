

module tb_n_bit_comprater;

parameter width = 4;

reg [width-1:0] a,b;
wire eq ,gt,lt;



n_bit_comprater #(.width(width) ) dut(  .a(a),.b(b) 
, .eq(eq) , .gt(gt) , .lt(lt)
);

integer pass_count , fail_count;

task check ;

input exp_eq , exp_gt , exp_lt;
input[63:0] test_num;
begin  
    #1;
    if((exp_eq == eq) && (exp_gt == gt) && (exp_lt == lt))begin
    $display("pass[test %0d] | a=%0d | b=%0d | eq=%0d | gt=%0d | lt=%0d",
    test_num ,a,b,eq,gt,lt);
    pass_count+=1;
    end
    else begin
        $display("fail [test%0d] | a=%0d | b=%0d | eq=%0d | gt=%0d | lt=%0d",
        test_num,a,b,eq,gt,lt);
        fail_count +=1;
     end

end

endtask
initial 
     begin
    $dumpfile("tb_n_bit_comprater.vcd");
    $dumpvars(0, tb_n_bit_comprater);
end

initial 
    
 begin 
    pass_count =0 ; fail_count=0;
    a = 4'd2;  b = 4'd5; check(0,0,1,1);
    a = 4'd8;  b = 4'd0; check(0,1,0,2);
    a = 4'd5;  b = 4'd5; check(1,0,0,3);
    a = 4'd15; b = 4'd15; check(1,0,0,4);
    a = 4'd5;  b = 4'd3;  check(0,1,0,5);
    a = 4'd0;  b = 4'd15; check(0,0,1,6);
    a = 4'd7;  b = 4'd8;  check(0,0,1,7);
    $display("------------------------");
    $display("total: %0d passes , %0d failed ",pass_count,fail_count);
    if(fail_count==0)
    $display("all test passed");
    else
    $display("failuere detected");
    
    $finish;

end

endmodule
