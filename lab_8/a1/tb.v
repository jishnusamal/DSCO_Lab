`timescale 1ns/1ps

module tb_a1;

    reg clk, rst, e, x;
    wire [1:0] q;

    seq_jk_ex uut (.clk(clk), .rst(rst), .e(e), .x(x), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; e = 0; x = 0;
        #12 rst = 0;
        $display("clk rst e x | q | label");
        $display("-------------------------");
        #10 $display("%b  %b   %b  %b | %b | reset", clk, rst, e, x, q);
        e = 1; x = 1; #10 $display("%b  %b   %b  %b | %b | up 00->01", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | up 01->10", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | up 10->11", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | up 11->00", clk, rst, e, x, q);
        x = 0; #10 $display("%b  %b   %b  %b | %b | down 00->11", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | down 11->10", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | down 10->01", clk, rst, e, x, q);
        #10 $display("%b  %b   %b  %b | %b | down 01->00", clk, rst, e, x, q);
        e = 0; #10 $display("%b  %b   %b  %b | %b | hold", clk, rst, e, x, q);
        $finish;
    end

endmodule
