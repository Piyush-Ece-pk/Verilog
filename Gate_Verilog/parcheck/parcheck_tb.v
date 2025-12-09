module parcheck_tb();
reg clk,rst;
reg [8:0]in;
wire even,odd;

parcheck uut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .even(even),
    .odd(odd)
);

initial begin
    clk <= 1'b0;
    forever #5 
    clk <= ~clk;
end 

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,parcheck_tb);
    rst <= 1'b0; #10;
    rst <=1'b1;
    in <= 9'b101010111; #10;
    in <= 9'b101110111; #10;
    in <= 9'b100000111; #10;
    in <= 9'b101111011; #10;
    in <= 9'b110000111; #10;
    $finish;
end
endmodule