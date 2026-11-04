// f(A,B,C,D) = pi M(0,1,4,8,9,12,15)
// K-map simplification (SOP): f = CD' + BC'D + A'CD + B'CD

module f_q2a (
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

    assign t1 = C & nD;     // CD'
    assign t2 = B & nC & D; // BC'D
    assign t3 = nA & C & D; // A'CD
    assign t4 = nB & C & D; // B'CD

    assign f = t1 | t2 | t3 | t4;

endmodule
