// 4 to 2 priority encoder using casex
// Inputs D3..D0 (D3 highest priority), outputs Y1 Y0, V (valid)
module priority_encoder_4to2 (
    input  wire [3:0] d,
    output wire [1:0] y,
    output wire       v
);

    reg [1:0] y_reg;
    reg       v_reg;

    always @(*) begin
        casex (d)
            4'b1xxx: begin y_reg = 2'b11; v_reg = 1; end
            4'b01xx: begin y_reg = 2'b10; v_reg = 1; end
            4'b001x: begin y_reg = 2'b01; v_reg = 1; end
            4'b0001: begin y_reg = 2'b00; v_reg = 1; end
            default: begin y_reg = 2'b00; v_reg = 0; end
        endcase
    end

    assign y = y_reg;
    assign v = v_reg;

endmodule
