module four_bit_comp_tb();
wire e,l,g;
reg  [3:0]a,b;

four_bit_comp uut(
    .a(a),
    .b(b),
    .e(e),
    .l(l),
    .g(g)
) ;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,four_bit_comp_tb);
    a =4'd5 ; b = 4'd3; #10;
    a =4'd1 ; b = 4'd3; #10;
    a =4'd3 ; b = 4'd3; #10;
    a =4'd1 ; b = 4'd3; #10;
    $finish;
end
endmodule
