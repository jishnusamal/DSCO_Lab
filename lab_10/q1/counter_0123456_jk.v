// Lab 10 Q1: Counter sequence 0,1,2,3,4,5,6 using JK flip-flops
// States (Q2 Q1 Q0): 000->001->010->011->100->101->110->000
//
// Excitation equations (JK: J = Qnext & ~Q,  K = ~Qnext & Q, simplified via K-map):
//   dec6 = Q2 & Q1 & ~Q0                     // state 110 (wrap)
//   J0 = ~Q0 & ~dec6        K0 = Q0  & ~dec6
//   J1 = (Q0 | dec6) & ~Q1  K1 = (Q0 | dec6) & Q1
//   J2 = (Q1 & Q0 | dec6) & ~Q2  K2 = (Q1 & Q0 | dec6) & Q2
//
// JK characteristic: Q_next = (J & ~Q) | (~K & Q)

`define ST0 3'b000
`define ST1 3'b001
`define ST2 3'b010
`define ST3 3'b011
`define ST4 3'b100
`define ST5 3'b101
`define ST6 3'b110

module counter_0123456_jk (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    wire [2:0] state;
    wire dec6;
    wire j0, k0, j1, k1, j2, k2;

    // Flip-flop input equations
    assign dec6 = state[2] & state[1] & ~state[0];

    assign j0 = ~state[0] & ~dec6;
    assign k0 =  state[0] & ~dec6;

    assign j1 = (state[0] | dec6) & ~state[1];
    assign k1 = (state[0] | dec6) &  state[1];

    assign j2 = (state[1] & state[0] | dec6) & ~state[2];
    assign k2 = (state[1] & state[0] | dec6) &  state[2];

    // JK flip-flops (characteristic equation)
    wire [2:0] state_w;
    jk_ff ff2 (.clk(clk), .rst(rst), .j(j2), .k(k2), .q(state_w[2]));
    jk_ff ff1 (.clk(clk), .rst(rst), .j(j1), .k(k1), .q(state_w[1]));
    jk_ff ff0 (.clk(clk), .rst(rst), .j(j0), .k(k0), .q(state_w[0]));

    assign state = state_w;
    assign q     = state;

endmodule

// JK flip-flop with characteristic equation Q_next = (J & ~Q) | (~K & Q)
module jk_ff (
    input wire clk,
    input wire rst,
    input wire j,
    input wire k,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= (j & ~q) | (~k & q);
    end

endmodule
