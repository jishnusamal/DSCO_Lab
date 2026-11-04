// D flip flop (positive edge)
module d_ff (
    input wire clk,
    input wire d,
    output reg q
);

    always @(posedge clk) begin
        q <= d;
    end

endmodule

// 6-bit shift register (structural) - serial in, parallel out, shift right
module shift_reg_6bit (
    input wire clk,
    input wire sin,
    output wire [5:0] q
);

    d_ff ff0 (.clk(clk), .d(sin),     .q(q[0]));
    d_ff ff1 (.clk(clk), .d(q[0]),   .q(q[1]));
    d_ff ff2 (.clk(clk), .d(q[1]),   .q(q[2]));
    d_ff ff3 (.clk(clk), .d(q[2]),   .q(q[3]));
    d_ff ff4 (.clk(clk), .d(q[3]),   .q(q[4]));
    d_ff ff5 (.clk(clk), .d(q[4]),   .q(q[5]));

endmodule
