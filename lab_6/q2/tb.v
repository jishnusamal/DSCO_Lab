`timescale 1ns/1ps

module tb_q2;

    reg clk, rst_bar, t;
    wire q;

    t_ff_neg_sync_rst uut (.clk(clk), .rst_bar(rst_bar), .t(t), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst_bar = 0; t = 0;
        #12 rst_bar = 1; t = 1;
        #10 t = 0;
        #10 t = 1;
        #10 t = 1;
        #10 rst_bar = 0;
        #20 $finish;
    end

    initial begin
        $display("clk rst_b t | q | expected");
        $display("-------------------------");
        #6  $display("%b  %b   %b | %b | 0 (reset)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 1 (toggle)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 1 (hold)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 0 (toggle)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 1 (toggle)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 0 (reset)", clk, rst_bar, t, q);
        #10 $display("%b  %b   %b | %b | 0 (hold)", clk, rst_bar, t, q);
    end

endmodule
