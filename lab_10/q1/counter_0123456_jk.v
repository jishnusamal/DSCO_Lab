// JK flip-flop, positive edge triggered
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

// Counter sequence 0,1,2,3,4,5,6 using JK FFs (mod-7)
// J0=K0=1, J1=K1=Q0, J2=K2=Q1&(Q0|Q2)
module counter_0123456_jk (
    input wire clk,
    input wire rst,
    output wire [2:0] q
);

    wire [2:0] q_w;
    wire dec6 = q_w[2] & q_w[1] & ~q_w[0];   // state 110

    assign j0 = ~dec6;  assign k0 = ~dec6;
    assign j1 = q_w[0] | dec6;  assign k1 = j1;
    assign j2 = (q_w[1] & q_w[0]) | dec6;    assign k2 = j2;

    jk_ff ff2 (.clk(clk), .rst(rst), .j(j2), .k(k2), .q(q_w[2]));
    jk_ff ff1 (.clk(clk), .rst(rst), .j(j1), .k(k1), .q(q_w[1]));
    jk_ff ff0 (.clk(clk), .rst(rst), .j(j0), .k(k0), .q(q_w[0]));

    assign q = q_w;

endmodule
