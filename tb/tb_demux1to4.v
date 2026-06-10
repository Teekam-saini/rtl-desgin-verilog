module tb_demux1to4;

parameter width =8;

reg [width-1:0] in;
reg [1:0] sel;
wire [width-1:0] out0,out1,out2,out3;

demux1to4 #(.width(width)) dut(
    .in(in), .sel(sel), .out0(out0),
    .out1(out1), .out2(out2) , .out3(out3)
);


task check;
input[width-1:0] check_in;
input [1:0] check_sel;

begin
    in = check_in;
    sel=check_sel;

  #1;

  $display("in=%0d,sel=%0d,out0=%0d,out1=%0d,out2=%0d,out3=%0d",in,sel,out0,
  out1,out2,out3);



end

endtask

initial begin
    check(8'd42,2'b00);
    check(8'd42,2'b01);
    check(8'd42,2'b10);
    check(8'd42,2'b11);
    check(8'd55,2'b00);
    check(8'd55,2'b01);
    check(8'd0,2'b11);


end

endmodule