// Positive edge-triggered JK FF with asynchronous active-high reset
module jk_ff_async_rst (
    input wire clk,
    input wire rst,      // asynchronous, active high
    input wire j,
    input wire k,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;      // hold
                2'b01: q <= 1'b0;   // reset
                2'b10: q <= 1'b1;   // set
                2'b11: q <= ~q;     // toggle
            endcase
        end
    end

endmodule
