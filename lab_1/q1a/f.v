// f(A,B,C,D) = sum m(0,1,2,3,4,8,9,12)
// K-map simplification: f = A'B' + C'D' + AB'C'

module f_q1a (
    input wire A,
    input wire B,
    input wire C,
    input wire D,
    output wire f
);

    wire nA, nB, nC, nD;
    wire t1, t2, t3;

    assign nA = ~A;
    assign nB = ~B;
    assign nC = ~C;
    assign nD = ~D;

    assign t1 = nA & nB;   // A'B'
    assign t2 = nC & nD;   // C'D'
    assign t3 = A & nB & nC; // AB'C'

    assign f = t1 | t2 | t3;

endmodule
