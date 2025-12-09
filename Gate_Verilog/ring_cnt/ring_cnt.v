module ring_cnt( rst,clk,q);
input wire rst,clk;
output reg [3:0]q;

reg [3:0]a;
always @(posedge clk or negedge rst) 
begin

if (rst==1'b0) begin
    a<=4'b1001;
    q<=a;
end
else begin
a <= {a[2:0],a[3]};
q <= a;
end
end
endmodule
