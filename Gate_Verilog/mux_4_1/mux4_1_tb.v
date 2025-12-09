module mux4_1_tb();
wire o;
reg [3:0]a;
reg [1:0]s;
    mux_4_1 uut(
        .a(a),
        .s(s),
        .o(o)
    );
initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,mux4_1_tb);
    a = 4'b1011;
    s = 2'b00; #10;
    s = 2'b11; #10;
    s = 2'b01; #10
    $finish;
end
endmodule


