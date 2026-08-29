// OPCODE TABLE
// 4'h0 = ADD   4'h4 = XOR   4'h8 = NOT
// 4'h1 = SUB   4'h5 = XNOR  4'h9 = SHL
// 4'h2 = AND   4'h6 = NAND  4'hA = SHR
// 4'h3 = OR    4'h7 = NOR   4'hB = CMP

module tb_alu;

    parameter width = 8;

    reg [width-1:0] a, b;
    reg [3:0] opcode;

    wire [width-1:0] result;
    wire c, v, z, n;

    localparam ADD  = 4'h0;
    localparam SUB  = 4'h1;
    localparam AND  = 4'h2;
    localparam OR   = 4'h3;
    localparam XOR  = 4'h4;
    localparam XNOR = 4'h5;
    localparam NAND = 4'h6;
    localparam NOR  = 4'h7;
    localparam NOT  = 4'h8;
    localparam SHL  = 4'h9;
    localparam SHR  = 4'hA;
    localparam CMP  = 4'hB;

    integer pass_count;
    integer fail_count;

    alu #(
        .width(width)
    ) dut (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .c(c),
        .v(v),
        .z(z),
        .n(n)
    );

    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, tb_alu);
    end

    function [8*5-1:0] opcode_name;
        input [3:0] op;

        begin
            case (op)
                ADD:  opcode_name = "ADD";
                SUB:  opcode_name = "SUB";
                AND:  opcode_name = "AND";
                OR:   opcode_name = "OR";
                XOR:  opcode_name = "XOR";
                XNOR: opcode_name = "XNOR";
                NAND: opcode_name = "NAND";
                NOR:  opcode_name = "NOR";
                NOT:  opcode_name = "NOT";
                SHL:  opcode_name = "SHL";
                SHR:  opcode_name = "SHR";
                CMP:  opcode_name = "CMP";
                default: opcode_name = "UNK";
            endcase
        end
    endfunction

    task check;

        input [width-1:0] exp_result;
        input exp_c;
        input exp_v;
        input exp_z;
        input exp_n;
        input [8*30-1:0] test_name;

        begin

            #1;

            if ((result === exp_result) &&
                (c === exp_c) &&
                (v === exp_v) &&
                (z === exp_z) &&
                (n === exp_n)) begin

                pass_count = pass_count + 1;

                $display(
                    "PASS | %-8s | %-30s | A=%02h B=%02h | R=%02h | C=%b V=%b Z=%b N=%b",
                    opcode_name(opcode),
                    test_name,
                    a,
                    b,
                    result,
                    c,
                    v,
                    z,
                    n
                );

            end

            else begin

                fail_count = fail_count + 1;

                $display(
                    "FAIL | %-8s | %-30s | A=%02h B=%02h",
                    opcode_name(opcode),
                    test_name,
                    a,
                    b
                );

                $display(
                    "     | Expected: R=%02h C=%b V=%b Z=%b N=%b",
                    exp_result,
                    exp_c,
                    exp_v,
                    exp_z,
                    exp_n
                );

                $display(
                    "     | Got:      R=%02h C=%b V=%b Z=%b N=%b",
                    result,
                    c,
                    v,
                    z,
                    n
                );

            end

        end

    endtask


    initial begin

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("==============================================================");
        $display("                     ALU VERIFICATION");
        $display("==============================================================");
        $display("  OP       TEST                           A    B    R   FLAGS");
        $display("--------------------------------------------------------------");


        // ADD

        a = 8'd4;
        b = 8'd3;
        opcode = ADD;
        check(8'd7, 0, 0, 0, 0, "4 + 3");


        a = 8'd255;
        b = 8'd1;
        opcode = ADD;
        check(8'd0, 1, 0, 1, 0, "Carry generation");


        a = 8'd127;
        b = 8'd1;
        opcode = ADD;
        check(8'h80, 0, 1, 0, 1, "Signed overflow");


        a = 8'd0;
        b = 8'd0;
        opcode = ADD;
        check(8'd0, 0, 0, 1, 0, "Zero result");


        // SUB

        a = 8'd8;
        b = 8'd3;
        opcode = SUB;
        check(8'd5, 1, 0, 0, 0, "8 - 3");


        a = 8'd3;
        b = 8'd8;
        opcode = SUB;
        check(8'hFB, 0, 0, 0, 1, "3 - 8");


        a = 8'h80;
        b = 8'd1;
        opcode = SUB;
        check(8'h7F, 1, 1, 0, 0, "Signed overflow");


        a = 8'd10;
        b = 8'd10;
        opcode = SUB;
        check(8'd0, 1, 0, 1, 0, "Equal subtraction");


        // AND

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = AND;
        check(8'b10001000, 0, 0, 0, 1, "Basic AND");


        a = 8'hFF;
        b = 8'h00;
        opcode = AND;
        check(8'h00, 0, 0, 1, 0, "AND zero");


        // OR

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = OR;
        check(8'b11101110, 0, 0, 0, 1, "Basic OR");


        a = 8'h00;
        b = 8'h00;
        opcode = OR;
        check(8'h00, 0, 0, 1, 0, "OR zero");


        // XOR

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = XOR;
        check(8'b01100110, 0, 0, 0, 0, "Basic XOR");


        a = 8'hAA;
        b = 8'hAA;
        opcode = XOR;
        check(8'h00, 0, 0, 1, 0, "XOR equal");


        // XNOR

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = XNOR;
        check(8'b10011001, 0, 0, 0, 1, "Basic XNOR");


        a = 8'hAA;
        b = 8'hAA;
        opcode = XNOR;
        check(8'hFF, 0, 0, 0, 1, "XNOR equal");


        // NAND

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = NAND;
        check(8'b01110111, 0, 0, 0, 0, "Basic NAND");


        // NOR

        a = 8'b10101010;
        b = 8'b11001100;
        opcode = NOR;
        check(8'b00010001, 0, 0, 0, 0, "Basic NOR");


        a = 8'h00;
        b = 8'h00;
        opcode = NOR;
        check(8'hFF, 0, 0, 0, 1, "NOR zero inputs");


        // NOT

        a = 8'b10101010;
        b = 8'b00000000;
        opcode = NOT;
        check(8'b01010101, 0, 0, 0, 0, "NOT");


        a = 8'h00;
        b = 8'h00;
        opcode = NOT;
        check(8'hFF, 0, 0, 0, 1, "NOT zero");


        // SHL

        a = 8'b10110110;
        b = 8'h00;
        opcode = SHL;
        check(8'b01101100, 1, 0, 0, 0, "Shift left");


        a = 8'b10000000;
        b = 8'h00;
        opcode = SHL;
        check(8'b00000000, 1, 0, 1, 0, "Shift left MSB");


        // SHR

        a = 8'b10110110;
        b = 8'h00;
        opcode = SHR;
        check(8'b01011011, 0, 0, 0, 0, "Shift right");


        a = 8'b00000001;
        b = 8'h00;
        opcode = SHR;
        check(8'b00000000, 1, 0, 1, 0, "Shift right LSB");


        // CMP

        a = 8'd10;
        b = 8'd10;
        opcode = CMP;
        check(8'd0, 1, 0, 1, 0, "Equal");


        a = 8'd10;
        b = 8'd5;
        opcode = CMP;
        check(8'd0, 1, 0, 0, 0, "A greater than B");


        a = 8'd5;
        b = 8'd10;
        opcode = CMP;
        check(8'd0, 0, 0, 0, 1, "A less than B");


        a = 8'h80;
        b = 8'h01;
        opcode = CMP;
        check(8'd0, 1, 1, 0, 0, "CMP signed overflow");


        $display("");
        $display("==============================================================");
        $display("                       TEST SUMMARY");
        $display("==============================================================");
        $display("  Passed : %0d", pass_count);
        $display("  Failed : %0d", fail_count);
        $display("  Total  : %0d", pass_count + fail_count);
        $display("==============================================================");

        if (fail_count == 0)
            $display("  STATUS : ALL TESTS PASSED");
        else
            $display("  STATUS : TESTS FAILED");

        $display("==============================================================");
        $display("");

        $finish;

    end

endmodule