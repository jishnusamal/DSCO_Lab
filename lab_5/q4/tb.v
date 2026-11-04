`timescale 1ns/1ps

module tb_q4;

    reg a, b, c;
    wire f;

    majority_3bit uut (.a(a), .b(b), .c(c), .f(f));

    initial begin
        $display("a b c | f | expected (majority)");
        $display("-----------------------------");
        a=0;b=0;c=0; #10; $display("%b %b %b | %b | 0", a,b,c,f);
        a=0;b=0;c=1; #10; $display("%b %b %b | %b | 0", a,b,c,f);
        a=0;b=1;c=0; #10; $display("%b %b %b | %b | 0", a,b,c,f);
        a=0;b=1;c=1; #10; $display("%b %b %b | %b | 1", a,b,c,f);
        a=1;b=0;c=0; #10; $display("%b %b %b | %b | 0", a,b,c,f);
        a=1;b=0;c=1; #10; $display("%b %b %b | %b | 1", a,b,c,f);
        a=1;b=1;c=0; #10; $display("%b %b %b | %b | 1", a,b,c,f);
        a=1;b=1;c=1; #10; $display("%b %b %b | %b | 1", a,b,c,f);
        $finish;
    end

endmodule
