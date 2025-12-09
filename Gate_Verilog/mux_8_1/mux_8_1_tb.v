module mux8_1_tb();
wire o;
reg [7:0]a;
reg [2:0]s;

mux_8_1 uut (
    .a(a),
    .s(s),
    .o(o)
);

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,mux8_1_tb);
a = 8'b10101010;
s = 3'b000;#10;
s = 3'b111;#10;
s = 3'b011; #10;
$finish;
end 
endmodule

