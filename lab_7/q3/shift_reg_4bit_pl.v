// 4 bit shift register with parallel load
// Shift Load | Operation
//   0 0      | Shift left
//   0 1      | Load parallel data
//   1 0      | Complement
//   1 1      | No change
module shift_reg_4bit_pl (
    input wire clk,
    input wire rst,
    input wire shift,
    input wire load,
    input wire sin,          // serial input for shift left
    input wire [3:0] d,      // parallel data in
    output wire [3:0] q
);

    reg [3:0] q_reg;
    wire [3:0] next_q;

    assign next_q = ( {shift, load} == 2'b00 ) ? {q_reg[2:0], sin} :   // shift left
                    ( {shift, load} == 2'b01 ) ? d :                    // load parallel
                    ( {shift, load} == 2'b10 ) ? ~q_reg :               // complement
                                                 q_reg;                 // no change

    always @(posedge clk or posedge rst) begin
        if (rst)
            q_reg <= 4'b0;
        else
            q_reg <= next_q;
    end

    assign q = q_reg;

endmodule
