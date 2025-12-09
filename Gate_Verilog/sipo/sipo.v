module sipo(clk,rst,sin,sout);
input wire clk,rst;
input wire sin;
output reg[3:0]sout;

always @(posedge clk or negedge rst) 
begin
if (rst==1'b0) begin
    sout <= 4'b0000;
end
else begin
    sout <= {sout[2:0],sin};
end
end
endmodule
