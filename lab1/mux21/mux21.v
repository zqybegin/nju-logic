module mux21 (
    input  a,
    input  b,
    input  s,
    output y
);

    assign y = (s) ? a : b;

endmodule
