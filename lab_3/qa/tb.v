`timescale 1ns/1ps

module tb_qa;

    reg  [3:0] bcd;
    wire [3:0] xs3;

    bcd_to_excess3 uut (.bcd(bcd), .xs3(xs3));

    initial begin
        $display("bcd | xs3 | expected (bcd+3)");
        $display("---------------------------");
        bcd = 4'd0;  #10; $display("%d  | %d  | %d", bcd, xs3, 3);
        bcd = 4'd1;  #10; $display("%d  | %d  | %d", bcd, xs3, 4);
        bcd = 4'd5;  #10; $display("%d  | %d  | %d", bcd, xs3, 8);
        bcd = 4'd9;  #10; $display("%d  | %d  | %d", bcd, xs3, 12);
        bcd = 4'd6;  #10; $display("%d  | %d  | %d", bcd, xs3, 9);
        $finish;
    end

endmodule
