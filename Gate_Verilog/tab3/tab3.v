module tab3(clk,rst,index,result);
input wire clk,rst;
output reg[7:0] result;
output reg[3:0] index;

reg [3:0] counter;
always @(posedge clk or negedge rst)
begin
    if (rst==1'b0) begin
        counter <= 7'b0;
        index <= 4'b0;
        result <= 8'b0;
    end
    else if(counter < 11) begin
        counter <=counter+1;
        index <= counter;
        result<=counter*3;
    end
end
endmodule

