module d_ff(clk,rst,d,q,qb);
input wire clk,rst,d;
output reg q;
output wire qb;

always @(posedge clk or negedge rst) begin
if (rst == 0) begin
    q = 1'b0;
    end
else begin
    case (d) 
        1'b0 : q <= d;
        1'b1 : q <= d;
    endcase
end
end
assign qb = ~q;
endmodule
