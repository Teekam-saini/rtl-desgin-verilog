//testbench of or gate
module tb_or_gate;
reg a;
reg b;
wire y;

or_gate dut(
    .a(a),
    .b(b),
    .y(y)
);

initial begin
    $dumpfile("or_gate.vcd");
    $dumpvars(0, tb_or_gate);

    $display("time | a | b | y");
    $display("----------------");

    a = 0; b = 0; #10;
    $display("%4t | %b | %b | %b", $time, a, b, y);

    a = 0; b = 1; #10;
    $display("%4t | %b | %b | %b", $time, a, b, y);

    a = 1; b = 0; #10;
    $display("%4t | %b | %b | %b", $time, a, b, y);

    a = 1; b = 1; #10;
    $display("%4t | %b | %b | %b", $time, a, b, y);

    $display("test completed");
    $finish;
end

endmodule
