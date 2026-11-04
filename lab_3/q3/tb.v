`timescale 1ns/1ps

module tb_q3;

    reg  [2:0] a, b;
    wire gt, eq, lt;

    comparator_3bit uut (.a(a), .b(b), .gt(gt), .eq(eq), .lt(lt));

    initial begin
        $display("a b | gt eq lt | expected (gt eq lt)");
        $display("------------------------------------");
        a = 3'd5; b = 3'd5; #10; $display("%d %d | %b  %b  %b | 0 1 0", a, b, gt, eq, lt);
        a = 3'd7; b = 3'd3; #10; $display("%d %d | %b  %b  %b | 1 0 0", a, b, gt, eq, lt);
        a = 3'd2; b = 3'd6; #10; $display("%d %d | %b  %b  %b | 0 0 1", a, b, gt, eq, lt);
        a = 3'd0; b = 3'd7; #10; $display("%d %d | %b  %b  %b | 0 0 1", a, b, gt, eq, lt);
        a = 3'd4; b = 3'd1; #10; $display("%d %d | %b  %b  %b | 1 0 0", a, b, gt, eq, lt);
        $finish;
    end

endmodule
