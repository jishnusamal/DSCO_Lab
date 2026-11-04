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

// Counter sequence 0,1,3,7,6,4 using T FFs
// T = state ^ next_state
module counter_013764_t (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    reg [2:0] next_state;
    wire [2:0] state;
    wire [2:0] T;
    wire [2:0] q_w;

    always @(*) begin
        case (state)
            3'b000: next_state = 3'b001;   // 0 -> 1
            3'b001: next_state = 3'b011;   // 1 -> 3
            3'b011: next_state = 3'b111;   // 3 -> 7
            3'b111: next_state = 3'b110;   // 7 -> 6
            3'b110: next_state = 3'b100;   // 6 -> 4
            3'b100: next_state = 3'b000;   // 4 -> 0
            default: next_state = 3'b000;
        endcase
    end

    assign T = state ^ next_state;

    t_ff ff2 (.clk(clk), .rst(rst), .t(T[2]), .q(q_w[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(T[1]), .q(q_w[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(T[0]), .q(q_w[0]));

    assign state = q_w;
    assign q = q_w;

endmodule
