`timescale 1ns/1ps

module tb_a1;

    parameter N = 8;
    reg clk, rst, sin;
    wire [N-1:0] q;

    shift_reg_n #(N) uut (.clk(clk), .rst(rst), .sin(sin), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; sin = 0;
        #12 rst = 0;
        $display("clk rst sin | q");
        $display("---------------");
        #6 $display("%b  %b   %b  | %b", clk, rst, sin, q);
        sin = 1; #10 $display("%b  %b   %b  | %b", clk, rst, sin, q);
        #10 $display("%b  %b   %b  | %b", clk, rst, sin, q);
        sin = 0; #10 $display("%b  %b   %b  | %b", clk, rst, sin, q);
        #10 $display("%b  %b   %b  | %b", clk, rst, sin, q);
        $finish;
    end

endmodule
