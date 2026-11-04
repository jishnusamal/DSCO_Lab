`timescale 1ns/1ps

module tb_q1;

    reg clk, rst, d;
    wire q;

    d_ff_sync_rst uut (.clk(clk), .rst(rst), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; d = 0;     // reset active
        #12 rst = 0; d = 1;
        #10 d = 0;
        #10 d = 1;
        #10 d = 0;
        #10 rst = 1; d = 1;          // reset again
        #10 rst = 0;
        #20 $finish;
    end

    initial begin
        $display("clk rst d | q | expected");
        $display("---------------------");
        #6  $display("%b  %b  %b | %b | 0 (reset)", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 1", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 0", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 1", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 0", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 0 (reset)", clk, rst, d, q);
        #10 $display("%b  %b  %b | %b | 0", clk, rst, d, q);
    end

endmodule
