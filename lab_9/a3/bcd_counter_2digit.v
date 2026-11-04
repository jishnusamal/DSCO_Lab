// Mod-10 BCD digit counter
module mod10_counter (
    input wire clk,
    input wire rst,
    input wire en,           // count enable
    output wire [3:0] q,
    output wire co           // carry out (pulse when 9->0)
);

    reg [3:0] count;
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 4'b0;
        else if (en) begin
            if (count == 4'd9)
                count <= 4'b0;
            else
                count <= count + 1'b1;
        end
    end

    assign q = count;
    assign co = en & (count == 4'd9);

endmodule

// Two-digit BCD counter (two cascaded mod-10 counters)
module bcd_counter_2digit (
    input wire clk,
    input wire rst,
    output wire [3:0] ones,
    output wire [3:0] tens
);

    wire ones_co;
    mod10_counter u0 (.clk(clk), .rst(rst), .en(1'b1),  .q(ones), .co(ones_co));
    mod10_counter u1 (.clk(ones_co), .rst(rst), .en(1'b1), .q(tens), .co());

endmodule
