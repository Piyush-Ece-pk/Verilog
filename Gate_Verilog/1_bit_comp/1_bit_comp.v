
module one_bit_comp(a,b,e,l,g) ;
     input wire a,b;
     output reg e,l,g;

always @(*) begin 
e <= 1'b0;
l <= 1'b0;
g <= 1'b0;
if (a==b) begin
    e <= 1'b1;
    end
else if (a<b) begin
    l <= 1'b1;
    end
else begin
    g <= 1'b1;
    end
end 
endmodule