module decode38 (
    input  [2:0] x,
    input        en,
    output [7:0] y
);

    assign y = (en) ? 8'h01 << x : 8'h00;

endmodule
