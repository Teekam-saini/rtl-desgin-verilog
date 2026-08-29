module tb_logic_unit;

    parameter width = 8;

    reg [width-1:0] a, b;
    reg [2:0] op;
    wire [width-1:0] result;

    logic_unit #(
        .width(width)
    ) dut (
        .a(a),
        .b(b),
        .op(op),
        .result(result)
    );

    integer pass_count;
    integer fail_count;

    initial begin
        $dumpfile("logic_unit.vcd");
        $dumpvars(0, tb_logic_unit);
    end

    task check;
        input [width-1:0] exp_result;
        input [8*30-1:0] test_name;

        begin
            #1;

            if (result === exp_result) begin
                pass_count = pass_count + 1;

                $display(
                    "PASS: %0s | op=%b | a=%b | b=%b | result=%b",
                    test_name, op, a, b, result
                );
            end
            else begin
                fail_count = fail_count + 1;

                $display(
                    "FAIL: %0s | op=%b | a=%b | b=%b | Expected=%b | Got=%b",
                    test_name, op, a, b,
                    exp_result, result
                );
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h0;
        check(8'b10001000, "AND");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h1;
        check(8'b11101110, "OR");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h2;
        check(8'b01100110, "XOR");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h3;
        check(8'b01110111, "NAND");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h4;
        check(8'b00010001, "NOR");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h5;
        check(8'b10011001, "XNOR");

        a = 8'b10101010;
        b = 8'b00000000;
        op = 3'h6;
        check(8'b01010101, "NOT");

        a = 8'b10101010;
        b = 8'b11001100;
        op = 3'h7;
        check(8'b00000000, "DEFAULT");

        $display("");
        $display("==============================");
        $display("       TEST SUMMARY");
        $display("==============================");
        $display("Passed : %0d", pass_count);
        $display("Failed : %0d", fail_count);
        $display("Total  : %0d", pass_count + fail_count);
        $display("==============================");

        $finish;
    end

endmodule