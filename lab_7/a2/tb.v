`timescale 1ns/1ps

module tb_a2;

    reg clk, rst, shift, load, sin;
    reg [3:0] d;
    wire [3:0] q;

    shift_reg_4bit_pl_v2 uut (.clk(clk), .rst(rst), .shift(shift), .load(load), .sin(sin), .d(d), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; shift = 0; load = 0; sin = 0; d = 4'b0;
        #12 rst = 0;
        $display("clk rst sh ld sin d  | q | operation");
        $display("-----------------------------------------");
        #10 $display("%b  %b   %b  %b  %b  %b | %b | reset", clk, rst, shift, load, sin, d, q);
        d = 4'b1010; load = 1; #10 $display("%b  %b   %b  %b  %b  %b | %b | load 1010", clk, rst, shift, load, sin, d, q);
        load = 0; shift = 0; sin = 1; #10 $display("%b  %b   %b  %b  %b  %b | %b | shift left", clk, rst, shift, load, sin, d, q);
        shift = 1; load = 0; #10 $display("%b  %b   %b  %b  %b  %b | %b | no change (10)", clk, rst, shift, load, sin, d, q);
        shift = 1; load = 1; #10 $display("%b  %b   %b  %b  %b  %b | %b | no change (11)", clk, rst, shift, load, sin, d, q);
        $finish;
    end

endmodule
