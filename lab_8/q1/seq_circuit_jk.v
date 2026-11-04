// Lab 8 Q1: State-reduced sequential circuit using JK flip-flops
//
// Original state table (from image):
// PS | NS x=0 | NS x=1 | Out x=0 | Out x=1
// a  | f      | b      | 0       | 0
// b  | d      | c      | 0       | 0
// c  | f      | e      | 0       | 0
// d  | g      | a      | 1       | 0
// e  | d      | c      | 0       | 0
// f  | f      | b      | 1       | 1
// g  | g      | h      | 0       | 1
// h  | g      | a      | 1       | 0
//
// State reduction:
// b == e (d,c / 0,0), d == h (g,a / 1,0), a == c (f,b / 0,0)
// Reduced states: A={a,c}, B={b,e}, D={d,h}, f, g  (5 states)
// Encoding: A=000, B=001, D=010, f=011, g=100
//
// Reduced table:
// PS | NS x=0 | NS x=1 | Out x=0 | Out x=1
// A  | f      | B      | 0       | 0
// B  | D      | A      | 0       | 0
// D  | g      | A      | 1       | 0
// f  | f      | B      | 1       | 1
// g  | g      | D      | 0       | 1
//
// JK FF excitation: J = Q* & ~Q,  K = ~Q* & Q   (functionally correct)
// 3 FFs: Q2 Q1 Q0

// JK flip flop (positive edge)
module jk_ff (
    input wire clk,
    input wire rst,
    input wire j,
    input wire k,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;     // hold
                2'b01: q <= 1'b0;  // reset
                2'b10: q <= 1'b1;  // set
                2'b11: q <= ~q;    // toggle
            endcase
        end
    end

endmodule

// State encoding
`define ST_A  3'b000
`define ST_B  3'b001
`define ST_D  3'b010
`define ST_F  3'b011
`define ST_G  3'b100

module seq_circuit_jk (
    input wire clk,
    input wire rst,
    input wire x,
    output wire y
);

    reg [2:0] next_state;
    wire [2:0] state;
    wire [2:0] J, K;

    // Combinational next-state and output logic
    always @(*) begin
        next_state = state;
        case ({state, x})
            {`ST_A, 1'b0}: next_state = `ST_F;
            {`ST_A, 1'b1}: next_state = `ST_B;
            {`ST_B, 1'b0}: next_state = `ST_D;
            {`ST_B, 1'b1}: next_state = `ST_A;
            {`ST_D, 1'b0}: next_state = `ST_G;
            {`ST_D, 1'b1}: next_state = `ST_A;
            {`ST_F, 1'b0}: next_state = `ST_F;
            {`ST_F, 1'b1}: next_state = `ST_B;
            {`ST_G, 1'b0}: next_state = `ST_G;
            {`ST_G, 1'b1}: next_state = `ST_D;
            default:       next_state = `ST_A;
        endcase
    end

    // Output y (Mealy)
    assign y = (state == `ST_D && x == 1'b0) ||
               (state == `ST_F) ||
               (state == `ST_G && x == 1'b1);

    // JK excitation inputs: J = Q* & ~Q, K = ~Q* & Q
    assign J[2] = next_state[2] & ~state[2];
    assign K[2] = ~next_state[2] & state[2];
    assign J[1] = next_state[1] & ~state[1];
    assign K[1] = ~next_state[1] & state[1];
    assign J[0] = next_state[0] & ~state[0];
    assign K[0] = ~next_state[0] & state[0];

    // State register (3 JK flip-flops) -> state wires
    wire [2:0] state_w;
    jk_ff ff2 (.clk(clk), .rst(rst), .j(J[2]), .k(K[2]), .q(state_w[2]));
    jk_ff ff1 (.clk(clk), .rst(rst), .j(J[1]), .k(K[1]), .q(state_w[1]));
    jk_ff ff0 (.clk(clk), .rst(rst), .j(J[0]), .k(K[0]), .q(state_w[0]));
    assign state = state_w;

endmodule
