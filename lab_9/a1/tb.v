`timescale 1ns/1ps

module tb_a1;

    reg clk, rst, w;
    wire [3:0] q;

    sync_updown_counter_4bit uut (.clk(clk), .rst(rst), .w(w), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; w = 1;
        #12 rst = 0;
        $display("clk rst w | q | label");
        $display("----------------------");
        #10 $display("%b  %b  %b | %b | reset", clk, rst, w, q);
        // Count up
        #10 $display("%b  %b  %b | %b | up 1", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | up 2", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | up 3", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | up 4", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | up 5", clk, rst, w, q);
        w = 0;
        #10 $display("%b  %b  %b | %b | down 1", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | down 2", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | down 3", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | down 4", clk, rst, w, q);
        $finish;
    end

endmodule
