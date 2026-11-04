`timescale 1ns/1ps

module tb_a2;

    reg clk, rst, in;
    wire [2:0] q;

    seq_circuit_d uut (.clk(clk), .rst(rst), .in(in), .q(q));

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; in = 0;
        #12 rst = 0;
        $display("clk rst in | q | label");
        $display("-------------------------");
        #10 $display("%b  %b   %b  | %b | reset(000)", clk, rst, in, q);
        // Drive: 000 --in=1--> 010 --in=0--> 000 --in=1--> 010 --in=1--> 010
        in = 1; #10 $display("%b  %b   %b  | %b | 000->010", clk, rst, in, q);
        in = 0; #10 $display("%b  %b   %b  | %b | 010->000", clk, rst, in, q);
        in = 1; #10 $display("%b  %b   %b  | %b | 000->010", clk, rst, in, q);
        in = 1; #10 $display("%b  %b   %b  | %b | 010->010(self)", clk, rst, in, q);
        // From 010: 010->010(self on in=1), then in=0 ->000
        in = 0; #10 $display("%b  %b   %b  | %b | 010->000", clk, rst, in, q);
        $finish;
    end

endmodule
