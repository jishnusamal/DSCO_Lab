`timescale 1ns/1ps

module tb_a2;

    reg clk, rst_bar, j, k;
    wire q;

    jk_ff_async_rst_low uut (.clk(clk), .rst_bar(rst_bar), .j(j), .k(k), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst_bar = 0; j = 0; k = 0;
        #12 rst_bar = 1;
        #10 j = 0; k = 1;   // reset
        #10 j = 1; k = 0;   // set
        #10 j = 1; k = 1;   // toggle
        #10 j = 1; k = 1;   // toggle
        #10 j = 0; k = 0;   // hold
        #10 rst_bar = 0;    // async reset
        #20 $finish;
    end

    initial begin
        $display("clk rst_b j k | q | expected");
        $display("-----------------------------");
        #6  $display("%b  %b   %b %b | %b | 0 (reset)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 0 (hold)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 0 (reset)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 1 (set)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 0 (toggle)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 1 (toggle)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 1 (hold)", clk, rst_bar, j, k, q);
        #10 $display("%b  %b   %b %b | %b | 0 (async reset)", clk, rst_bar, j, k, q);
    end

endmodule
