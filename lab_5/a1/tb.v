`timescale 1ns/1ps

module tb_a1;

    reg  [3:0] bcd;
    wire [3:0] code;

    bcd_to_2421 uut (.bcd(bcd), .code(code));

    initial begin
        $display("bcd | code | expected (2421)");
        $display("---------------------------");
        bcd = 4'd0;  #10; $display("%d  | %b  | 0000", bcd, code);
        bcd = 4'd1;  #10; $display("%d  | %b  | 0001", bcd, code);
        bcd = 4'd4;  #10; $display("%d  | %b  | 0100", bcd, code);
        bcd = 4'd5;  #10; $display("%d  | %b  | 1011", bcd, code);
        bcd = 4'd6;  #10; $display("%d  | %b  | 1100", bcd, code);
        bcd = 4'd7;  #10; $display("%d  | %b  | 1101", bcd, code);
        bcd = 4'd8;  #10; $display("%d  | %b  | 1110", bcd, code);
        bcd = 4'd9;  #10; $display("%d  | %b  | 1111", bcd, code);
        $finish;
    end

endmodule
