// 8-to-1 multiplexer
module mux_8to1 (
    input  wire [7:0] d,
    input  wire [2:0] sel,
    output wire       y
);

    assign y = (sel == 3'b000) ? d[0] :
               (sel == 3'b001) ? d[1] :
               (sel == 3'b010) ? d[2] :
               (sel == 3'b011) ? d[3] :
               (sel == 3'b100) ? d[4] :
               (sel == 3'b101) ? d[5] :
               (sel == 3'b110) ? d[6] :
               (sel == 3'b111) ? d[7] : 1'b0;

endmodule

// 4-bit Gray to Binary using 8:1 multiplexers
// g = gray input (g3 g2 g1 g0), b = binary output (b3 b2 b1 b0)
// b3 = g3
// b2 = g3 ^ g2
// b1 = g3 ^ g2 ^ g1
// b0 = g3 ^ g2 ^ g1 ^ g0
module gray_to_binary_4bit (
    input  wire [3:0] g,
    output wire [3:0] b
);

    wire g3, g2, g1, g0;
    assign g3 = g[3]; assign g2 = g[2]; assign g1 = g[1]; assign g0 = g[0];

    // b3 = g3: sel={g2,g1,g0}, all data = g3
    mux_8to1 m3 (.d({g3,g3,g3,g3,g3,g3,g3,g3}), .sel({g2, g1, g0}), .y(b[3]));

    // b2 = g3 ^ g2: sel={g3,g1,g0}; g3=0->g2, g3=1->~g2
    mux_8to1 m2 (.d({~g2,~g2,~g2,~g2, g2,g2,g2,g2}), .sel({g3, g1, g0}), .y(b[2]));

    // b1 = g3^g2^g1: sel={g3,g2,g0}; data=g1 when g3==g2, ~g1 when g3!=g2
    mux_8to1 m1 (.d({g1,g1, ~g1,~g1, ~g1,~g1, g1,g1}), .sel({g3, g2, g0}), .y(b[1]));

    // b0 = g3^g2^g1^g0: sel={g3,g2,g1}; data=g0 on even parity, ~g0 on odd
    mux_8to1 m0 (.d({~g0, g0, g0, ~g0, g0, ~g0, ~g0, g0}), .sel({g3, g2, g1}), .y(b[0]));

endmodule
