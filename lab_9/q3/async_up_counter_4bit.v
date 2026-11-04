// T flip-flop, positive edge triggered
module t_ff (
    input wire clk,
    input wire rst,
    input wire t,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= t ^ q;
    end

endmodule

// 4-bit asynchronous up counter using positive-edge T FFs (all T=1)
// Ripple: each FF output clocks the next.
module async_up_counter_4bit (
    input wire clk,
    input wire rst,
    output wire [3:0] q
);

    t_ff ff0 (.clk(clk),   .rst(rst), .t(1'b1), .q(q[0]));
    t_ff ff1 (.clk(~q[0]), .rst(rst), .t(1'b1), .q(q[1]));
    t_ff ff2 (.clk(~q[1]), .rst(rst), .t(1'b1), .q(q[2]));
    t_ff ff3 (.clk(~q[2]), .rst(rst), .t(1'b1), .q(q[3]));

endmodule
