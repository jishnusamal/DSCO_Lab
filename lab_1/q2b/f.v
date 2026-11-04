// f(A,B,C,D) = pi M(2,5,6,8,10) + d(9,12,14)
// K-map simplification (SOP): f = CD + AB + A'C'D' + A'B'C'

module f_q2b (
    input wire A,
    input wire B,
    input wire C,
    input wire D,
    output wire f
);

    wire nA, nB, nC, nD;
    wire t1, t2, t3, t4;

    assign nA = ~A;
    assign nB = ~B;
    assign nC = ~C;
    assign nD = ~D;

    assign t1 = C & D;      // CD
    assign t2 = A & B;      // AB
    assign t3 = nA & nC & nD; // A'C'D'
    assign t4 = nA & nB & nC; // A'B'C'

    assign f = t1 | t2 | t3 | t4;

endmodule
