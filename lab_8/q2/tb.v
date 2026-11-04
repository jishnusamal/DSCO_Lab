`timescale 1ns/1ps

module tb_q2;

    reg clk, rst, tin;
    wire [1:0] q;

    seq_circuit_t uut (.clk(clk), .rst(rst), .tin(tin), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; tin = 0;
        #12 rst = 0;
        $display("clk rst tin | q | expected");
        $display("---------------------------");
        // 00 --T=0--> 11 --T=0--> 10 --T=1--> 01 --T=0--> 00 --T=1--> 00
        tin = 0; #10 $display("%b  %b   %b  | %b | 00", clk, rst, tin, q);
        #10 $display("%b  %b   %b  | %b | 11 (00,T=0)", clk, rst, tin, q);
        #10 $display("%b  %b   %b  | %b | 11 (hold)", clk, rst, tin, q);
        tin = 1; #10 $display("%b  %b   %b  | %b | 10 (11,T=1)", clk, rst, tin, q);
        #10 $display("%b  %b   %b  | %b | 10 (hold)", clk, rst, tin, q);
        tin = 0; #10 $display("%b  %b   %b  | %b | 01 (10,T=0)", clk, rst, tin, q);
        #10 $display("%b  %b   %b  | %b | 01 (hold)", clk, rst, tin, q);
        tin = 1; #10 $display("%b  %b   %b  | %b | 00 (01,T=1)", clk, rst, tin, q);
        $finish;
    end

endmodule
