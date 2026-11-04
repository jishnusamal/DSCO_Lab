// 4 to 16 decoder (active-high outputs)
module decoder_4to16 (
    input  wire [3:0] a,
    input  wire       en,
    output wire [15:0] y
);

    reg [15:0] y_reg;
    always @(*) begin
        if (!en) y_reg = 16'b0;
        else y_reg = (16'b1 << a);
    end
    assign y = y_reg;

endmodule

// F(a,b,c,d) = sum m(2,3,4,5,6,7,10,11,12,15) using 4:16 decoder + OR
module f_q3 (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire f
);

    wire [15:0] y;
    decoder_4to16 dec (.a({a, b, c, d}), .en(1'b1), .y(y));

    assign f = y[2] | y[3] | y[4] | y[5] | y[6] | y[7] |
               y[10] | y[11] | y[12] | y[15];

endmodule
