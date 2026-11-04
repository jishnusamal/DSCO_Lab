`timescale 1ns/1ps

module tb_q3;

    reg a, b, c, d;
    wire f;

    f_q3 uut (.a(a), .b(b), .c(c), .d(d), .f(f));

    reg [15:0] expected;
    integer i;

    initial begin
        // minterms: 2,3,4,5,6,7,10,11,12,15
        expected = 16'b0;
        expected[2]=1; expected[3]=1; expected[4]=1; expected[5]=1;
        expected[6]=1; expected[7]=1; expected[10]=1; expected[11]=1;
        expected[12]=1; expected[15]=1;

        $display("a b c d | f | expected");
        $display("----------------------");
        for (i = 0; i < 16; i = i + 1) begin
            {a, b, c, d} = i;
            #10;
            $display("%b %b %b %b | %b | %b", a, b, c, d, f, expected[i]);
        end
        $finish;
    end

endmodule
