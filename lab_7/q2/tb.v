`timescale 1ns/1ps

module tb_q2;

    parameter N = 8;
    reg clk, load;
    reg [N-1:0] d;
    wire [N-1:0] q;

    reg_n #(N) uut (.clk(clk), .load(load), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; load = 0; d = 8'b0;
        $display("clk load d       | q       | operation");
        $display("--------------------------------------");
        #6  $display("%b   %b   %b | %b | hold", clk, load, d, q);
        load = 1; d = 8'hA5; #10 $display("%b   %b   %h | %h | load A5", clk, load, d, q);
        #10 $display("%b   %b   %b | %h | hold", clk, load, d, q);
        load = 0; d = 8'h3C; #10 $display("%b   %b   %h | %h | hold (no load)", clk, load, d, q);
        load = 1; d = 8'h3C; #10 $display("%b   %b   %h | %h | load 3C", clk, load, d, q);
        $finish;
    end

endmodule
