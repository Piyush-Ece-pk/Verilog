module BCD2_7(a,s);
input wire [3:0]a;
output reg [6:0]s;

always @(a) begin
    case (a)
    4'd0 : s = 7'b1111110;
    4'd1 : s = 7'b0110000;
    4'd2 : s = 7'b1101101;
    4'd3 : s = 7'b1111001;
    4'd4 : s = 7'b0110011;
    4'd5 : s = 7'b1011011;
    4'd6 : s = 7'b1011111;
    4'd7 : s = 7'b0111000;
    4'd8 : s = 7'b1111111;
    4'd9 : s = 7'b1111011;
    endcase
end
endmodule 
