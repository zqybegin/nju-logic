module mux41(
    input [1:0] X0,
    input [1:0] X1,
    input [1:0] X2,
    input [1:0] X3,

    input [1:0] Y,

    output[1:0] F
);

    MuxKey #(4,2,2) i996 ( F,Y,{
            2'b00,X0,
            2'b01,X1,
            2'b10,X2,
            2'b11,X3
        }
    );

endmodule
