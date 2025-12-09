module up_cnt(clk,rst,q);
input wire clk,rst;
output reg [3:0]q;
reg [3:0]a;

always @(posedge clk or negedge rst)
begin
if (rst==1'b0) begin
    a <= 4'd0;
    q <= a;
end
else begin
    if (a < 4'd15) begin
        a <= a + 1;
        q <= a;
    end
    else begin
        a <= 4'd0;
        q <= a;
    end
end
end
endmodule
