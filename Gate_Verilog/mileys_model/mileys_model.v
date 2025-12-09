module mileys_module(clk,rst,x,z);
input wire clk,rst,x;
output reg z;

parameter s0=2'b00, s1=2'b01, s2=2'b10;
reg [1:0]next_s,curr_s;
always @(posedge clk or negedge rst)
begin
if (rst == 1'b0) begin
    curr_s <= s0;
end
else begin
    curr_s <= next_s;
end
end
always @(*) begin
    case(curr_s)
        s0 : begin
            z = 1'b0;
            if (x==0) begin
                next_s = s0;
            end
            else begin
                next_s = s1;
            end
        end
        s1 : begin
            z = 1'b0;
            if (x==0) begin 
                next_s = s2;
            end
            else begin
                next_s = s1;
            end
        end
        s2: begin
            z = 1'b1;
            if (x==0) begin
                next_s = s0;
            end
            else begin
                next_s = s1;
            end
        end
    endcase
end
endmodule
