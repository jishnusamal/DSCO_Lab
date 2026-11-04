// 4-bit BCD digit adder with correction
// Adds two BCD digits (0-9) plus carry-in, produces BCD sum digit and carry-out
module bcd_digit_adder (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);

    wire [4:0] raw;          // raw binary sum (0 to 19)
    wire       correct;      // whether to add 6 for BCD correction
    wire [4:0] corrected;    // raw + 6 when correcting

    assign raw = a + b + cin;
    // Correct if result > 9 (binary 1001) or there is a carry out of bit 3
    assign correct = raw[4] | (raw[3] & (raw[2] | raw[1]));
    assign corrected = correct ? raw + 5'd6 : raw;

    assign sum  = corrected[3:0];
    assign cout = raw[4] | correct;

endmodule

// 2-digit BCD adder
// Inputs: A[7:0], B[7:0]  (A[3:0]=ones, A[7:4]=tens, each 0-9)
// Output: SUM[11:0]       (SUM[3:0]=ones, SUM[7:4]=tens, SUM[11:8]=hundreds)
module bcd_adder_2digit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [11:0] sum
);

    wire c1;
    wire [3:0] ones, tens;

    bcd_digit_adder d0 (
        .a(a[3:0]), .b(b[3:0]), .cin(1'b0), .sum(ones), .cout(c1)
    );
    bcd_digit_adder d1 (
        .a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(tens), .cout(sum[8])
    );

    assign sum[3:0]  = ones;
    assign sum[7:4]  = tens;
    assign sum[11:9] = 3'b000;

endmodule
