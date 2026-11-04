// N bit shift register (serial in, parallel out, shift right)
module shift_reg_n #(
    parameter N = 8
) (
    input wire clk,
    input wire rst,
    input wire sin,
    output wire [N-1:0] q
);

    reg [N-1:0] q_reg;
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst)
            q_reg <= {N{1'b0}};
        else begin
            q_reg[0] <= sin;
            for (i = 1; i < N; i = i + 1)
                q_reg[i] <= q_reg[i-1];
        end
    end

    assign q = q_reg;

endmodule
