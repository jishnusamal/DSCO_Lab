`timescale 1ns/1ps

module tb_qb;

    reg  [3:0] a, b;
    wire gt, eq, lt;

    comparator_4bit uut (.a(a), .b(b), .gt(gt), .eq(eq), .lt(lt));

    initial begin
        $display("a b | gt eq lt | expected");
        $display("-------------------------");
        a = 4'd9;  b = 4'd9;  #10; $display("%d %d | %b  %b  %b | 0 1 0", a, b, gt, eq, lt);
        a = 4'd12; b = 4'd5;  #10; $display("%d %d | %b  %b  %b | 1 0 0", a, b, gt, eq, lt);
        a = 4'd3;  b = 4'd10; #10; $display("%d %d | %b  %b  %b | 0 0 1", a, b, gt, eq, lt);
        a = 4'd7;  b = 4'd8;  #10; $display("%d %d | %b  %b  %b | 0 0 1", a, b, gt, eq, lt);
        a = 4'd15; b = 4'd0;  #10; $display("%d %d | %b  %b  %b | 1 0 0", a, b, gt, eq, lt);
        $finish;
    end

endmodule
