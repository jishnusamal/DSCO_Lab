// N-bit binary to Grey code conversion using for loop
// Grey: g[n-1] = b[n-1]; g[i] = b[i+1] ^ b[i]
module bin_to_gray #(
    parameter N = 8
) (
    input  wire [N-1:0] bin,
    output reg [N-1:0] gray
);

    integer i;
    always @(*) begin
        gray[N-1] = bin[N-1];
        for (i = N-2; i >= 0; i = i - 1) begin
            gray[i] = bin[i+1] ^ bin[i];
        end
    end

endmodule
