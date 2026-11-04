`timescale 1ns/1ps

module tb_a2;

    reg clk, rst;
    wire out;

    every_5th_pulse uut (.clk(clk), .rst(rst), .out(out));

    always #5 clk = ~clk;

    integer i;
    initial begin
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | out | label");
        $display("----------------");
        for (i = 0; i < 22; i = i + 1) begin
            #10 $display("%b  | %b   | pulse%d", clk, out, i+1);
        end
        $finish;
    end

endmodule
