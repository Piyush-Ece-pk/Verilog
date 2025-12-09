module jh_cnt(clk,rst,q);
input wire clk,rst;
output reg [3:0]q;

reg [3:0]a;

always @(posedge clk or negedge rst)
begin
if (rst==0) begin
    a <= 1001;
    q <= a;
end
else begin
    a <= {a[2:0],~a[3]};
    q <= a;
end
end
endmodule