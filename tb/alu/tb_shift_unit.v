module tb_shift_unit;

    parameter width = 8;

    reg [width-1:0] a;
    reg is_right;
    wire c;
    wire [width-1:0] result;

    shift_unit #(
        .width(width)
    ) dut (
        .a(a),
        
        .result(result),
        .is_right(is_right),
        .c(c)
    );

    integer pass_count;
    integer fail_count;

    initial begin
        $dumpfile("shift_unit.vcd");
        $dumpvars(0, tb_shift_unit);
    end

    task check;
        input [width-1:0] exp_result;
        input exp_carry;
        input [8*30-1:0] test_name;

        begin
            #1;

            if (result === exp_result) begin
                pass_count = pass_count + 1;
                $display(
                    "PASS: %0s | a=%0d c=%0d | result=%b",
                    test_name,a,c, result
                );
            end
            else begin
                fail_count = fail_count + 1;
                $display(
                    "FAIL: %0s | Expected=%b | Got=%b",
                    test_name, exp_result, result
                );
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;

        
        a = 8'b10110110;
is_right = 1'b0;
check(8'b01101100, 1'b1, "SHL normal");

a = 8'b10110110;
is_right = 1'b1;
check(8'b01011011, 1'b0, "SHR normal");

a = 8'b10000001;
is_right = 1'b0;
check(8'b00000010, 1'b1, "SHL MSB 1");

a = 8'b10000001;
is_right = 1'b1;
check(8'b01000000, 1'b1, "SHR LSB 1");

a = 8'b00000001;
is_right = 1'b0;
check(8'b00000010, 1'b0, "SHL LSB 1");

a = 8'b10000000;
is_right = 1'b1;
check(8'b01000000, 1'b0, "SHR MSB 1");

a = 8'b11111111;
is_right = 1'b0;
check(8'b11111110, 1'b1, "SHL all ones");

a = 8'b11111111;
is_right = 1'b1;
check(8'b01111111, 1'b1, "SHR all ones");

a = 8'b00000000;
is_right = 1'b0;
check(8'b00000000, 1'b0, "SHL zero");

a = 8'b00000000;
is_right = 1'b1;
check(8'b00000000, 1'b0, "SHR zero");

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