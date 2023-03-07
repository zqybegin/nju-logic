`define ADD 3'b000
`define SUB 3'b001
`define NOT 3'b010
`define AND 3'b011
`define OR  3'b100
`define NOR 3'b101
`define SLT 3'b110
`define EQL 3'b111

module alu#(
    parameter WIDTH = 4
)
(
    input [2:0]  sel,
    input [WIDTH-1:0] opdata1,
    input [WIDTH-1:0] opdata2,

    output            zero,
    output            cout,
    output            overflow,
    output[WIDTH-1:0] result,
    output[WIDTH-1:0] result_arith
);

    wire [WIDTH-1:0] opdata1_mux = opdata1;
    wire [WIDTH-1:0] opdata2_mux ={WIDTH{sel == `SUB || sel == `SLT ||  sel == `EQL}} ^ opdata2;
    wire [WIDTH-1:0]cin = (sel == `SUB || sel == `SLT ||  sel == `EQL)?1:0;


    assign {cout,result_arith} = opdata1_mux + opdata2_mux + cin ;

    //assign overflow = (opdata1[WIDTH-1] ^ opdata2[WIDTH-1]) && (result_arith[WIDTH-1] != opdata1[WIDTH-1]);
    assign overflow = ( opdata1[WIDTH-1] &&  opdata2[WIDTH-1] && !result_arith[WIDTH-1]) ||
                      (!opdata1[WIDTH-1] && !opdata2[WIDTH-1] &&  result_arith[WIDTH-1]) ; 

    wire lessthan = (opdata1[WIDTH-1] && !opdata2[WIDTH-1]) || !(opdata1[WIDTH-1] ^ opdata2[WIDTH-1]) && result_arith[WIDTH-1];

    assign result =  {WIDTH{sel == `ADD}} & result_arith            |
                     {WIDTH{sel == `SUB}} & result_arith            |
                     {WIDTH{sel == `NOT}} & ~opdata1                |
                     {WIDTH{sel == `AND}} & (opdata1 & opdata2)     |
                     {WIDTH{sel == `OR }} & (opdata1 | opdata2)     |
                     {WIDTH{sel == `NOR}} & (opdata1 ^ opdata2)     |
                     {WIDTH{sel == `SLT}} & {3'b0,lessthan}         |
                     {WIDTH{sel == `EQL}} & {3'b0,opdata1 == opdata2}   ;

    assign zero = ~|result;
endmodule
