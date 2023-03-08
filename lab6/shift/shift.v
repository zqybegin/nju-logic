`define CLR 3'b000
`define SET 3'b001
`define LRS 3'b010
`define LLS 3'b011
`define ARS 3'b100
`define CRS 3'b110
`define CLS 3'b111
`define MAG 3'b101

module shift(
    input       clk,
    input       en,
    input [2:0] sel,
    input [7:0] in,
    input       load,
    output reg [7:0] out
);
    always@(posedge clk)begin
        if(en) begin
            out <=  {8{sel == `CLR}} & 8'b0             |
                    {8{sel == `SET}} & in               |
                    {8{sel == `LRS}} & {1'b0,out[7:1]}  |
                    {8{sel == `LLS}} & {out[6:0],1'b0}  |
                    {8{sel == `ARS}} & {out[7],out[7:1]}|
                    {8{sel == `CRS}} & {out[0],out[7:1]}|
                    {8{sel == `CLS}} & {out[6:0],out[7]}|
                    {8{sel == `MAG}} & {load,  out[7:1]};
        end else begin end
    end

endmodule
