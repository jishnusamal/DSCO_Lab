// Lab 8 Additional Q2: Synchronous sequential circuit using D flip-flops
// State diagram (from image 3), states are 3-bit values:
//   001: in=0->100, in=1->001
//   100: in=0->011, in=1->010
//   011: in=0->010, in=1->100
//   010: in=0->000, in=1->010
//   000: in=1->010   (in=0 unused -> hold 000)
// Since D FFs: D_input = next_state bits directly.

// D flip flop (positive edge, with sync reset)
module d_ff (
    input wire clk,
    input wire rst,
    input wire d,
    output reg q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule

module seq_circuit_d (
    input wire clk,
    input wire rst,
    input wire in,
    output wire [2:0] q
);

    reg [2:0] next_state;
    wire [2:0] state;

    // Combinational next-state logic (D input = next state for D FFs)
    always @(*) begin
        next_state = state;
        case ({state, in})
            {3'b001, 1'b0}: next_state = 3'b100;
            {3'b001, 1'b1}: next_state = 3'b001;
            {3'b100, 1'b0}: next_state = 3'b011;
            {3'b100, 1'b1}: next_state = 3'b010;
            {3'b011, 1'b0}: next_state = 3'b010;
            {3'b011, 1'b1}: next_state = 3'b100;
            {3'b010, 1'b0}: next_state = 3'b000;
            {3'b010, 1'b1}: next_state = 3'b010;
            {3'b000, 1'b1}: next_state = 3'b010;
            default:          next_state = 3'b000;
        endcase
    end

    // D FF inputs = next_state bits
    wire [2:0] state_w;
    d_ff ff2 (.clk(clk), .rst(rst), .d(next_state[2]), .q(state_w[2]));
    d_ff ff1 (.clk(clk), .rst(rst), .d(next_state[1]), .q(state_w[1]));
    d_ff ff0 (.clk(clk), .rst(rst), .d(next_state[0]), .q(state_w[0]));
    assign state = state_w;

    assign q = state;

endmodule
