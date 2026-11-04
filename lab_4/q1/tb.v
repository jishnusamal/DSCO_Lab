`timescale 1ns/1ps

module tb_q1;

    reg  [1:0] a;
    reg        en_bar;
    wire [3:0] y;

    decoder_2to4_en_low uut (.a(a), .en_bar(en_bar), .y(y));

    initial begin
        $display("en_bar a | y | expected");
        $display("---------------------");
        en_bar = 1; a = 2'b00; #10; $display("%b  %b | %b | 0000 (disabled)", en_bar, a, y);
        en_bar = 0; a = 2'b00; #10; $display("%b  %b | %b | 0001", en_bar, a, y);
        en_bar = 0; a = 2'b01; #10; $display("%b  %b | %b | 0010", en_bar, a, y);
        en_bar = 0; a = 2'b10; #10; $display("%b  %b | %b | 0100", en_bar, a, y);
        en_bar = 0; a = 2'b11; #10; $display("%b  %b | %b | 1000", en_bar, a, y);
        en_bar = 1; a = 2'b11; #10; $display("%b  %b | %b | 0000 (disabled)", en_bar, a, y);
        $finish;
    end

endmodule
