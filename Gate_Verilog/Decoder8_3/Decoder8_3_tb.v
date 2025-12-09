module Decoder8_3_tb();
wire [7:0]a;
reg [2:0]s;

Decoder8_3 uut(
    .a(a),
    .s(s)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,Decoder8_3_tb);
    s = 3'd1; #10;
    s = 3'd3; #10;
    s = 3'd6; #10;
    s = 3'd7; #10;
    $finish;
end 
endmodule


