module pipo(clk,rst,sin,sout);
input clk,rst;
input wire [3:0]sin;
output reg [3:0]sout;

always @(posedge clk or negedge rst) 
begin
if (rst==0) begin
    sout <= 4'b0000;
end
else begin
sout <= sin;
end
end
endmodule
