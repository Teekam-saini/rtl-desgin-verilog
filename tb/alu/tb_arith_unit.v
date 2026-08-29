module tb_arith_unit;

    parameter width = 8;

    reg [width-1:0] a, b;
    reg is_sub;

    wire [width-1:0] result;
    wire c;
    wire v;



    arith_unit #(.width(width)) dut (
        .a(a),
        .b(b),
        .is_sub(is_sub),
        .result(result),
        .c(c),
        .v(v)
    );


    integer pass_count;
    integer fail_count;


    

    task check;

        input [width-1:0] exp_result;
        input exp_c;
        input exp_v;
        input [159:0] test_name;

        begin

            #1;

            if ((result === exp_result) &&
                (c === exp_c) &&
                (v === exp_v)) begin

                pass_count = pass_count + 1;

                $display(
                    "PASS: %0s | a=%0d b=%0d sub=%b | result=%0d C=%b V=%b",
                    test_name,
                    a, b, is_sub,
                    result, c, v
                );

            end

            else begin

                fail_count = fail_count + 1;

                $display(
                    "FAIL: %0s | a=%0d b=%0d sub=%b | Expected: result=%0d C=%b V=%b | Got: result=%0d C=%b V=%b",
                    test_name,
                    a, b, is_sub,
                    exp_result, exp_c, exp_v,
                    result, c, v
                );

            end

        end

    endtask



    initial begin

        pass_count = 0;
        fail_count = 0;

        
        a = 8'd4;
        b = 8'd3;
        is_sub = 1'b0;
        check(8'd7, 1'b0, 1'b0, "ADD 4 + 3");


       
        a = 8'd255;
        b = 8'd1;
        is_sub = 1'b0;
        check(8'd0, 1'b1, 1'b0, "ADD 255 + 1");


       
        a = 8'd127;
        b = 8'd1;
        is_sub = 1'b0;
        check(8'h80, 1'b0, 1'b1, "ADD signed overflow");


    
        a = 8'd50;
        b = 8'd20;
        is_sub = 1'b0;
        check(8'd70, 1'b0, 1'b0, "ADD 50 + 20");


        
        a = 8'd8;
        b = 8'd3;
        is_sub = 1'b1;
        check(8'd5, 1'b1, 1'b0, "SUB 8 - 3");


        
        a = 8'd10;
        b = 8'd3;
        is_sub = 1'b1;
        check(8'd7, 1'b1, 1'b0, "SUB 10 - 3");


        a = 8'd3;
        b = 8'd8;
        is_sub = 1'b1;
        check(8'd251, 1'b0, 1'b0, "SUB 3 - 8");


        
        a = 8'h80;
        b = 8'd1;
        is_sub = 1'b1;
        check(8'h7F, 1'b1, 1'b1, "SUB signed overflow");


        
        a = 8'd50;
        b = 8'd20;
        is_sub = 1'b1;
        check(8'd30, 1'b1, 1'b0, "SUB 50 - 20");


        

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
    initial begin
        $dumpfile("airth_unit.vcd");
        $dumpvars(0,tb_arith_unit);
        
    end

endmodule