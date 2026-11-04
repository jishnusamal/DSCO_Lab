// 3x3 Multiplier using AND gates (partial products) and full adders
// Product is up to 6 bits: p[5:0]

module multiplier_3x3 (
    input  wire [2:0] a,
    input  wire [2:0] b,
    output wire [5:0] p
);

    // Partial product bits: g[i][j] = a[i] & b[j]
    wire g00, g10, g20;
    wire g01, g11, g21;
    wire g02, g12, g22;

    assign g00 = a[0] & b[0];
    assign g10 = a[1] & b[0];
    assign g20 = a[2] & b[0];
    assign g01 = a[0] & b[1];
    assign g11 = a[1] & b[1];
    assign g21 = a[2] & b[1];
    assign g02 = a[0] & b[2];
    assign g12 = a[1] & b[2];
    assign g22 = a[2] & b[2];

    // PP0 = a & b0  (3 bits), PP1 = a & b1 (3 bits), PP2 = a & b2 (3 bits)
    // S1 = PP0 + (PP1 << 1)   -> 5 bits
    // P  = S1  + (PP2 << 2)   -> 6 bits

    // Stage 1: PP0 + (PP1 << 1), 4-bit ripple
    // PP0 (4-bit): {0, g20, g10, g00}
    // PP1<<1 (4-bit): {0, g21, g11, g01} aligned: bit0=0, bit1=g01, bit2=g11, bit3=g21
    wire s1_0, s1_1, s1_2, s1_3, s1_4;
    wire c1_0, c1_1, c1_2, c1_3;

    full_adder fa_s1_0 (.a(g00), .b(1'b0), .cin(1'b0), .sum(s1_0), .cout(c1_0));
    full_adder fa_s1_1 (.a(g10), .b(g01), .cin(c1_0), .sum(s1_1), .cout(c1_1));
    full_adder fa_s1_2 (.a(g20), .b(g11), .cin(c1_1), .sum(s1_2), .cout(c1_2));
    full_adder fa_s1_3 (.a(1'b0), .b(g21), .cin(c1_2), .sum(s1_3), .cout(c1_3));
    assign s1_4 = c1_3;

    // Stage 2: S1 + (PP2 << 2), 6-bit ripple
    // PP2<<2: bit2=g02, bit3=g12, bit4=g22, rest 0
    wire c2_0, c2_1, c2_2, c2_3, c2_4;

    assign p[0] = s1_0;
    assign p[1] = s1_1;
    full_adder fa_s2_2 (.a(s1_2), .b(g02), .cin(1'b0), .sum(p[2]), .cout(c2_2));
    full_adder fa_s2_3 (.a(s1_3), .b(g12), .cin(c2_2), .sum(p[3]), .cout(c2_3));
    full_adder fa_s2_4 (.a(s1_4), .b(g22), .cin(c2_3), .sum(p[4]), .cout(c2_4));
    assign p[5] = c2_4;

endmodule
