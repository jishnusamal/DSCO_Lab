// 2 to 4 decoder, active-low enable, active-high output, if-else
module decoder_2to4_en_low (
    input  wire [1:0] a,
    input  wire       en_bar,   // active-low enable
    output wire [3:0] y
);

    reg [3:0] y_reg;
    always @(*) begin
        if (en_bar) begin
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
