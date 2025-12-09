module down_cnt(clk,rst,q);
input wire clk,rst;
output reg [3:0]q;
reg [3:0]a;

always @(posedge clk or negedge rst)
begin
if (rst==0) begin
    a = 4'd15;
    q = a;
    end
else begin
    if (a > 0) begin
        a = a-1;
        q = a;
    end
    else begin
        a = 4'd15;
        q = a;
    end
end
end
endmodule
