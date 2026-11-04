`timescale 1ns/1ps

module tb_q4;

    reg clk, rst_bar, s, r;
    wire q;

    sr_ff_neg_async_rst uut (.clk(clk), .rst_bar(rst_bar), .s(s), .r(r), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst_bar = 0; s = 0; r = 0;
        #12 rst_bar = 1;
        #10 s = 0; r = 1;   // reset
        #10 s = 1; r = 0;   // set
        #10 s = 1; r = 1;   // invalid -> hold
        #10 s = 0; r = 0;   // hold
        #10 rst_bar = 0;    // async reset
        #20 $finish;
    end

    initial begin
        $display("clk rst_b s r | q | expected");
        $display("----------------------------");
        #6  $display("%b  %b   %b %b | %b | 0 (reset)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 0 (hold)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 0 (reset)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 1 (set)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 1 (hold-invalid)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 1 (hold)", clk, rst_bar, s, r, q);
        #10 $display("%b  %b   %b %b | %b | 0 (async reset)", clk, rst_bar, s, r, q);
    end

endmodule
