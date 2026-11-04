// Lab 10 Q2: Counter sequence 1,2,3,0,7,6,5 using SR flip-flops
// States (Q2 Q1 Q0): 001->010->011->000->111->110->101->001
//
// Excitation equations (SR: S = Qnext & ~Q,  R = ~Qnext & Q, simplified via K-map):
//   S0 = ~Q0 & (~Q2 | Q1)        R0 = Q0 & (~Q2 | Q1)
//   S1 = ~Q2 & ~Q1               R1 = Q1 & (Q2 ^ Q0)
//   S2 = ~Q2 & ~Q1 & ~Q0         R2 = Q2 & ~Q1 & Q0
//
// SR characteristic: Q_next = S | (~R & Q)

`define ST1 3'b001
`define ST2 3'b010
`define ST3 3'b011
`define ST0 3'b000
`define ST7 3'b111
`define ST6 3'b110
`define ST5 3'b101

module counter_1230765_sr (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    wire [2:0] state;

    wire s0, r0, s1, r1, s2, r2;

    // Flip-flop input equations
    assign s0 = ~state[0] & (~state[2] | state[1]);
    assign r0 =  state[0] & (~state[2] | state[1]);

    assign s1 = ~state[2] & ~state[1];
    assign r1 =  state[1] & (state[2] ^ state[0]);

    assign s2 = ~state[2] & ~state[1] & ~state[0];
    assign r2 =  state[2] & ~state[1] &  state[0];

    // SR flip-flops (characteristic equation)
    sr_ff ff2 (.clk(clk), .rst(rst), .s(s2), .r(r2), .q(state[2]));
    sr_ff ff1 (.clk(clk), .rst(rst), .s(s1), .r(r1), .q(state[1]));
    sr_ff ff0 (.clk(clk), .rst(rst), .s(s0), .r(r0), .q(state[0]));

    assign q = state;

endmodule

// SR flip-flop with characteristic equation Q_next = S | (~R & Q)
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
        else
            q <= s | (~r & q);
    end

endmodule
