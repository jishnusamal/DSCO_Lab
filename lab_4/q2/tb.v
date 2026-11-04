`timescale 1ns/1ps

module tb_q2;

    reg  [3:0] a;
    reg        en;
    wire [15:0] y;

    decoder_4to16 uut (.a(a), .en(en), .y(y));

    initial begin
        $display("en a   | y (binary) | expected hot index");
        $display("----------------------------------------");
        en = 0; a = 4'd0; #10; $display("%b  %d | %b | none (disabled)", en, a, y);
        en = 1; a = 4'd0; #10; $display("%b  %d | %b | 0", en, a, y);
        en = 1; a = 4'd5; #10; $display("%b  %d | %b | 5", en, a, y);
        en = 1; a = 4'd10; #10; $display("%b  %d | %b | 10", en, a, y);
        en = 1; a = 4'd15; #10; $display("%b  %d | %b | 15", en, a, y);
        en = 0; a = 4'd7; #10; $display("%b  %d | %b | none (disabled)", en, a, y);
        $finish;
    end

endmodule
