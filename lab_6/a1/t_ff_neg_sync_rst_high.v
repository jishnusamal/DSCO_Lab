// Negative edge-triggered T FF with synchronous active-high reset
module t_ff_neg_sync_rst_high (
    input wire clk,
    input wire rst,      // synchronous, active high
    input wire t,
    output reg q
);

    always @(negedge clk) begin
        if (rst)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end

endmodule
