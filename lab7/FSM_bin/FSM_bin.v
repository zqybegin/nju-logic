module FSM_bin
(
  input   clk, in, reset,
  output  out
);

parameter[3:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3,  S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;

reg  [3:0] state_dout;

always@(posedge clk)begin
    if(reset) begin
        state_dout <= 'b0;
    end else begin
        state_dout <=   {4{state_dout == S0}} & (in? S5:S1) |
                        {4{state_dout == S1}} & (in? S5:S2) |
                        {4{state_dout == S2}} & (in? S5:S3) |
                        {4{state_dout == S3}} & (in? S5:S4) |
                        {4{state_dout == S4}} & (in? S5:S4) |
                        {4{state_dout == S5}} & (in? S6:S1) |
                        {4{state_dout == S6}} & (in? S7:S1) |
                        {4{state_dout == S7}} & (in? S8:S1) |
                        {4{state_dout == S8}} & (in? S8:S1) ;
    end
end

assign out = (state_dout == S4) || (state_dout == S8);

endmodule
