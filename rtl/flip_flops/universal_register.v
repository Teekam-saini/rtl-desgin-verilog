module universal_register(
    input wire clk,reset,si,
    input wire [1:0] mode,
    input wire [7:0] pi,
    output reg [7:0] po,
    output wire so_right,
    output wire so_left
);

localparam hold = 2'b00;
localparam shift_right = 2'b01;
localparam shift_left = 2'b10;
localparam load = 2'b11;

always @(posedge clk or posedge reset) begin
    if(reset)
    po <= 8'b0;
    else
    case (mode)
        hold: po <= po;
        shift_left: po <= {po[6:0] , si};
        shift_right: po <=  {si, po[7:1]};
        load: po <= pi;        
        default: po <= po;
    endcase
    
end

assign so_left = po[7];
assign so_right = po[0];

endmodule