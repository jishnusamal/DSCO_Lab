`timescale 1ns/1ps

module tb_q2b;

    reg A, B, C, D;
    wire f;

    f_q2b uut (
        .A(A), .B(B), .C(C), .D(D), .f(f)
    );

    initial begin
        $display("A B C D | f (expected)");
        $display("---------------------");
        A = 0; B = 0; C = 0; D = 0; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 0; B = 0; C = 0; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 0; B = 0; C = 1; D = 0; #10;
        $display("%b %b %b %b | %b (0)", A, B, C, D, f);
        A = 0; B = 0; C = 1; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 0; B = 1; C = 0; D = 0; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 0; B = 1; C = 0; D = 1; #10;
        $display("%b %b %b %b | %b (0)", A, B, C, D, f);
        A = 0; B = 1; C = 1; D = 0; #10;
        $display("%b %b %b %b | %b (0)", A, B, C, D, f);
        A = 0; B = 1; C = 1; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 1; B = 0; C = 0; D = 0; #10;
        $display("%b %b %b %b | %b (0)", A, B, C, D, f);
        A = 1; B = 0; C = 0; D = 1; #10;
        $display("%b %b %b %b | %b (x/dc)", A, B, C, D, f);
        A = 1; B = 0; C = 1; D = 0; #10;
        $display("%b %b %b %b | %b (0)", A, B, C, D, f);
        A = 1; B = 0; C = 1; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 1; B = 1; C = 0; D = 0; #10;
        $display("%b %b %b %b | %b (x/dc)", A, B, C, D, f);
        A = 1; B = 1; C = 0; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        A = 1; B = 1; C = 1; D = 0; #10;
        $display("%b %b %b %b | %b (x/dc)", A, B, C, D, f);
        A = 1; B = 1; C = 1; D = 1; #10;
        $display("%b %b %b %b | %b (1)", A, B, C, D, f);
        $finish;
    end

endmodule
