module encode83(
    input [7:0] x,
    input       en,

    output[2:0] y,
    output      out
);
    /* verilator lint_off UNOPTFLAT */
    wire [2:0] y_l [8:0];
    /* verilator lint_off UNOPTFLAT */
    wire [8:0] out_l;

    assign y_l[0] = 3'b0;
    assign out_l[0] = 1'b0;

    genvar i;

    generate
        for(i = 0;i < 8 ;i++)begin
            assign y_l[i+1] = y_l[i] | ((!out_l[i] & x[7-i])? 7-i:3'b0);
            assign out_l[i+1] = out_l[i] | x[7-i];
        end
    endgenerate

    assign y   = en? y_l[8]:3'b0;
    assign out = en? out_l[8]:1'b0;

endmodule
