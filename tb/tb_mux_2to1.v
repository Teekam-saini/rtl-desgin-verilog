module tb_mux2to1;

parameter width =8;

reg [width-1:0] in0 , in1;
reg  sel;
wire [width-1:0] out;

mux_2to1 #(.width(width)) dut(
.in0(in0), .in1(in1) , .sel(sel),.out(out)

);

integer pass_count , fail;

task check;

input [width-1:0] expected;
input [63:0] test_number;

begin #1;
  
  if (out === expected) begin
    $display("pass [test %0d] sel=%b out=%0d (expected %0d)",
    test_number,sel,out,expected);
    pass_count = pass_count + 1;

  end else begin
    $display("fail [test %0d] sel=%b out=%0d (expected %0d)",
    test_number,sel,out,expected);
    fail=fail +1;
   end


end


endtask

initial begin
    pass_count = 0;
    fail = 0;

    in0 = 8'd12;
    in1 = 8'd69;

    sel = 2'b00; check(in0,1);
    sel = 2'b01; check(in1,2);

    in0=8'd77;
    sel = 2'b00; check(8'd77,3);

    in0= 8'd0;
    in1= 8'd255;

    sel=2'b00; check(8'd0 , 4);
    sel=2'b01; check(8'd255, 5);

    $display("===============");

    $display("total %0d passed, %0d failed ",pass_count,fail);
    if(fail==0)
    $display("all test passed");
    else
    $display("failuere detected");
    $finish;

end

initial begin
    $dumpfile("mux_2to1.vcd");
    $dumpvars(0,tb_mux2to1);
end


endmodule