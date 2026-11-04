`timescale 1ns/1ps

module tb_q3;

    reg clk, rst, j, k;
    wire q;

    jk_ff_async_rst uut (.clk(clk), .rst(rst), .j(j), .k(k), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; j = 0; k = 0;
        #12 rst = 0;
        #10 j = 0; k = 1;   // reset
        #10 j = 1; k = 0;   // set
        #10 j = 1; k = 1;   // toggle
        #10 j = 1; k = 1;   // toggle
        #10 j = 0; k = 0;   // hold
        #10 rst = 1;        // async reset
        #20 $finish;
    end

    initial begin
        $display("clk rst j k | q | expected");
        $display("-------------------------");
        #6  $display("%b  %b  %b %b | %b | 0 (reset)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 0 (hold)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 0 (reset)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 1 (set)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 0 (toggle)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 1 (toggle)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 1 (hold)", clk, rst, j, k, q);
        #10 $display("%b  %b  %b %b | %b | 0 (async reset)", clk, rst, j, k, q);
    end

endmodule
