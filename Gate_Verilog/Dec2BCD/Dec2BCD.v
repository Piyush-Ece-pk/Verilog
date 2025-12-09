module Dec2BCD(a,b);
input wire [3:0]a;
output reg [3:0]b;

always @(*) begin
case (a) 
    4'd0: b=4'b0000;
    4'd1: b=4'b0001;
    4'd2: b=4'b0010;
    4'd3: b=4'b0011;
    4'd4: b=4'b0100;
    4'd5: b=4'b0101;
    4'd6: b=4'b0110;
    4'd7: b=4'b0111;
    4'd8: b=4'b1000;
    4'd9: b=4'b1001;
    default : b = 4'bzzzz;
endcase
end 
endmodule