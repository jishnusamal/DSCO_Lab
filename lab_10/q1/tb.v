`timescale 1ns/1ps

module tb_q1;

    reg clk, rst;
    wire [2:0] q;

    counter_0123456_jk uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    integer i;
    initial begin
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | q | label");
        $display("----------------");
        for (i = 0; i < 12; i = i + 1) begin
            #10 $display("%b  | %b | count%d", clk, q, i%7);
        end
        $finish;
    end

endmodule
