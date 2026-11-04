`timescale 1ns/1ps

module tb_a1;

    reg  [3:0] a;
    reg        en_bar;
    wire [15:0] y;

    decoder_4to16_en_low uut (.a(a), .en_bar(en_bar), .y(y));

    initial begin
        $display("en_bar a | y hot index | expected");
        $display("--------------------------------");
        en_bar = 1; a = 4'd3; #10; $display("%b  %d | none | disabled", en_bar, a);
        en_bar = 0; a = 4'd0; #10; $display("%b  %d | 0 | 0", en_bar, a);
        en_bar = 0; a = 4'd7; #10; $display("%b  %d | 7 | 7", en_bar, a);
        en_bar = 0; a = 4'd15; #10; $display("%b  %d | 15 | 15", en_bar, a);
        $finish;
    end

endmodule
