module tb_and_gate;
reg a,b,c;
wire y;

and_gate dut(
    .a(a),
    .b(b),
    .c(c),
    .y(y)
);

initial begin
    $dumpfile("and_gate.vcd");
    $dumpvars(0,tb_and_gate);
    $display("time | a | b | c | y");
    $display("---------------------");


    a=0; b = 0; c = 0; #10;
    $display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=0; b = 0; c = 1; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=0; b = 1; c = 0; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=0; b = 1; c = 1; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=1; b = 0; c = 0; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=1; b = 0; c = 1; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=1; b = 1; c = 0; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    a=1; b = 1; c = 1; #10;$display("%4t | %b | %b | %b |%b", $time, a, b,c, y);
    
end

endmodule