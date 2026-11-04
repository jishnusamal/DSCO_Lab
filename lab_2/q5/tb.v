`timescale 1ns/1ps

module tb_q5;

    reg  [7:0] a, b;
    wire [11:0] sum;

    bcd_adder_2digit uut (
        .a(a), .b(b), .sum(sum)
    );

    initial begin
        $display("   a   b | h t o | expected (a+b)");
        $display("-----------------------------------");
        // 12 + 34 = 46
        a = 8'h12; b = 8'h34; #10;
        $display("%h  %h | %d %d %d | 46", a, b, sum[11:8], sum[7:4], sum[3:0]);
        // 99 + 99 = 198
        a = 8'h99; b = 8'h99; #10;
        $display("%h  %h | %d %d %d | 198", a, b, sum[11:8], sum[7:4], sum[3:0]);
        // 05 + 07 = 12
        a = 8'h05; b = 8'h07; #10;
        $display("%h  %h | %d %d %d | 12", a, b, sum[11:8], sum[7:4], sum[3:0]);
        // 45 + 55 = 100
        a = 8'h45; b = 8'h55; #10;
        $display("%h  %h | %d %d %d | 100", a, b, sum[11:8], sum[7:4], sum[3:0]);
        // 90 + 10 = 100
        a = 8'h90; b = 8'h10; #10;
        $display("%h  %h | %d %d %d | 100", a, b, sum[11:8], sum[7:4], sum[3:0]);
        // 00 + 00 = 0
        a = 8'h00; b = 8'h00; #10;
        $display("%h  %h | %d %d %d | 0", a, b, sum[11:8], sum[7:4], sum[3:0]);
        $finish;
    end

endmodule
