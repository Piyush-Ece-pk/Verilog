module mux_8_1(o,a,s);
output reg o;
input wire [7:0]a;
input wire [2:0]s;
always @(s, a) begin
    case (s) 
    3'b000 : o =8'b00000001;
    3'b001 : o =8'b00000010;
    3'b010 : o =8'b00000100;
    3'b011 : o =8'b00001000;
    3'b100 : o =8'b00010000;
    3'b101 : o =8'b00100000;
    3'b110 : o =8'b01000000;
    3'b111 : o =8'b10000000;
    default: o =8'bxxxxxxxx;
    endcase
end
endmodule

