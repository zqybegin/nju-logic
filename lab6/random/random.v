module random(
    input            clk,
    input            rst,
    input            en,
    input      [7:0] in,

    output reg [7:0] out,
    output     [15:0]hex
);
    reg [7:0] count;
    reg [15:0]ramc;

    always@(posedge clk)begin
        if(en) begin
            out <= in;
            count <= 0;
        end else begin
            out   <= (count != 8'd255)? {ramc[15]^ramc[7]^ramc[0]^out[7]^out[4]^out[1]^out[0],out[7:1]}:out;
            count <= (count != 8'd255)? count + 1:count;
        end
    end

    always@(posedge clk)begin
        if(rst) ramc <= 0;
        else    ramc <= ramc + 1;
    end

    bcd7seg U_bcd7seg_1(
        .b(out[3:0]),
        .h(hex[7:0])
    );
    bcd7seg U_bcd7seg_2(
        .b(out[7:4]),
        .h(hex[15:8])
    );

endmodule
