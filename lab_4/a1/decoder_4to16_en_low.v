// 2 to 4 decoder, active-high enable, active-high output, case statement
module decoder_2to4_en_high_case (
    input  wire [1:0] a,
    input  wire       en,       // active-high enable
    output wire [3:0] y
);

    reg [3:0] y_reg;
    always @(*) begin
        if (!en) begin
            y_reg = 4'b0000;
        end else begin
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

// 4 to 16 decoder using the above 2:4 decoders
// Active-low enable, active-high output
module decoder_4to16_en_low (
    input  wire [3:0] a,
    input  wire       en_bar,   // active-low enable
    output wire [15:0] y
);

    wire [3:0] sel_hi;
    wire [3:0] y0, y1, y2, y3;

    // Top decoder: active-high enable -> use en_bar inverted
    decoder_2to4_en_high_case top (
        .a(a[3:2]),
        .en(~en_bar),
        .y(sel_hi)
    );

    decoder_2to4_en_high_case d0 (.a(a[1:0]), .en(sel_hi[0]), .y(y0));
    decoder_2to4_en_high_case d1 (.a(a[1:0]), .en(sel_hi[1]), .y(y1));
    decoder_2to4_en_high_case d2 (.a(a[1:0]), .en(sel_hi[2]), .y(y2));
    decoder_2to4_en_high_case d3 (.a(a[1:0]), .en(sel_hi[3]), .y(y3));

    assign y = {y3, y2, y1, y0};

endmodule
