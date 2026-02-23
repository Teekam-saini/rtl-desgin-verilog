module tb_universal_register;

reg clk,reset,si;
reg [1:0] mode;
reg [7:0] pi;
wire [7:0] po;
wire so_left, so_right;

localparam hold = 2'b00;
localparam shift_right = 2'b01;
localparam shift_left = 2'b10;
localparam load = 2'b11;

universal_register dut(
    .clk(clk),
    .reset(reset),
    .mode(mode),
    .si(si),
    .pi(pi),
    .po(po),
    .so_right(so_right),
    .so_left(so_left)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("universal_register.vcd");
    $dumpvars(0,tb_universal_register);
    $display("Time | mode | si | pi       | po       | so_L | so_R");
    $display("----------------------------------------------------");
    $monitor("%4t | %b   | %b  | %b | %b | %b    | %b",
    $time,mode,si,pi,po,so_left,so_right);

    //intilize
    reset=1; mode = hold; si=0; pi=8'b0; #10;

    reset=0;
    #10;

    //test-1 parllel load

    pi = 8'b10110011;
    mode = load;
    #10;

    //test-2 hold

    mode = hold;
    pi = 8'b11111111;
    #20;

    //test-3 shift right (si=1 then si = 0)

    mode =  shift_right;
    si =1; #10;
    si=0; #10;
    si=1; #10;

    //test-4 reload and shift left
    mode = load;
    pi = 8'b10110011;
    #10;
    mode = shift_left;
    si=1; #10;
    si=0; #10;
    si=1; #10;

    //test-5 shift right multiple times

    mode = load;

    pi = 8'b10110011;

    #10;

    mode = shift_right;
    si = 0;
    repeat(8) #10;

    $finish;




end


endmodule