// Negative edge-triggered SR FF with asynchronous active-low reset
module sr_ff_neg_async_rst (
    input wire clk,
    input wire rst_bar,    // asynchronous, active low
    input wire s,
    input wire r,
    output reg q
);

    always @(negedge clk or negedge rst_bar) begin
        if (!rst_bar)
            q <= 1'b0;
        else begin
            case ({s, r})
                2'b00: q <= q;      // hold
                2'b01: q <= 1'b0;   // reset
                2'b10: q <= 1'b1;   // set
                2'b11: q <= q;      // invalid -> hold (no change)
            endcase
        end
    end

endmodule
