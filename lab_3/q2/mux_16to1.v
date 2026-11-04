// 8-to-1 multiplexer using case statement
module mux_8to1 (
    input  wire [7:0] d,
    input  wire [2:0] sel,
    output reg        y
);

    always @(*) begin
        case (sel)
            3'b000: y = d[0];
            3'b001: y = d[1];
            3'b010: y = d[2];
            3'b011: y = d[3];
            3'b100: y = d[4];
            3'b101: y = d[5];
            3'b110: y = d[6];
            3'b111: y = d[7];
            default: y = 1'b0;
        endcase
    end

endmodule

// 2-to-1 multiplexer
module mux_2to1 (
    input  wire [1:0] d,
    input  wire       sel,
    output wire       y
);

    assign y = sel ? d[1] : d[0];

endmodule

// 16-to-1 multiplexer built hierarchically from 2-to-1 muxes
module mux_16to1 (
    input  wire [15:0] d,
    input  wire [3:0]  sel,
    output wire        y
);

    wire [7:0]  lvl1;
    wire [3:0]  lvl2;
    wire [1:0]  lvl3;

    // Stage 1: sixteen 2-to-1 muxes -> 8 outputs
    mux_2to1 m1_0 (.d({d[1], d[0]}),  .sel(sel[0]), .y(lvl1[0]));
    mux_2to1 m1_1 (.d({d[3], d[2]}),  .sel(sel[0]), .y(lvl1[1]));
    mux_2to1 m1_2 (.d({d[5], d[4]}),  .sel(sel[0]), .y(lvl1[2]));
    mux_2to1 m1_3 (.d({d[7], d[6]}),  .sel(sel[0]), .y(lvl1[3]));
    mux_2to1 m1_4 (.d({d[9], d[8]}),  .sel(sel[0]), .y(lvl1[4]));
    mux_2to1 m1_5 (.d({d[11],d[10]}), .sel(sel[0]), .y(lvl1[5]));
    mux_2to1 m1_6 (.d({d[13],d[12]}), .sel(sel[0]), .y(lvl1[6]));
    mux_2to1 m1_7 (.d({d[15],d[14]}), .sel(sel[0]), .y(lvl1[7]));

    // Stage 2: eight 2-to-1 muxes -> 4 outputs
    mux_2to1 m2_0 (.d({lvl1[1], lvl1[0]}), .sel(sel[1]), .y(lvl2[0]));
    mux_2to1 m2_1 (.d({lvl1[3], lvl1[2]}), .sel(sel[1]), .y(lvl2[1]));
    mux_2to1 m2_2 (.d({lvl1[5], lvl1[4]}), .sel(sel[1]), .y(lvl2[2]));
    mux_2to1 m2_3 (.d({lvl1[7], lvl1[6]}), .sel(sel[1]), .y(lvl2[3]));

    // Stage 3: four 2-to-1 muxes -> 2 outputs
    mux_2to1 m3_0 (.d({lvl2[1], lvl2[0]}), .sel(sel[2]), .y(lvl3[0]));
    mux_2to1 m3_1 (.d({lvl2[3], lvl2[2]}), .sel(sel[2]), .y(lvl3[1]));

    // Stage 4: one 2-to-1 mux -> final output
    mux_2to1 m4_0 (.d({lvl3[1], lvl3[0]}), .sel(sel[3]), .y(y));

endmodule
