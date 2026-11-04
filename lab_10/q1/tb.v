`timescale 1ns/1ps

module tb_q1;

    reg clk, rst;
    wire [2:0] q;

    counter_0123456_jk uut (.clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    integer i;
    reg [2:0] seq [0:6];
    initial begin
        seq[0]=3'b000; seq[1]=3'b001; seq[2]=3'b010; seq[3]=3'b011;
        seq[4]=3'b100; seq[5]=3'b101; seq[6]=3'b110;
        clk = 0; rst = 1;
        #12 rst = 0;
        $display("clk | q | label");
        $display("----------------");
        for (i = 0; i < 14; i = i + 1) begin
            #10 $display("%b  | %b | %d", clk, q, seq[i%7]);
        end
        $finish;
    end

endmodule
