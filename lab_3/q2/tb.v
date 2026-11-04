`timescale 1ns/1ps

module tb_q2;

    reg  [15:0] d;
    reg  [3:0]  sel;
    wire        y;

    mux_16to1 uut (.d(d), .sel(sel), .y(y));

    initial begin
        $display("sel  d[sel] | y | expected");
        $display("---------------------------");
        d = 16'hABCD;
        sel = 4'd0;  #10; $display("%d  %b   | %b | %b", sel, d[sel], y, d[0]);
        sel = 4'd5;  #10; $display("%d  %b   | %b | %b", sel, d[sel], y, d[5]);
        sel = 4'd10; #10; $display("%d  %b   | %b | %b", sel, d[sel], y, d[10]);
        sel = 4'd15; #10; $display("%d  %b   | %b | %b", sel, d[sel], y, d[15]);
        sel = 4'd3;  #10; $display("%d  %b   | %b | %b", sel, d[sel], y, d[3]);
        $finish;
    end

endmodule
