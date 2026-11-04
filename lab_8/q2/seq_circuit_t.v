// Lab 8 Q2: Synchronous sequential circuit using T flip-flops
// State diagram (from image 1):
//   00: T=0->11, T=1->00
//   01: T=0->00, T=1->11
//   10: T=0->10, T=1->01
//   11: T=0->10, T=1->11
//
// T FF excitation: Q+ = Q ^ T  =>  T = Q ^ Q+
//
// Derived excitation equations:
// T1 = ~Q1~Q0~Tin | Tin(Q1^Q0)
// T0 = ~Q1~Tin | Q0~Tin | Q1~Q0Tin

// T flip flop (positive edge)
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

module seq_circuit_t (
    input wire clk,
    input wire rst,
    input wire tin,
    output wire [1:0] q
);

    wire q1, q0;
    wire t1, t0;

    // T excitation logic
    assign t1 = (~q1 & ~q0 & ~tin) | (tin & (q1 ^ q0));
    assign t0 = (~q1 & ~tin) | (q0 & ~tin) | (q1 & ~q0 & tin);

    t_ff ff1 (.clk(clk), .rst(rst), .t(t1), .q(q1));
    t_ff ff0 (.clk(clk), .rst(rst), .t(t0), .q(q0));

    assign q = {q1, q0};

endmodule
