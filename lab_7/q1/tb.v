`timescale 1ns/1ps

module tb_q1;

    reg clk, sin;
    wire [5:0] q;

    shift_reg_6bit uut (.clk(clk), .sin(sin), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; sin = 0;
        $display("clk sin | q[5:0]");
        $display("----------------");
        #6 $display("%b  %b  | %b", clk, sin, q);
        sin = 1; #10 $display("%b  %b  | %b", clk, sin, q);
        #10 $display("%b  %b  | %b", clk, sin, q);
        sin = 0; #10 $display("%b  %b  | %b", clk, sin, q);
        #10 $display("%b  %b  | %b", clk, sin, q);
        sin = 1; #10 $display("%b  %b  | %b", clk, sin, q);
        #10 $display("%b  %b  | %b", clk, sin, q);
        $finish;
    end

endmodule
