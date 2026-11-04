// 4 bit shift register with parallel load
// Shift Load | Operation
//   0 0      | Shift left
//   0 1      | Load parallel data
//   1 X      | No change
module shift_reg_4bit_pl_v2 (
    input wire clk,
    input wire rst,
    input wire shift,
    input wire load,
    input wire sin,
    input wire [3:0] d,
    output wire [3:0] q
);

    reg [3:0] q_reg;
    wire [3:0] next_q;

    assign next_q = load ? d :
                    shift ? q_reg :           // 1X -> no change
                    {q_reg[2:0], sin};        // 00 -> shift left

    always @(posedge clk or posedge rst) begin
        if (rst)
            q_reg <= 4'b0;
        else
            q_reg <= next_q;
    end

    assign q = q_reg;

endmodule
