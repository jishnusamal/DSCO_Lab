// Lab 8 Additional Q1: Sequential circuit with 2 JK FFs (A, B) and inputs E, x
// E = 0  : hold state
// E = 1, x = 1 : count up   (00->01->10->11->00)
// E = 1, x = 0 : count down (00->11->10->01->00)
//
// Derived:
// JA = E & ~A & ~(x ^ B)     KA = E & A & ~(x ^ B)
// JB = E & ~B                KB = E & B

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
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
        end
    end

endmodule

module seq_jk_ex (
    input wire clk,
    input wire rst,
    input wire e,
    input wire x,
    output wire [1:0] q   // {A, B}
);

    wire a, b;
    wire ja, ka, jb, kb;

    assign ja = e & ~a & ~(x ^ b);
    assign ka = e &  a & ~(x ^ b);
    assign jb = e & ~b;
    assign kb = e &  b;

    jk_ff fa (.clk(clk), .rst(rst), .j(ja), .k(ka), .q(a));
    jk_ff fb (.clk(clk), .rst(rst), .j(jb), .k(kb), .q(b));

    assign q = {a, b};

endmodule
