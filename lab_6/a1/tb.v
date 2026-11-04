`timescale 1ns/1ps

module tb_a1;

    reg clk, rst, t;
    wire q;

    t_ff_neg_sync_rst_high uut (.clk(clk), .rst(rst), .t(t), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; t = 0;
        #12 rst = 0; t = 1;
        #10 t = 0;
        #10 t = 1;
        #10 t = 1;
        #10 rst = 1;
        #20 $finish;
    end

    initial begin
        $display("clk rst t | q | expected");
        $display("---------------------");
        #6  $display("%b  %b  %b | %b | 0 (reset)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 1 (toggle)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 1 (hold)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 0 (toggle)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 1 (toggle)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 0 (reset)", clk, rst, t, q);
        #10 $display("%b  %b  %b | %b | 0 (hold)", clk, rst, t, q);
    end

endmodule
