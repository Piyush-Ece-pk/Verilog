module siso(clk,rst,sin,sout);
input wire clk,rst;
input wire [3:0]sin;
output reg [3:0]sout;
reg [3:0]temp;

always @(posedge clk or negedge rst)
begin
if (rst==0) begin
    temp= sin;
    sout= 4'b0000;
end
else begin
    sout = temp[0];
    temp = temp>>1;
end
end
endmodule