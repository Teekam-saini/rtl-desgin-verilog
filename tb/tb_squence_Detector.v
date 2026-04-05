//testbench for the desgin squence detector to detect 101 
module tb_squence_detector;

reg clk , rst , in;
wire detected;

squence_detector dut(
    .clk(clk) , .rst(rst) , .in(in),
    .detected(detected)
);

initial begin
    clk=0;
    forever #5 clk=~clk;
end

initial begin
    $dumpfile("squence_detector.vcd");
    $dumpvars(0 , tb_squence_detector);
    $display("time | rst | in | detected | state | patter progerres");
    $display("======================================================");

    rst=1; in=0; #10;
    rst=0; #10;
    in =0; #10;
    in=1; #10;
    in =0; #10;
    in=1; #10;
    in =0; #10;
    in=1; #10;
    in =0; #10;
    in=1; #10;
    
    #20;

    $finish;

end

always @(posedge clk) begin
    $display("%4t | %b | %b | %b | %s | %s |",
    $time,rst,in,detected,
    (dut.current_state == 2'b00) ? "s0":
    (dut.current_state == 2'b01) ? "s1":
    (dut.current_state == 2'b10) ? "s10": "???",
    (dut.current_state == 2'b00) ? "idle":
    (dut.current_state == 2'b01) ? "saw 1":
    (dut.current_state == 2'b10) ? "saw 10": "unkown");

end
endmodule