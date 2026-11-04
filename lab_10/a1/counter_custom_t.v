// Lab 10 Additional Q1: Counter sequence 0,1,2,5,4,6,8,9,12,11,13,15 using T flip-flops
// States (Q3 Q2 Q1 Q0):
//   0000->0001->0010->0101->0100->0110->1000->1001->1100->1011->1101->1111->0000
//
// Excitation equation (T = Q ^ Qnext):
//   next_state = f(state)       [state transition table]
//   T = state ^ next_state      [flip-flop input equation]
//
// T flip-flop characteristic: Q_next = Q ^ T

`define S0  4'b0000
`define S1  4'b0001
`define S2  4'b0010
`define S5  4'b0101
`define S4  4'b0100
`define S6  4'b0110
`define S8  4'b1000
`define S9  4'b1001
`define S12 4'b1100
`define S11 4'b1011
`define S13 4'b1101
`define S15 4'b1111

module counter_custom_t (
    input wire clk,
    input wire rst,
    output wire [3:0] q
);

    wire [3:0] state;
    reg  [3:0] next_state;
    wire [3:0] t;

    // State transition table (combinational)
    always @(*) begin
        case (state)
            `S0:  next_state = `S1;
            `S1:  next_state = `S2;
            `S2:  next_state = `S5;
            `S5:  next_state = `S4;
            `S4:  next_state = `S6;
            `S6:  next_state = `S8;
            `S8:  next_state = `S9;
            `S9:  next_state = `S12;
            `S12: next_state = `S11;
            `S11: next_state = `S13;
            `S13: next_state = `S15;
            `S15: next_state = `S0;
            default: next_state = `S0;
        endcase
    end

    // Flip-flop input equations: T = Q ^ Qnext
    assign t = state ^ next_state;

    // T flip-flops (characteristic equation)
    t_ff ff3 (.clk(clk), .rst(rst), .t(t[3]), .q(state[3]));
    t_ff ff2 (.clk(clk), .rst(rst), .t(t[2]), .q(state[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(t[1]), .q(state[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(t[0]), .q(state[0]));

    assign q = state;

endmodule

// T flip-flop with characteristic equation Q_next = Q ^ T
module t_ff (
    input wire clk,
    input wire rst,
    input wire t,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= q ^ t;
    end

endmodule
