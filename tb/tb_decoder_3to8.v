

module tb_decoder_3to8;

reg [2:0] in;
reg enable;
wire [7:0] out;

decoder_3to8 dut
(
    .in(in),.enable(enable),.out(out)
);

integer pass_count, fail_count;
task check;
input [7:0] expected_out;
input [35:0] test_num;
begin
  #1;
  if (out===expected_out) begin
    $display("pass [test %0d] , in = %b , out =%0d",test_num,in,out);
    pass_count+=1;
  end
  else begin 
    $display("fail[test %0d],in=%b,out=%0d",test_num,in,out);
    fail_count+=1;
  end
end 


endtask

initial begin
    $dumpfile("tb_decoder_3to8.vcd");
    $dumpvars(0, tb_decoder_3to8);
end

initial begin
    pass_count=0;
    fail_count=0;

    enable=1'b1;

    in = 3'b000; check(8'b00000001,1);
    in = 3'b001; check(8'b00000010,2);
    in = 3'b010; check(8'b00000100,3);
    in = 3'b011; check(8'b00001000,4);
    in = 3'b100; check(8'b00010000,5);
    in = 3'b101; check(8'b00100000,6);
    in = 3'b110; check(8'b01000000,7);
    in = 3'b111; check(8'b10000000,8);
    
    enable=1'b0;

    in = 3'b000; check(8'b00000000,9);
    in = 3'b001; check(8'b00000000,10);
    in = 3'b010; check(8'b00000000,11);
    in = 3'b011; check(8'b00000000,12);
    in = 3'b100; check(8'b00000000,13);
    in = 3'b101; check(8'b00000000,14);
    in = 3'b110; check(8'b00000000,15);
    in = 3'b111; check(8'b00000000,16);

    $display("---------------------");
    $display("total %d passed , %d failed",pass_count,fail_count);
    if (fail_count == 0) begin
        $display("all test passed");
    end
    else
    $display("failure detected");
   
end

endmodule
