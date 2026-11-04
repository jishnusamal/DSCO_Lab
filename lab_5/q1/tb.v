`timescale 1ns/1ps

module tb_q1;

    reg A, B, C, D;
    wire f;

    f_q1 uut (.A(A), .B(B), .C(C), .D(D), .f(f));

    reg [15:0] expected;
    integer i;

    initial begin
        // minterms: 0,1,2,4,6,9,12,14
        expected = 16'b0;
        expected[0]  = 1; expected[1]  = 1; expected[2]  = 1;
        expected[4]  = 1; expected[6]  = 1;
        expected[9]  = 1; expected[12] = 1; expected[14] = 1;

        $display("A B C D | f | expected");
        $display("----------------------");
        for (i = 0; i < 16; i = i + 1) begin
            {A, B, C, D} = i;
            #10;
            $display("%b %b %b %b | %b | %b", A, B, C, D, f, expected[i]);
        end
        $finish;
    end

endmodule
