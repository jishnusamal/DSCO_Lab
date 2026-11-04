// 16 to 4 priority encoder
// Inputs D15..D0 (D15 highest priority), outputs Y3..Y0, V
module priority_encoder_16to4 (
    input  wire [15:0] d,
    output wire [3:0]  y,
    output wire        v
);

    reg [3:0] y_reg;
    reg       v_reg;

    always @(*) begin
        y_reg = 4'b0000;
        v_reg = 1'b0;
        if (d[15]) begin y_reg = 4'd15; v_reg = 1'b1; end
        else if (d[14]) begin y_reg = 4'd14; v_reg = 1'b1; end
        else if (d[13]) begin y_reg = 4'd13; v_reg = 1'b1; end
        else if (d[12]) begin y_reg = 4'd12; v_reg = 1'b1; end
        else if (d[11]) begin y_reg = 4'd11; v_reg = 1'b1; end
        else if (d[10]) begin y_reg = 4'd10; v_reg = 1'b1; end
        else if (d[9])  begin y_reg = 4'd9;  v_reg = 1'b1; end
        else if (d[8])  begin y_reg = 4'd8;  v_reg = 1'b1; end
        else if (d[7])  begin y_reg = 4'd7;  v_reg = 1'b1; end
        else if (d[6])  begin y_reg = 4'd6;  v_reg = 1'b1; end
        else if (d[5])  begin y_reg = 4'd5;  v_reg = 1'b1; end
        else if (d[4])  begin y_reg = 4'd4;  v_reg = 1'b1; end
        else if (d[3])  begin y_reg = 4'd3;  v_reg = 1'b1; end
        else if (d[2])  begin y_reg = 4'd2;  v_reg = 1'b1; end
        else if (d[1])  begin y_reg = 4'd1;  v_reg = 1'b1; end
        else if (d[0])  begin y_reg = 4'd0;  v_reg = 1'b1; end
    end

    assign y = y_reg;
    assign v = v_reg;

endmodule
