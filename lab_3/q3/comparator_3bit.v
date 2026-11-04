// 3-bit comparator using only logic gates (behavioral Verilog to simulate)
// Outputs: gt (a>b), eq (a==b), lt (a<b)
module comparator_3bit (
    input  wire [2:0] a,
    input  wire [2:0] b,
    output wire       gt,
    output wire       eq,
    output wire       lt
);

    wire [2:0] na, nb;
    assign na = ~a;
    assign nb = ~b;

    // Equality: XNOR of each bit, ANDed together
    wire x0, x1, x2;
    assign x0 = ~(a[0] ^ b[0]);
    assign x1 = ~(a[1] ^ b[1]);
    assign x2 = ~(a[2] ^ b[2]);
    assign eq = x0 & x1 & x2;

    // Greater than: bitwise from MSB
    wire g2, g1, g0;
    assign g2 = a[2] & nb[2];
    assign g1 = x2 & a[1] & nb[1];
    assign g0 = x2 & x1 & a[0] & nb[0];
    assign gt = g2 | g1 | g0;

    // Less than: bitwise from MSB
    wire l2, l1, l0;
    assign l2 = na[2] & b[2];
    assign l1 = x2 & na[1] & b[1];
    assign l0 = x2 & x1 & na[0] & b[0];
    assign lt = l2 | l1 | l0;

endmodule
