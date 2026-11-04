// 4-to-1 mux
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

// BCD to 2421 code converter using 4:1 muxes
// BCD input A B C D (A=MSB), output 2421 code W X Y Z
// 2421 truth table (valid BCD 0-9):
//   0:0000 1:0001 2:0010 3:0011 4:0100 5:1011 6:1100 7:1101 8:1110 9:1111
// Select {A,B}; data inputs are functions of C,D:
//   W: I0=0, I1=C|D, I2=1, I3=0(dc)
//   X: I0=C,   I1=~D,   I2=1, I3=0(dc)
//   Y: I0=D,   I1=D,    I2=1, I3=0(dc)
//   Z: I0=D,   I1=D,    I2=D, I3=0(dc)
module bcd_to_2421 (
    input  wire [3:0] bcd,
    output wire [3:0] code
);

    wire A, B, C, D;
    wire nc, nd;
    assign A = bcd[3]; assign B = bcd[2]; assign C = bcd[1]; assign D = bcd[0];
    assign nc = ~C; assign nd = ~D;

    wire w0, w1, w2, w3;
    wire x0, x1, x2, x3;
    wire y0, y1, y2, y3;
    wire z0, z1, z2, z3;

    assign w0 = 1'b0;  assign w1 = C | D;   assign w2 = 1'b1;  assign w3 = 1'b0;
    assign x0 = C;     assign x1 = C | nd;  assign x2 = 1'b1;  assign x3 = 1'b0;
    assign y0 = C;     assign y1 = nc & D;  assign y2 = 1'b1;  assign y3 = 1'b0;
    assign z0 = D;     assign z1 = D;       assign z2 = D;     assign z3 = 1'b0;

    mux_4to1 mw (.d({w3, w2, w1, w0}), .sel({A, B}), .y(code[3])); // W
    mux_4to1 mx (.d({x3, x2, x1, x0}), .sel({A, B}), .y(code[2])); // X
    mux_4to1 my (.d({y3, y2, y1, y0}), .sel({A, B}), .y(code[1])); // Y
    mux_4to1 mz (.d({z3, z2, z1, z0}), .sel({A, B}), .y(code[0])); // Z

endmodule
