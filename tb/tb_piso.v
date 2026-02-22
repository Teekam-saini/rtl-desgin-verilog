module tb_piso;
    reg clk,reset,load;
    reg [7:0] pi;
    wire so;
    


piso dut(
.clk(clk),
.reset(reset),
.load(load),
.pi(pi),
.so(so)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    $dumpfile("piso.vcd");
    $dumpvars(0,tb_piso);
    $display("Time | rst | load | pi       | so | shift_reg");
    $display("---------------------------------------------");
    $monitor("%4t |  %b  |  %b   | %b | %b  | %b", 
                 $time, reset, load, pi, so, dut.shift_reg);
    
    //reset 

    reset = 1;
    load = 0; #10;
    

    //realse reset
    reset = 0; #10;

    //load pi
    pi = 8'b10110011;
    #10;
    //load values
    load =1; #10;


    load =0; #80;
    $finish;
end


endmodule