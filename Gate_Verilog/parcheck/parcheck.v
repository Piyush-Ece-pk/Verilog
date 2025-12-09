module parcheck(clk,rst,in,even,odd);
input wire clk,rst;
input wire [8:0]in;
output reg even,odd;

integer i;
reg [3:0]count;

always @(posedge clk or negedge rst) 
begin   
    count <= 4'b0000;
    if (rst == 1'b0) begin
        even <= 1'b0;
        odd <= 1'b0;
        count <= 4'b0000;
    end
    else begin
        for (i=0;i<9;i=i+1) begin
            if (in[i]==1'b1) begin
                count = count+1;
            end
        end
    end
even = (count%2)?1'b1:1'b0;
odd = (count%2)?1'b0:1'b1;
end
endmodule