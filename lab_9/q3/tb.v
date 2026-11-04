`timescale 1ns/1ps

module tb_q3;

    reg clk, rst;
    wire [3:0] q;

    async_up_counter_4bit uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    integer i;
    initial begin
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | q");
        $display("---------");
        for (i = 0; i < 18; i = i + 1) begin
            #10 $display("%b  | %b", clk, q);
        end
        $finish;
    end

endmodule
