module tb_siso;

    reg clk, reset, si;
    wire so;

    siso dut(
        .clk(clk),
        .reset(reset),
        .si(si),
        .so(so)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        $dumpfile("siso.vcd");
        $dumpvars(0, tb_siso);
        $display("Time | clk | rst | si | so | shift_reg");
        $display("---------------------------------------");
        $monitor("%4t | %b | %b | %b | %b | %b",
                 $time, clk, reset, si, so, dut.shift_reg);

        // reset
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
