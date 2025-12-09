module BCD2_7_tb();
wire [6:0]s;
reg [3:0]a;

BCD2_7 uut (
    .a(a),
    .s(s)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,BCD2_7_tb);
    a = 4'd0; #10;
    a = 4'd3; #10;
    a = 4'd4; #10;
    a = 4'd9; #10;
    $finish;
end
endmodule

