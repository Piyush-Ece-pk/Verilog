module piso(clk,rst,sin,sout);
input wire clk,rst;
input wire [3:0]sin;
output reg sout;
reg [3:0]temp;
always @(posedge clk or negedge rst) 
begin
if (rst==1'b0) begin
    sout = 1'b0;
    temp = 4'd0;
end
else begin
    sout = sin[temp];
    temp = temp+1;
end
end
endmodule