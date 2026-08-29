module alu #(
    parameter width = 8
) (
    input wire [width-1:0] a, b,
    input wire [3:0] opcode,
    output reg c, v,
    output wire z, n,
    output reg [width-1:0] result
);

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


    wire [width-1:0] arith_result;
    wire arith_c;
    wire arith_v;


    arith_unit #(
        .width(width)
    ) arith_inst (
        .a(a),
        .b(b),
        .is_sub((opcode == SUB) || (opcode == CMP)),
        .c(arith_c),
        .v(arith_v),
        .result(arith_result)
    );


    wire [width-1:0] logic_result;
    reg [2:0] logic_op;


    always @(*) begin

        case (opcode)

            AND:  logic_op = 3'h0;
            OR:   logic_op = 3'h1;
            XOR:  logic_op = 3'h2;
            NAND: logic_op = 3'h3;
            NOR:  logic_op = 3'h4;
            XNOR: logic_op = 3'h5;
            NOT:  logic_op = 3'h6;

            default: logic_op = 3'h0;

        endcase

    end


    logic_unit #(
        .width(width)
    ) logic_inst (
        .a(a),
        .b(b),
        .op(logic_op),
        .result(logic_result)
    );


    wire [width-1:0] shift_result;
    wire shift_c;


    shift_unit #(
        .width(width)
    ) shift_inst (
        .a(a),
        .is_right(opcode == SHR),
        .result(shift_result),
        .c(shift_c)
    );


    always @(*) begin

        result = {width{1'b0}};
        c = 1'b0;
        v = 1'b0;

        case (opcode)

            ADD: begin

                result = arith_result;
                c = arith_c;
                v = arith_v;

            end


            SUB: begin

                result = arith_result;
                c = arith_c;
                v = arith_v;

            end


            AND, OR, XOR, XNOR, NAND, NOR, NOT: begin

                result = logic_result;

            end


            SHL: begin

                result = shift_result;
                c = shift_c;

            end


            SHR: begin

                result = shift_result;
                c = shift_c;

            end


            CMP: begin

                result = {width{1'b0}};
                c = arith_c;
                v = arith_v;

            end


            default: begin

                result = {width{1'b0}};
                c = 1'b0;
                v = 1'b0;

            end

        endcase

    end


    assign z = (opcode == CMP)
             ? ~(|arith_result)
             : ~(|result);

    assign n = (opcode == CMP)
             ? arith_result[width-1]
             : result[width-1];

endmodule