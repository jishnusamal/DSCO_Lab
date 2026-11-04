`timescale 1ns/1ps

module tb_q1;

    reg  [3:0] d;
    reg  [1:0] sel;
    wire       y;

    mux_4to1 uut (.d(d), .sel(sel), .y(y));

    initial begin
        $display("sel d[3:0] | y | expected");
        $display("-------------------------");
        d = 4'b1011;
        sel = 2'b00; #10; $display("%b  %b  | %b | %b", sel, d, y, d[0]);
        sel = 2'b01; #10; $display("%b  %b  | %b | %b", sel, d, y, d[1]);
        sel = 2'b10; #10; $display("%b  %b  | %b | %b", sel, d, y, d[2]);
        sel = 2'b11; #10; $display("%b  %b  | %b | %b", sel, d, y, d[3]);
        d = 4'b0100;
        sel = 2'b10; #10; $display("%b  %b  | %b | %b", sel, d, y, d[2]);
        $finish;
    end

endmodule
