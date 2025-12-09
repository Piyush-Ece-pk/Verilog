module sr_ff(clk,rst,s,r,q,qb);
input wire clk,rst,s,r;
output reg q;
output wire qb;

always @(posedge clk or negedge rst)
begin  
    if (rst == 0) begin
        q = 1'b0;
    end
    else begin
        case ({s,r}) 
            2'b00 : q <= q;
            2'b01 : q <= 1'b0;
            2'b10 : q <= 1'b1;
            2'b11 : q <= 1'bx;
        endcase
    end
end  
assign qb = ~ q;
endmodule    