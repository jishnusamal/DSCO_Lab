`timescale 1ns/1ps

module tb_q1;

    reg a, b, c, d;
    wire f;

    f_q1 uut (
        .a(a), .b(b), .c(c), .d(d), .f(f)
    );

    integer i;
    reg [3:0] minterms;
    reg [15:0] expected;

    initial begin
        // minterms: 0,4,8,13,14,15 -> expected bits set at those positions
        expected = 16'b0;
        expected[0]  = 1;
        expected[4]  = 1;
        expected[8]  = 1;
        expected[13] = 1;
        expected[14] = 1;
        expected[15] = 1;

        $display("a b c d | f (expected)");
        $display("---------------------");
        for (i = 0; i < 16; i = i + 1) begin
            {a, b, c, d} = i;
            #10;
            $display("%b %b %b %b | %b (%b)", a, b, c, d, f, expected[i]);
        end
        $finish;
    end

endmodule
