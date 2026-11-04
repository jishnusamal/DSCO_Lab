// f(A,B,C,D) = sum m(0,4,6,7,10,12,14) + d(2,13)
// K-map simplification: f = A'BC + CD' + BD' + A'D'

module f_q1b (
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

    assign t1 = nA & B & C;   // A'BC
    assign t2 = C & nD;       // CD'
    assign t3 = B & nD;       // BD'
    assign t4 = nA & nD;      // A'D'

    assign f = t1 | t2 | t3 | t4;

endmodule
