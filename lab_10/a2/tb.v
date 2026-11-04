`timescale 1ns/1ps

module tb_a2;

    reg clk, rst, w;
    wire [2:0] q;

    counter_control_w_t uut (.clk(clk), .rst(rst), .w(w), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; w = 0;
        #12 rst = 0;
        $display("clk rst w | q | label");
        $display("-------------------------");
        #10 $display("%b  %b   %b | %b | reset(0)", clk, rst, w, q);
        // w=0 sequence: 0,2,3,4,6
        w = 0;
        #10 $display("%b  %b   %b | %b | w=0  2", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=0  3", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=0  4", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=0  6", clk, rst, w, q);
        // switch to w=1 sequence: 6,4,3,2,0
        w = 1;
        #10 $display("%b  %b   %b | %b | w=1  4", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=1  3", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=1  2", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=1  0", clk, rst, w, q);
        #10 $display("%b  %b   %b | %b | w=1  6", clk, rst, w, q);
        $finish;
    end

endmodule
