`timescale 1ns/1ps

module tb_q3;

    reg  [3:0] d;
    wire [1:0] y;
    wire       v;

    priority_encoder_4to2 uut (.d(d), .y(y), .v(v));

    initial begin
        $display("d     | y v | expected (y v)");
        $display("-----------------------");
        d = 4'b1000; #10; $display("%b | %b %b | 11 1", d, y, v);
        d = 4'b0100; #10; $display("%b | %b %b | 10 1", d, y, v);
        d = 4'b0010; #10; $display("%b | %b %b | 01 1", d, y, v);
        d = 4'b0001; #10; $display("%b | %b %b | 00 1", d, y, v);
        d = 4'b1101; #10; $display("%b | %b %b | 11 1 (priority D3)", d, y, v);
        d = 4'b0000; #10; $display("%b | %b %b | 00 0", d, y, v);
        $finish;
    end

endmodule
