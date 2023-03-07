module top(
    input [7:0] x,
    input       en,

    output[2:0] y,
    output      out,
    output[7:0] hex
);

    encode83 U_encode83(
        .x(x),
        .en(en),
        .y(y),
        .out(out)
    );

    bcd7seg U_bcd7seg(
        .b(y),
        .h(hex)
    );

endmodule
