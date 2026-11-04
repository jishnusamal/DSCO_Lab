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

// Synchronous counter using T FFs with control w
// w=0: 0,2,3,4,6  (up)
// w=1: 6,4,3,2,0  (down)
// T = state ^ next_state
module counter_control_w_t (
    input wire clk,
    input wire rst,
    input wire w,
    output wire [2:0] q
);

    reg [2:0] next_state;
    wire [2:0] state;
    wire [2:0] T;
    wire [2:0] q_w;

    always @(*) begin
        if (w == 1'b0) begin
            case (state)
                3'b000: next_state = 3'b010;   // 0 -> 2
                3'b010: next_state = 3'b011;   // 2 -> 3
                3'b011: next_state = 3'b100;   // 3 -> 4
                3'b100: next_state = 3'b110;   // 4 -> 6
                3'b110: next_state = 3'b000;   // 6 -> 0
                default: next_state = 3'b000;
            endcase
        end else begin
            case (state)
                3'b110: next_state = 3'b100;   // 6 -> 4
                3'b100: next_state = 3'b011;   // 4 -> 3
                3'b011: next_state = 3'b010;   // 3 -> 2
                3'b010: next_state = 3'b000;   // 2 -> 0
                3'b000: next_state = 3'b110;   // 0 -> 6
                default: next_state = 3'b000;
            endcase
        end
    end

    assign T = state ^ next_state;

    t_ff ff2 (.clk(clk), .rst(rst), .t(T[2]), .q(q_w[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(T[1]), .q(q_w[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(T[0]), .q(q_w[0]));

    assign state = q_w;
    assign q = q_w;

endmodule
