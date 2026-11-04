// 4:1 multiplexer
module mux_4to1 (
    input  wire [3:0] d,
    input  wire [1:0] sel,
    output wire       y
);

    assign y = (sel == 2'b00) ? d[0] :
               (sel == 2'b01) ? d[1] :
               (sel == 2'b10) ? d[2] :
               (sel == 2'b11) ? d[3] : 1'b0;

endmodule

// F(A,B,C,D) = sum m(0,1,2,4,6,9,12,14) using 4:1 mux
// Select: {A,B}. Data inputs (function of C,D):
//   I0 (AB=00): ~(C&D)   I1 (AB=01): ~D
//   I2 (AB=10): ~C&D     I3 (AB=11): ~C
module f_q1 (
    input wire A,
    input wire B,
    input wire C,
    input wire D,
    output wire f
);

    wire nc, nd;
    wire i0, i1, i2, i3;

    assign nc = ~C;
    assign nd = ~D;

    assign i0 = ~(C & D);
    assign i1 = nd;
    assign i2 = nc & D;
    assign i3 = nc;

    mux_4to1 mux (
        .d({i3, i2, i1, i0}),
        .sel({A, B}),
        .y(f)
    );

endmodule
