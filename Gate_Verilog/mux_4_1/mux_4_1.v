module mux_4_1(
output reg o,
input wire [3:0]a,
input wire [1:0]s
);
always @(*) begin
if (s==2'b00) begin
    o = a[0];
end
else if (s==2'b01) begin
    o = a[1];
end
else if (s==2'b10) begin
    o = a[2];
end
else
    o = a[3];
end
endmodule
