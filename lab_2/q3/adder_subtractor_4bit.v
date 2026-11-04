// Behavioral Verilog: 4-bit Adder/Subtractor
// sub = 0 : addition  (sum = a + b)
// sub = 1 : subtraction (sum = a - b = a + ~b + 1)

module adder_subtractor_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       sub,
    output wire [3:0] sum,
    output wire       cout
);

    wire [3:0] b_mux;
    assign b_mux = sub ? ~b : b;
    assign {cout, sum} = a + b_mux + sub;

endmodule
