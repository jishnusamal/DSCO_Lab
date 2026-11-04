`timescale 1ns/1ps

module tb_q2;

    reg  [3:0] g;
    wire [3:0] b;

    gray_to_binary_4bit uut (.g(g), .b(b));

    // function to compute expected binary from gray
    reg [3:0] exp;
    integer i;

    initial begin
        $display("gray | bin | expected");
        $display("------------------");
        for (i = 0; i < 16; i = i + 1) begin
            g = i[3:0];
            #10;
            // expected binary from gray: b3=g3; b[i]=b[i+1]^g[i]
            exp[3] = g[3];
            exp[2] = g[3] ^ g[2];
            exp[1] = g[3] ^ g[2] ^ g[1];
            exp[0] = g[3] ^ g[2] ^ g[1] ^ g[0];
            $display("%b  | %b  | %b", g, b, exp);
        end
        $finish;
    end

endmodule
