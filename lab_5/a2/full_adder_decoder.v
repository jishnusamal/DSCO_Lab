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

// Full adder using 2:4 decoder + gates
// Decode a,b -> Y3=ab, Y1=~a b, Y2=a ~b, Y0=~a ~b
// sum = a^b^cin; cout = ab + cin(a+b)
module full_adder_decoder (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    wire [3:0] y;
    decoder_2to4 dec (.a({a, b}), .en(1'b1), .y(y));

    // sum: cin=0 -> a^b = Y1|Y2 ; cin=1 -> ~(a^b) = Y0|Y3
    wire sum_cin0, sum_cin1;
    assign sum_cin0 = y[1] | y[2];
    assign sum_cin1 = y[0] | y[3];
    assign sum = (cin ? sum_cin1 : sum_cin0);

    // cout = ab | cin&a | cin&b  = Y3 | (cin&a) | (cin&b)
    assign cout = y[3] | (cin & a) | (cin & b);

endmodule
