`timescale 1ns/1ps

module tb_q4;

    reg  [2:0] a, b;
    wire [5:0] p;

    multiplier_3x3 uut (
        .a(a), .b(b), .p(p)
    );

    initial begin
        $display(" a  b |   p | expected (a*b)");
        $display("---------------------------");
        a = 3'd0; b = 3'd0; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 0);
        a = 3'd2; b = 3'd3; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 6);
        a = 3'd5; b = 3'd4; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 20);
        a = 3'd7; b = 3'd7; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 49);
        a = 3'd1; b = 3'd7; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 7);
        a = 3'd6; b = 3'd5; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 30);
        a = 3'd7; b = 3'd0; #10;
        $display("%d  %d | %03d | %03d", a, b, p, 0);
        $finish;
    end

endmodule
