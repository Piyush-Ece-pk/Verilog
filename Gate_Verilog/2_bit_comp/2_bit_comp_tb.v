`timescale 1ns/1ps
module two_bit_comp_tb();
reg [1:0]a,b;
wire e,l,g;

two_bit_comp uut(
    .a(a),
    .b(b),
    .e(e),
    .l(l),
    .g(g)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,two_bit_comp_tb);

    a=2'd1; b=2'd2; #10;
    a=2'd3; b=2'd3; #10;
    a=2'd1; b=2'd3; #10;
    a=2'd0; b=2'd2; #10;
    $finish;
end
endmodule

