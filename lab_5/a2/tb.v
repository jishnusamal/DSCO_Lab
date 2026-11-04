`timescale 1ns/1ps

module tb_a2;

    reg a, b, cin;
    wire sum, cout;

    full_adder_decoder uut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    initial begin
        $display("a b cin | sum cout | expected");
        $display("---------------------------");
        a=0;b=0;cin=0; #10; $display("%b %b %b  | %b  %b  | 0 0", a,b,cin,sum,cout);
        a=0;b=0;cin=1; #10; $display("%b %b %b  | %b  %b  | 1 0", a,b,cin,sum,cout);
        a=0;b=1;cin=0; #10; $display("%b %b %b  | %b  %b  | 1 0", a,b,cin,sum,cout);
        a=0;b=1;cin=1; #10; $display("%b %b %b  | %b  %b  | 0 1", a,b,cin,sum,cout);
        a=1;b=0;cin=0; #10; $display("%b %b %b  | %b  %b  | 1 0", a,b,cin,sum,cout);
        a=1;b=0;cin=1; #10; $display("%b %b %b  | %b  %b  | 0 1", a,b,cin,sum,cout);
        a=1;b=1;cin=0; #10; $display("%b %b %b  | %b  %b  | 0 1", a,b,cin,sum,cout);
        a=1;b=1;cin=1; #10; $display("%b %b %b  | %b  %b  | 1 1", a,b,cin,sum,cout);
        $finish;
    end

endmodule
