// Negative edge-triggered T FF with synchronous active-low reset
module t_ff_neg_sync_rst (
    input wire clk,
    input wire rst_bar,    // synchronous, active low
    input wire t,
    output reg q
);

    always @(negedge clk) begin
        if (!rst_bar)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end

endmodule
