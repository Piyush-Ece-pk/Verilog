module four_bit_comp(a,b,e,l,g);
input wire [3:0] a,b;
output reg e,l,g;
always @(*) begin
    e = 0;
    l = 0;
    g = 0;
    if (a == b) 
        e = 1'b1;
    else if (a < b)
        l = 1'b1;
    else 
        g = 1'b1;
end
endmodule

        