`timescale 1ns/1ps

module tb_q1;

    reg clk, rst, x;
    wire y;

    seq_circuit_jk uut (.clk(clk), .rst(rst), .x(x), .y(y));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; x = 0;
        #12 rst = 0;
        $display("clk rst x | state | y | expected");
        $display("-------------------------------");
        // Drive a sequence: A --x=1--> B --x=0--> D --x=0--> g --x=1--> D --x=1--> A
        x = 1; #10 $display("%b  %b  %b | %b   | %b | 0 (A->B)", clk, rst, x, uut.state, y);
        x = 0; #10 $display("%b  %b  %b | %b   | %b | 0 (B->D)", clk, rst, x, uut.state, y);
        x = 0; #10 $display("%b  %b  %b | %b   | %b | 1 (D->g)", clk, rst, x, uut.state, y);
        x = 1; #10 $display("%b  %b  %b | %b   | %b | 1 (g->D)", clk, rst, x, uut.state, y);
        x = 1; #10 $display("%b  %b  %b | %b   | %b | 0 (D->A)", clk, rst, x, uut.state, y);
        x = 1; #10 $display("%b  %b  %b | %b   | %b | 0 (A->B)", clk, rst, x, uut.state, y);
        x = 0; #10 $display("%b  %b  %b | %b   | %b | 1 (B->D)", clk, rst, x, uut.state, y);
        $finish;
    end

endmodule
