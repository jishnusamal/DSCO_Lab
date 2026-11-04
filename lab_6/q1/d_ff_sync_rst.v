// Positive edge-triggered D FF with synchronous active-high reset
module d_ff_sync_rst (
    input wire clk,
    input wire rst,      // synchronous, active high
    input wire d,
    output reg q
);

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
