`timescale 1ns/1ps

module tb_q4;

    reg  [15:0] d;
    wire [3:0]  y;
    wire        v;

    priority_encoder_16to4 uut (.d(d), .y(y), .v(v));

    initial begin
        $display("d        | y v | actual index");
        $display("--------------------------------");
        d = 16'h0001; #10; $display("%h | %b %b | bit 0 -> y=0", d, y, v);
        d = 16'h0010; #10; $display("%h | %b %b | bit 4 -> y=4", d, y, v);
        d = 16'h1000; #10; $display("%h | %b %b | bit 12 -> y=12", d, y, v);
        d = 16'h8000; #10; $display("%h | %b %b | bit 15 -> y=15", d, y, v);
        d = 16'h8421; #10; $display("%h | %b %b | bit 15 (priority) -> y=15", d, y, v);
        d = 16'h0000; #10; $display("%h | %b %b | none -> v=0", d, y, v);
        $finish;
    end

endmodule
