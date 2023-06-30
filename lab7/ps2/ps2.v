module ps2(
    input           clk,
    input           rst,
    input           ps2_clk,
    input           ps2_data,
    output          overflow,
    output [15:0]   hex_data,
    output [15:0]   hex_count,
    output [15:0]   hex_acii,
    output [7 :0]   data_print
);

wire       ready_n;
wire [7:0] data_n;
reg        valid_reg;
reg  [7:0] data_reg;

ps2_keyboard U_ps2(
    .clk(clk),
    .clrn(!rst),
    .ps2_clk(ps2_clk),
    .ps2_data(ps2_data),
    .ready(ready_n),
    .nextdata_n(1'b0),
    .data(data_n),
    .overflow(overflow)
);

//must be staged. ps2_clk is so quick that seg don't show anything.
always@(posedge clk)begin
    if(rst)begin
        valid_reg <= 0;
        data_reg  <= data_n;
    end else begin
        valid_reg <= ready_n;
        data_reg  <= data_n;
    end
end

bcd7seg U_data(
    .b  (data_reg /*& {8{valid_reg}}*/),
    .h  (hex_data)
);

bcd7seg U_count(
    .b  (8'h12),
    .h  (hex_count)
);

bcd7seg U_acii(
    .b  (8'h12),
    .h  (hex_acii)
);

assign data_print = data_reg & {8{valid_reg}};
endmodule
