`timescale 1ns/1ps

module tb_q4;

    parameter N = 8;
    reg  [N-1:0] bin;
    wire [N-1:0] gray;

    bin_to_gray #(N) uut (.bin(bin), .gray(gray));

    initial begin
        $display("bin    | gray | expected");
        $display("----------------------");
        bin = 8'b00000000; #10;
        $display("%b | %b | %b", bin, gray, 8'b00000000);
        bin = 8'b00000001; #10;
        $display("%b | %b | %b", bin, gray, 8'b00000001);
        bin = 8'b00000010; #10;
        $display("%b | %b | %b", bin, gray, 8'b00000011);
        bin = 8'b00000111; #10;
        $display("%b | %b | %b", bin, gray, 8'b00000100);
        bin = 8'b00010101; #10;
        $display("%b | %b | %b", bin, gray, 8'b00011111);
        bin = 8'b10000000; #10;
        $display("%b | %b | %b", bin, gray, 8'b11000000);
        bin = 8'b11111111; #10;
        $display("%b | %b | %b", bin, gray, 8'b10000000);
        $finish;
    end

endmodule
