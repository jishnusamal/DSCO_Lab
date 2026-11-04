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

// 16-to-1 multiplexer built from two 8-to-1 muxes and one 2-to-1 mux
module mux_16to1 (
    input  wire [15:0] d,
    input  wire [3:0]  sel,
    output wire        y
);

    wire y_low, y_high;

    // Lower 8-to-1 mux: selects d[7:0] based on sel[2:0]
    mux_8to1 mux_low  (.d(d[7:0]),  .sel(sel[2:0]), .y(y_low));

    // Upper 8-to-1 mux: selects d[15:8] based on sel[2:0]
    mux_8to1 mux_high (.d(d[15:8]), .sel(sel[2:0]), .y(y_high));

    // Final 2-to-1 mux: selects between lower and upper based on sel[3]
    mux_2to1 mux_final (.d({y_high, y_low}), .sel(sel[3]), .y(y));

endmodule
