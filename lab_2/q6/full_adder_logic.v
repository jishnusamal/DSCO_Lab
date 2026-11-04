// Full adder core
module full_adder (
    input wire a,
    input wire b,
    input wire cin,
    output wire sum,
    output wire cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));

endmodule

// Full-adder-based logic unit
// By tying cin to 0 or 1 and selecting sum/cout (with optional inversion),
// a full adder can perform AND, OR, XOR, XNOR, NAND, NOR.
//   cin=0: sum = a^b (XOR),   cout = a&b (AND)
//   cin=1: sum = ~(a^b) (XNOR), cout = a|b (OR)
//   NAND = ~cout(cin=0), NOR = ~cout(cin=1)
module full_adder_logic (
    input  wire a,
    input  wire b,
    input  wire [2:0] op,   // 0:AND 1:OR 2:XOR 3:NAND 4:NOR 5:XNOR
    output wire y
);

    wire sum0, cout0;       // cin = 0
    wire sum1, cout1;       // cin = 1

    full_adder fa0 (.a(a), .b(b), .cin(1'b0), .sum(sum0), .cout(cout0));
    full_adder fa1 (.a(a), .b(b), .cin(1'b1), .sum(sum1), .cout(cout1));

    wire and_out = cout0;   // a & b
    wire or_out  = cout1;   // a | b
    wire xor_out = sum0;    // a ^ b
    wire xnor_out= sum1;    // ~(a ^ b)
    wire nand_out= ~cout0;  // ~(a & b)
    wire nor_out = ~cout1;  // ~(a | b)

    assign y = (op == 3'd0) ? and_out :
               (op == 3'd1) ? or_out  :
               (op == 3'd2) ? xor_out :
               (op == 3'd3) ? nand_out:
               (op == 3'd4) ? nor_out :
               (op == 3'd5) ? xnor_out : 1'b0;

endmodule
