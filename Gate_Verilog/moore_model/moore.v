module moore(clk,rst,x,z);
input wire clk,rst,x;
output reg z;
parameter a=2'b00,b=2'b01,c=2'b10,d=2'b11;
reg [1:0]curr_s,next_s;

always @(posedge clk or negedge rst)
begin
    if (rst==1'b0) begin
        z <= 1'b0;
        curr_s <= a;
    end
    else 
        curr_s <= next_s;
end

always @(*) begin
    case (curr_s)
        a : begin
            z <= 1'b0;
            if (x) begin   
                next_s<=b;
            end
        end
        b : begin
            z<= 1'b0;
            if (x) begin
                next_s <= c;
            end
        end
        c : begin
            z <= 1'b0;
            if (x) begin
                next_s <= d;
            end
        end
        d : begin
            z <= 1'b1;
            if (x) begin
              next_s <= b;
            end
            else begin
                next_s <= a;
            end
        end
    endcase
end 
endmodule


            