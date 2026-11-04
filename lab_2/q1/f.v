// f(a,b,c,d) = sum m(0,4,8,13,14,15)
// Functional decomposition (minimum cost):
// f = c'd'(a' + b') + ab(c + d)

module f_q1 (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output wire f
);

    wire na, nb;
    wire t1, t2, t3, t4, t5, t6;

    assign na = ~a;
    assign nb = ~b;

    assign t1 = ~c & ~d;      // c'd'
    assign t2 = na | nb;      // a' + b'
    assign t3 = t1 & t2;      // c'd'(a'+b')

    assign t4 = a & b;        // ab
    assign t5 = c | d;        // c + d
    assign t6 = t4 & t5;      // ab(c+d)

    assign f = t3 | t6;

endmodule
