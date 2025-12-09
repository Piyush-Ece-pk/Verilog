module jk_ff(clk,rst,j,k,q,qb);
input wire clk,rst,j,k;
output reg q;
output wire qb;

always @(posedge clk or negedge rst) begin
if (rst==0) begin
    q<=1'b0;
end
else begin
    case ({j,k}) 
    2'b00 : q <= 1'b1;
    2'b10 : q <= 1'b1;
    2'b01 : q <= 1'b0;
    2'b11 : q <= 1'b1;
    endcase
end
end
assign qb = ~q;
endmodule
