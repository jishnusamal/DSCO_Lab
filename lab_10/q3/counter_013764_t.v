// Lab 10 Q3: Counter sequence 0,1,3,7,6,4 using T flip-flops
// States (Q2 Q1 Q0): 000->001->011->111->110->100->000
//
// Excitation equations (T = Q ^ Qnext, simplified via K-map):
//   T0 = ~Q2 & ~Q1 & ~Q0  |  Q2 & Q1 & Q0
//   T1 = ~Q2 & ~Q1 &  Q0  |  Q2 & Q1 & ~Q0
//   T2 = ~Q2 &  Q1 &  Q0  |  Q2 & ~Q1 & ~Q0
//
// T flip-flop characteristic: Q_next = Q ^ T

`define ST0 3'b000
`define ST1 3'b001
`define ST3 3'b011
`define ST7 3'b111
`define ST6 3'b110
`define ST4 3'b100

module counter_013764_t (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    wire [2:0] state;

    wire t0, t1, t2;

    // Flip-flop input equations
    assign t0 = (~state[2] & ~state[1] & ~state[0]) |
                ( state[2] &  state[1] &  state[0]);

    assign t1 = (~state[2] & ~state[1] &  state[0]) |
                ( state[2] &  state[1] & ~state[0]);

    assign t2 = (~state[2] &  state[1] &  state[0]) |
                ( state[2] & ~state[1] & ~state[0]);

    // T flip-flops (characteristic equation)
    t_ff ff2 (.clk(clk), .rst(rst), .t(t2), .q(state[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(t1), .q(state[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(t0), .q(state[0]));

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
