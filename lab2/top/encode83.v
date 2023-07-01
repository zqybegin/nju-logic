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

    wire [2:0] digial[7:0];

    assign digial[0] = 3'h1;
    assign digial[1] = 3'h2;
    assign digial[2] = 3'h3;
    assign digial[3] = 3'h4;
    assign digial[4] = 3'h5;
    assign digial[5] = 3'h6;
    assign digial[6] = 3'h7;
    assign digial[7] = 3'h8;

    generate
        for(i = 0;i < 8 ;i++)begin
            // If assigning the value of 7 - i to a signal in Verilog, Verilator may generate inexplicable bugs.
            // assign y_l[i+1] = y_l[i] |  ((!out_l[i] & x[7-i])? digial[7-i]:3'b0);
            assign y_l[i+1] = y_l[i] |  ((!out_l[i] & x[7-i])? digial[7-i]:3'b0);
            assign out_l[i+1] = out_l[i] | x[7-i];
        end
    endgenerate

    assign y   = en? y_l[8]:3'b0;
    assign out = en? out_l[8]:1'b0;

endmodule
