// 2-bit comparator (building block)
// Outputs: gt (a>b), eq (a==b), lt (a<b)
module comparator_2bit (
    input  wire [1:0] a,
    input  wire [1:0] b,
    output wire       gt,
    output wire       eq,
    output wire       lt
);

    wire x0, x1;
    assign x0 = ~(a[0] ^ b[0]);
    assign x1 = ~(a[1] ^ b[1]);
    assign eq = x0 & x1;

    assign gt = (a[1] & ~b[1]) | (x1 & a[0] & ~b[0]);
    assign lt = (~a[1] & b[1]) | (x1 & ~a[0] & b[0]);

endmodule

// 4-bit comparator built hierarchically from two 2-bit comparators
module comparator_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire       gt,
    output wire       eq,
    output wire       lt
);

    wire gt_hi, eq_hi, lt_hi;   // a[3:2] vs b[3:2]
    wire gt_lo, eq_lo, lt_lo;   // a[1:0] vs b[1:0]

    comparator_2bit c_hi (.a(a[3:2]), .b(b[3:2]), .gt(gt_hi), .eq(eq_hi), .lt(lt_hi));
    comparator_2bit c_lo (.a(a[1:0]), .b(b[1:0]), .gt(gt_lo), .eq(eq_lo), .lt(lt_lo));

    assign eq = eq_hi & eq_lo;
    assign gt = gt_hi | (eq_hi & gt_lo);
    assign lt = lt_hi | (eq_hi & lt_lo);

endmodule
