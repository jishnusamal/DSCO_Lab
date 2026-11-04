`timescale 1ns/1ps

module tb_a2;

    reg clk, rst, w;
    wire [2:0] q;

    counter_control_w_t uut (.clk(clk), .rst(rst), .w(w), .q(q));

    always #5 clk = ~clk;

    integer i;
    reg [2:0] seq0 [0:4];
    reg [2:0] seq1 [0:4];
    initial begin
        seq0[0]=3'b000; seq0[1]=3'b010; seq0[2]=3'b011; seq0[3]=3'b100; seq0[4]=3'b110;
        seq1[0]=3'b110; seq1[1]=3'b100; seq1[2]=3'b011; seq1[3]=3'b010; seq1[4]=3'b000;
        clk = 0; rst = 1; w = 0;
        #12 rst = 0;
        $display("clk rst w | q | label");
        $display("-------------------------");
        // w=0 sequence
        #10 $display("%b  %b  %b | %b | w=0 0", clk, rst, w, q);
        w = 0;
        #10 $display("%b  %b  %b | %b | w=0 2", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=0 3", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=0 4", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=0 6", clk, rst, w, q);
        // switch to w=1
        w = 1; #10 $display("%b  %b  %b | %b | w=1 4", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=1 3", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=1 2", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=1 0", clk, rst, w, q);
        #10 $display("%b  %b  %b | %b | w=1 6", clk, rst, w, q);
        $finish;
    end

endmodule
