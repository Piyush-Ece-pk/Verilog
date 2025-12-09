module t_ff(clk,rst,t,q,qb);
input wire clk,rst,t;
output reg q;
output wire qb;

always @(posedge clk or negedge rst) begin
    if (rst==1'b0) begin
        q <= 1'b0;
    end
    else begin
        q <= ~t;
    end
end
assign qb = ~q;
endmodule
