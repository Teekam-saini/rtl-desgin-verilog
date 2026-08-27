module mux(
    input wire a,
    input wire b,
    input wire sel,
    output reg y
);

    always @(*) begin
        if (sel)
            y = b;
        else
            y = a;
    end

endmodule


module tb_mux;
    reg a, b, sel;
    wire y;

    mux dut(
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );
    
    initial begin
        $dumpfile("mux.vcd");
        $dumpvars(0, tb_mux);
        
        $display("test started");
        $display("time | a | b | sel | y");
        $display("______________________|");
        
        a = 0; b = 0; sel = 0; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 0; b = 0; sel = 1; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 0; b = 1; sel = 0; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 0; b = 1; sel = 1; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 1; b = 0; sel = 0; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 1; b = 0; sel = 1; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 1; b = 1; sel = 0; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        a = 1; b = 1; sel = 1; #10;
        $display("|%4t | %b | %b | %b   | %b|", $time, a, b, sel, y);
        
        $display("test completed");
        $finish;
    end

endmodule