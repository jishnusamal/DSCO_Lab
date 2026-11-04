// Output high for every 5th clock pulse (mod-5 counter, out=1 at count=4)
module every_5th_pulse (
    input wire clk,
    input wire rst,
    output wire out
);

    reg [2:0] count;
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 3'b0;
        else if (count == 3'd4)
            count <= 3'b0;
        else
            count <= count + 1'b1;
    end

    assign out = (count == 3'd4);

endmodule
