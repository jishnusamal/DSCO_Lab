`timescale 1ns/1ps

module tb_a2;

    reg  [4:0] a;
    reg        en;
    wire [31:0] y_bar;

    decoder_5to32 uut (.a(a), .en(en), .y_bar(y_bar));

    initial begin
        $display("en a   | active-low output index | expected");
        $display("------------------------------------------");
        en = 0; a = 5'd5; #10; $display("%b  %d | none | disabled", en, a);
        en = 1; a = 5'd0; #10; $display("%b  %d | 0 | 0", en, a);
        en = 1; a = 5'd17; #10; $display("%b  %d | 17 | 17", en, a);
        en = 1; a = 5'd31; #10; $display("%b  %d | 31 | 31", en, a);
        $finish;
    end

endmodule
