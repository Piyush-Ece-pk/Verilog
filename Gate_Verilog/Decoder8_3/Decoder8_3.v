module Decoder8_3(a,s);
output reg [7:0]a;
input wire [2:0]s;

always @(s) begin
    case (s) 
        3'd0 : a = 8'b00000000;
        3'd1 : a = 8'b00000001;
        3'd2 : a = 8'b00000010;
        3'd3 : a = 8'b00000100;
        3'd4 : a = 8'b00001000;
        3'd5 : a = 8'b00010000;
        3'd6 : a = 8'b00100000;
        3'd7 : a = 8'b01000000;
    endcase
end
endmodule

