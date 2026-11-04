// 6-bit Johnson Counter (behavioral)
// Complement of LSB fed back to MSB input. 12 distinct states.
module johnson_counter_6bit (
    input wire clk,
    input wire rst,
    output reg [5:0] q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 6'b0;
        else
            q <= {~q[0], q[5:1]};
    end

endmodule
