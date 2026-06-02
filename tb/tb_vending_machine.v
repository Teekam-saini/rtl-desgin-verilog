// writing a testbench for vending machine desgin.



module tb_vending_machine;
reg clk;
reg rst;
reg [1:0] coin;
wire [5:0] change;
wire item;

 
vending_machine dut (
    .rst(rst),
    .clk(clk),
    .coin(coin), .change(change),
    .item(item)
);

localparam no_coin = 2'b00 ;
localparam five = 2'b01 ;
localparam ten = 2'b10 ;
localparam fifteen = 2'b11 ;

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $dumpfile("tb_vending_mchine.vcd");
    $dumpvars(0, tb_vending_machine);
    $display("time | coin | amount | item | change |");
    $display("======================================");
end

initial begin
   rst = 1; coin = no_coin; #12;
   rst = 0; #10;

   //test - 1 exact change
   coin = fifteen; #10;
   coin = no_coin; #12;

   //test-2 multiple coins
   coin=no_coin; #10;
   coin = ten; #10;
   coin = five; #10;
   coin = no_coin; #12;

   //test -3
   coin = five; #10;
   coin = ten; #10;
   coin = five; #10;
   coin = no_coin; #12;

   // test-4
   coin=no_coin; #10;
   coin = five; #10;
   coin = five; #10;
   coin = five; #10;
   coin = five; #10;
   coin = five; #10;
   coin = no_coin; #12;

   #20;  
   $finish;



end

always @(posedge clk) begin
    $display("%4t | %s | %2d$ | %b | %2d$",
    $time,
    (coin == no_coin) ? "noone":
    (coin == five)? "5$":
    (coin == ten) ? "10$":
    (coin == fifteen) ? "15$": "????",
    dut.amount, item , change
    );
end

endmodule
