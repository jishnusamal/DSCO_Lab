// 4 to 16 decoder built from 2:4 decoders (Q1)
// Active-high enable, active-high output.
// Q1 decoder has active-low enable -> connect ~en to en_bar.

module decoder_4to16 (
    input  wire [3:0] a,
    input  wire       en,       // active-high enable
    output wire [15:0] y
);

    wire [3:0] sel_hi;   // enables for the four low decoders
    wire [3:0] y0, y1, y2, y3;

    // Top 2:4 decoder selects which group of 4 outputs is active
    decoder_2to4_en_low top (
        .a(a[3:2]),
        .en_bar(~en),     // active-high en -> active-low for Q1
        .y(sel_hi)        // sel_hi[i]=1 means group i enabled
    );

    // Four low 2:4 decoders, each enabled by corresponding sel_hi bit
    // Each low decoder has active-low enable -> connect ~sel_hi[i]
    decoder_2to4_en_low d0 (.a(a[1:0]), .en_bar(~sel_hi[0]), .y(y0));
    decoder_2to4_en_low d1 (.a(a[1:0]), .en_bar(~sel_hi[1]), .y(y1));
    decoder_2to4_en_low d2 (.a(a[1:0]), .en_bar(~sel_hi[2]), .y(y2));
    decoder_2to4_en_low d3 (.a(a[1:0]), .en_bar(~sel_hi[3]), .y(y3));

    assign y = {y3, y2, y1, y0};

endmodule
