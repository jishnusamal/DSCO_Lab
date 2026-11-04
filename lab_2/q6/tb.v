`timescale 1ns/1ps

module tb_q6;

    reg  a, b;
    reg  [2:0] op;
    wire y;

    full_adder_logic uut (
        .a(a), .b(b), .op(op), .y(y)
    );

    initial begin
        $display("op   a b | y | meaning");
        $display("---------------------");
        // AND: a=1,b=1 -> 1 ; a=1,b=0 -> 0
        op = 3'd0; a = 1; b = 1; #10;
        $display("AND  %b %b | %b | 1&1=1", a, b, y);
        op = 3'd0; a = 1; b = 0; #10;
        $display("AND  %b %b | %b | 1&0=0", a, b, y);
        // OR: a=0,b=0 -> 0 ; a=0,b=1 -> 1
        op = 3'd1; a = 0; b = 0; #10;
        $display("OR   %b %b | %b | 0|0=0", a, b, y);
        op = 3'd1; a = 0; b = 1; #10;
        $display("OR   %b %b | %b | 0|1=1", a, b, y);
        // XOR: a=0,b=1 -> 1 ; a=1,b=1 -> 0
        op = 3'd2; a = 0; b = 1; #10;
        $display("XOR  %b %b | %b | 0^1=1", a, b, y);
        op = 3'd2; a = 1; b = 1; #10;
        $display("XOR  %b %b | %b | 1^1=0", a, b, y);
        // NAND: a=1,b=1 -> 0 ; a=1,b=0 -> 1
        op = 3'd3; a = 1; b = 1; #10;
        $display("NAND %b %b | %b | ~(1&1)=0", a, b, y);
        op = 3'd3; a = 1; b = 0; #10;
        $display("NAND %b %b | %b | ~(1&0)=1", a, b, y);
        // NOR: a=0,b=0 -> 1 ; a=1,b=0 -> 0
        op = 3'd4; a = 0; b = 0; #10;
        $display("NOR  %b %b | %b | ~(0|0)=1", a, b, y);
        op = 3'd4; a = 1; b = 0; #10;
        $display("NOR  %b %b | %b | ~(1|0)=0", a, b, y);
        // XNOR: a=1,b=1 -> 1 ; a=0,b=1 -> 0
        op = 3'd5; a = 1; b = 1; #10;
        $display("XNOR %b %b | %b | ~(1^1)=1", a, b, y);
        op = 3'd5; a = 0; b = 1; #10;
        $display("XNOR %b %b | %b | ~(0^1)=0", a, b, y);
        $finish;
    end

endmodule
