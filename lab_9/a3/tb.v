`timescale 1ns/1ps

module tb_a3;

    reg clk, rst;
    wire [3:0] ones, tens;

    bcd_counter_2digit uut (.clk(clk), .rst(rst), .ones(ones), .tens(tens));

    always #5 clk = ~clk;

    integer i;
    initial begin
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | tens ones | BCD");
        $display("------------------");
        for (i = 0; i < 22; i = i + 1) begin
            #10 $display("%b  | %d   %d   | %d%d", clk, tens, ones, tens, ones);
        end
        $finish;
    end

endmodule
