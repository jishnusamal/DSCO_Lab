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
        else if (t)
            q <= ~q;
    end

endmodule

// Counter sequence 0,1,2,5,4,6,8,9,12,11,13,15 using T FFs (4-bit)
// T = state ^ next_state
module counter_custom_t (
    input wire clk,
    input wire rst,
    output wire [3:0] q
);

    reg [3:0] next_state;
    wire [3:0] state;
    wire [3:0] T;
    wire [3:0] q_w;

    always @(*) begin
        case (state)
            4'b0000: next_state = 4'b0001;   // 0 -> 1
            4'b0001: next_state = 4'b0010;   // 1 -> 2
            4'b0010: next_state = 4'b0101;   // 2 -> 5
            4'b0101: next_state = 4'b0100;   // 5 -> 4
            4'b0100: next_state = 4'b0110;   // 4 -> 6
            4'b0110: next_state = 4'b1000;   // 6 -> 8
            4'b1000: next_state = 4'b1001;   // 8 -> 9
            4'b1001: next_state = 4'b1100;   // 9 -> 12
            4'b1100: next_state = 4'b1011;   // 12 -> 11
            4'b1011: next_state = 4'b1101;   // 11 -> 13
            4'b1101: next_state = 4'b1111;   // 13 -> 15
            4'b1111: next_state = 4'b0000;   // 15 -> 0
            default: next_state = 4'b0000;
        endcase
    end

    assign T = state ^ next_state;

    t_ff ff3 (.clk(clk), .rst(rst), .t(T[3]), .q(q_w[3]));
    t_ff ff2 (.clk(clk), .rst(rst), .t(T[2]), .q(q_w[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(T[1]), .q(q_w[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(T[0]), .q(q_w[0]));

    assign state = q_w;
    assign q = q_w;

endmodule
