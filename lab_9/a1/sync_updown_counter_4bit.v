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

// 4-bit synchronous up/down counter using JK FFs, control W
// W=1: count up, W=0: count down
module sync_updown_counter_4bit (
    input wire clk,
    input wire rst,
    input wire w,
    output wire [3:0] q
);

    wire [3:0] q_w;
    wire j0, k0, j1, k1, j2, k2, j3, k3;

    // Q0 toggles every clock
    assign j0 = 1'b1;  assign k0 = 1'b1;
    // Q1 toggles: up when Q0=1, down when Q0=0
    assign j1 = w ? q_w[0] : ~q_w[0];
    assign k1 = j1;
    // Q2 toggles: up when Q1&Q0, down when ~Q1&~Q0
    assign j2 = w ? (q_w[1] & q_w[0]) : (~q_w[1] & ~q_w[0]);
    assign k2 = j2;
    // Q3 toggles: up when Q2&Q1&Q0, down when ~Q2&~Q1&~Q0
    assign j3 = w ? (q_w[2] & q_w[1] & q_w[0]) : (~q_w[2] & ~q_w[1] & ~q_w[0]);
    assign k3 = j3;

    jk_ff ff3 (.clk(clk), .rst(rst), .j(j3), .k(k3), .q(q_w[3]));
    jk_ff ff2 (.clk(clk), .rst(rst), .j(j2), .k(k2), .q(q_w[2]));
    jk_ff ff1 (.clk(clk), .rst(rst), .j(j1), .k(k1), .q(q_w[1]));
    jk_ff ff0 (.clk(clk), .rst(rst), .j(j0), .k(k0), .q(q_w[0]));

    assign q = q_w;

endmodule
