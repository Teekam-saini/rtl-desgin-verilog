module tb_sipo;

reg clk,reset,si;
wire [7:0] po;

sipo dut(
    .clk(clk),
    .reset(reset),
    .si(si),
    .po(po)
);

initial begin 
    clk =0;
    forever #5 clk = ~clk;
    end

    initial begin 
        $dumpfile("sipo.vcd");
        $dumpvars(0,tb_sipo);
        $display("Time | clk | rst | si | po |");
        $display("----------------------------");
        $monitor("%4t | %b | %b | %b | %b |",$time,clk,reset,si,po);

        reset = 1; si = 0; #10;

        // release reset
        reset = 0; #10;

        // shift in pattern: 10110111
        si = 1; #10;
        si = 0; #10;
        si = 1; #10;
        si = 1; #10;
        si = 0; #10;
        si = 1; #10;
        si = 1; #10;
        si = 1; #10;

        // shift in zeros to push data out
        repeat (8) begin
            si = 0; #10;
        end

        $finish;
    end

    



endmodule