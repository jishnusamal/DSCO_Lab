// 3 to 8 decoder, active-high enable, active-low output, if-else
module decoder_3to8_en_high_active_low (
    input  wire [2:0] a,
    input  wire       en,       // active-high enable
    output wire [7:0] y_bar     // active-low outputs
);

    reg [7:0] y_reg;
    always @(*) begin
        if (!en) begin
            y_reg = 8'b11111111;   // all outputs inactive (high) when disabled
        end else begin
            case (a)
                3'b000: y_reg = 8'b11111110;
                3'b001: y_reg = 8'b11111101;
                3'b010: y_reg = 8'b11111011;
                3'b011: y_reg = 8'b11110111;
                3'b100: y_reg = 8'b11101111;
                3'b101: y_reg = 8'b11011111;
                3'b110: y_reg = 8'b10111111;
                3'b111: y_reg = 8'b01111111;
                default: y_reg = 8'b11111111;
            endcase
        end
    end

    assign y_bar = y_reg;

endmodule

// 5 to 32 decoder using 3:8 decoders and a 2:4 decoder
// Active-high enable, active-low output
module decoder_5to32 (
    input  wire [4:0] a,
    input  wire       en,       // active-high enable
    output wire [31:0] y_bar    // active-low outputs
);

    wire [3:0] sel_hi;   // 2:4 decoder outputs (active-high) for groups
    wire [7:0] g0, g1, g2, g3;  // 3:8 decoder outputs (active-low)

    // Top 2:4 decoder selects group (active-high outputs)
    decoder_2to4_en_high_case top (
        .a(a[4:3]),
        .en(en),
        .y(sel_hi)
    );

    // Four 3:8 decoders (active-low outputs), each enabled by sel_hi[i]
    // When sel_hi[i]=0, that group disabled -> all outputs high (inactive)
    decoder_3to8_en_high_active_low g0_dec (.a(a[2:0]), .en(sel_hi[0]), .y_bar(g0));
    decoder_3to8_en_high_active_low g1_dec (.a(a[2:0]), .en(sel_hi[1]), .y_bar(g1));
    decoder_3to8_en_high_active_low g2_dec (.a(a[2:0]), .en(sel_hi[2]), .y_bar(g2));
    decoder_3to8_en_high_active_low g3_dec (.a(a[2:0]), .en(sel_hi[3]), .y_bar(g3));

    assign y_bar = {g3, g2, g1, g0};

endmodule
