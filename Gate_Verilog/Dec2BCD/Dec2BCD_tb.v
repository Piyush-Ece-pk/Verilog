module Dec2BCD_tb();
reg [3:0]a;
wire[3:0]b;

Dec2BCD uut (
    .a(a),
    .b(b)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,Dec2BCD_tb);

    a = 4'd2; #10;
    a = 4'd5; #10;
    a = 4'd9; #10;
    $finish;
end
endmodule


