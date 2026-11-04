`timescale 1ns/1ps

module tb_q3;

    reg  [3:0] a, b;
    reg        sub;
    wire [3:0] sum;
    wire       cout;

    adder_subtractor_4bit uut (
        .a(a), .b(b), .sub(sub), .sum(sum), .cout(cout)
    );

    initial begin
        $display("sub |  a   b | sum cout | expected");
        $display("--------------------------------");
        // Addition: 5 + 3 = 8
        sub = 0; a = 4'd5; b = 4'd3; #10;
        $display("%b  | %d %d | %d  %b   | %d", sub, a, b, sum, cout, 8);
        // Addition: 15 + 1 = 0 (wrap)
        sub = 0; a = 4'd15; b = 4'd1; #10;
        $display("%b  | %d %d | %d  %b   | %d", sub, a, b, sum, cout, 0);
        // Subtraction: 5 - 3 = 2
        sub = 1; a = 4'd5; b = 4'd3; #10;
        $display("%b  | %d %d | %d  %b   | %d", sub, a, b, sum, cout, 2);
        // Subtraction: 3 - 5 = -2 = 14 (2's comp, 4-bit)
        sub = 1; a = 4'd3; b = 4'd5; #10;
        $display("%b  | %d %d | %d  %b   | %d", sub, a, b, sum, cout, 14);
        // Subtraction: 0 - 1 = 15
        sub = 1; a = 4'd0; b = 4'd1; #10;
        $display("%b  | %d %d | %d  %b   | %d", sub, a, b, sum, cout, 15);
        $finish;
    end

endmodule
