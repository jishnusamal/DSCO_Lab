// 2 to 4 decoder, active-high enable, active-high output
module decoder_2to4 (
    input  wire [1:0] a,
    input  wire       en,
    output wire [3:0] y
);

    reg [3:0] y_reg;
    always @(*) begin
        if (!en) y_reg = 4'b0000;
        else begin
            case (a)
                2'b00: y_reg = 4'b0001;
                2'b01: y_reg = 4'b0010;
                2'b10: y_reg = 4'b0100;
                2'b11: y_reg = 4'b1000;
                default: y_reg = 4'b0000;
            endcase
        end
    end
    assign y = y_reg;

endmodule

// 3-input majority F(a,b,c) = ab + bc + ca using 2:4 decoders + gates
module majority_3bit (
    input wire a,
    input wire b,
    input wire c,
    output wire f
);

    wire [3:0] y_ab, y_bc, y_ca;

    decoder_2to4 dec_ab (.a({a, b}), .en(1'b1), .y(y_ab)); // y_ab[3] = a&b
    decoder_2to4 dec_bc (.a({b, c}), .en(1'b1), .y(y_bc)); // y_bc[3] = b&c
    decoder_2to4 dec_ca (.a({c, a}), .en(1'b1), .y(y_ca)); // y_ca[3] = c&a

    assign f = y_ab[3] | y_bc[3] | y_ca[3];

endmodule
