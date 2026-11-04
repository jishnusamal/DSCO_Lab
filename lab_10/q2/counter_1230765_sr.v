// SR flip-flop, positive edge triggered (S=1,R=1 avoided)
module sr_ff (
    input wire clk,
    input wire rst,
    input wire s,
    input wire r,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({s, r})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= q;   // invalid, treat as hold
            endcase
        end
    end

endmodule

// Counter sequence 1,2,3,0,7,6,5 using SR FFs
// S = ~Q & Q_next,  R = Q & ~Q_next
module counter_1230765_sr (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    reg [2:0] next_state;
    wire [2:0] state;
    wire [2:0] S, R;
    wire [2:0] q_w;

    always @(*) begin
        case (state)
            3'b001: next_state = 3'b010;   // 1 -> 2
            3'b010: next_state = 3'b011;   // 2 -> 3
            3'b011: next_state = 3'b000;   // 3 -> 0
            3'b000: next_state = 3'b111;   // 0 -> 7
            3'b111: next_state = 3'b110;   // 7 -> 6
            3'b110: next_state = 3'b101;   // 6 -> 5
            3'b101: next_state = 3'b001;   // 5 -> 1
            default: next_state = 3'b001;
        endcase
    end

    // SR excitation: S = ~Q & Q_next, R = Q & ~Q_next
    assign S = ~state & next_state;
    assign R = state & ~next_state;

    sr_ff ff2 (.clk(clk), .rst(rst), .s(S[2]), .r(R[2]), .q(q_w[2]));
    sr_ff ff1 (.clk(clk), .rst(rst), .s(S[1]), .r(R[1]), .q(q_w[1]));
    sr_ff ff0 (.clk(clk), .rst(rst), .s(S[0]), .r(R[0]), .q(q_w[0]));

    assign state = q_w;
    assign q = q_w;

endmodule
