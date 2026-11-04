`timescale 1ns/1ps

module tb_a1;

    reg clk, rst;
    wire [3:0] q;

    counter_custom_t uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    integer i;
    reg [3:0] seq [0:11];
    initial begin
        seq[0]=4'b0000; seq[1]=4'b0001; seq[2]=4'b0010; seq[3]=4'b0101;
        seq[4]=4'b0100; seq[5]=4'b0110; seq[6]=4'b1000; seq[7]=4'b1001;
        seq[8]=4'b1100; seq[9]=4'b1011; seq[10]=4'b1101; seq[11]=4'b1111;
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | q | label");
        $display("------------------");
        for (i = 0; i < 16; i = i + 1) begin
            #10 $display("%b  | %b | %d", clk, q, seq[i%12]);
        end
        $finish;
    end

endmodule
