`timescale 1ns/1ps
module one_bit_comp_tb;
wire e,l,g;
reg a,b;

one_bit_comp uut (
    .a(a),
    .b(b),
    .e(e),
    .l(l),
    .g(g)
);

initial begin 
    $dumpfile("wave.vcd");
    $dumpvars(0,one_bit_comp_tb);

    a<=0; b<=0; #10;
    a<=0; b<=1; #10;
    a<=1; b<=0; #10;
    a<=1; b<=1; #10;
    $finish;
end
endmodule