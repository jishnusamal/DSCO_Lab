// Lab 10 Additional Q2: Synchronous counter using T flip-flops with control w
// w=0: 0,2,3,4,6   (000->010->011->100->110->000)
// w=1: 6,4,3,2,0   (110->100->011->010->000->110)
//
// Excitation equation: T = Q ^ Qnext  (Qnext depends on w)
// T flip-flop characteristic: Q_next = Q ^ T

`define UP0  3'b000
`define UP2  3'b010
`define UP3  3'b011
`define UP4  3'b100
`define UP6  3'b110

module counter_control_w_t (
    input wire clk,
    input wire rst,
    input wire w,
    output wire [2:0] q
);

    wire [2:0] state;
    reg  [2:0] next_state;
    wire [2:0] t;

    // State transition table (depends on control w)
    always @(*) begin
        if (w == 1'b0) begin
            case (state)
                `UP0: next_state = `UP2;
                `UP2: next_state = `UP3;
                `UP3: next_state = `UP4;
                `UP4: next_state = `UP6;
                `UP6: next_state = `UP0;
                default: next_state = `UP0;
            endcase
        end else begin
            case (state)
                `UP6: next_state = `UP4;
                `UP4: next_state = `UP3;
                `UP3: next_state = `UP2;
                `UP2: next_state = `UP0;
                `UP0: next_state = `UP6;
                default: next_state = `UP0;
            endcase
        end
    end

    // Flip-flop input equations: T = Q ^ Qnext
    assign t = state ^ next_state;

    // T flip-flops (characteristic equation)
    t_ff ff2 (.clk(clk), .rst(rst), .t(t[2]), .q(state[2]));
    t_ff ff1 (.clk(clk), .rst(rst), .t(t[1]), .q(state[1]));
    t_ff ff0 (.clk(clk), .rst(rst), .t(t[0]), .q(state[0]));

    assign q = state;

endmodule

// T flip-flop with characteristic equation Q_next = Q ^ T
module t_ff (
    input wire clk,
    input wire rst,
    input wire t,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= q ^ t;
    end

endmodule
