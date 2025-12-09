module all_gates (
    input wire a,b,
    output wire o_and,o_or,o_exnor,o_exor,o_nand,o_nor,o_not
);
assign o_and = a & b;
assign o_or = a | b;
assign o_exnor = a ~| b;
assign o_exor = a ^ b;
assign o_nand = a ~& b;
assign o_nor = a ~| b;
assign o_not = ~a;
endmodule