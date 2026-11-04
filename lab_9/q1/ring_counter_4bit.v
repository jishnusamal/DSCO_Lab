// 4-bit Ring Counter (behavioral)
// Circulates a single '1' bit around the ring. Initial state = 4'b1000.
module ring_counter_4bit (
    input wire clk,
    input wire rst,
    output reg [3:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 4'b1000;
        else
            q <= {q[0], q[3:1]};   // rotate right
    end

endmodule
