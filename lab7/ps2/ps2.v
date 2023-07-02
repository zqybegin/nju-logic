module ps2(
    input           clk,
    input           rst,
    input           ps2_clk,
    input           ps2_data,
    output          overflow,
    output [15:0]   hex_data,
    output [15:0]   hex_count,
    output [15:0]   hex_acii,
    output [15:0]   hex_show
);
    parameter [1:0] idel = 2'b00;
    parameter [1:0] run  = 2'b01;
    parameter [1:0] finish = 2'b10;

    wire       ready_n;
    wire [7:0] data_n;
    reg  [1:0] state_reg;
    reg  [7:0] data_reg;

    // state to receive ps2_data
    always@(posedge clk) begin
        if(rst)begin
            state_reg <= idel;
        end else begin
            state_reg <= {2{state_reg == idel   }} & ((ready_n                     )? run   :idel  ) |
                         {2{state_reg == run    }} & ((ready_n && data_n == 8'hF0  )? finish:run   ) |
                         {2{state_reg == finish }} & ((ready_n                     )? idel  :finish) ;
        end

        data_reg <= (state_reg == idel && ready_n)? data_n:data_reg;
    end

    ps2_keyboard U_ps2(
        .clk       (clk     ),
        .clrn      (!rst    ),
        .ps2_clk   (ps2_clk ),
        .ps2_data  (ps2_data),
        .ready     (ready_n ),
        .nextdata_n(1'b0    ),
        .data      (data_n  ),
        .overflow  (overflow)
    );

    bcd7seg U_data(
        .en (state_reg == run),
        .b  (data_reg        ),
        .h  (hex_data        )
    );

    // translate from key to ascii
    wire [7:0] data_ascii;
    ram_ascii U_ram(
        .key  (data_reg  ),
        .ascii(data_ascii)
    );

    bcd7seg U_acii(
        .en (state_reg == run),
        .b  (data_ascii      ),
        .h  (hex_acii        )
    );

    // To count the number of keystrokes.
    reg [7:0] count;
    always@(posedge clk) begin
        if(rst) begin
            count <= 0;
        end else if(state_reg == finish && ready_n) begin
            count <= (count != 8'hff)? count+1:count;
        end
    end

    bcd7seg U_count(
        .en (1'b1     ),
        .b  (count    ),
        .h  (hex_count)
    );

    // Turn off the digital display
    bcd7seg U_show(
        .en (1'b0     ),
        .b  (8'h00    ),
        .h  (hex_show )
    );
endmodule
