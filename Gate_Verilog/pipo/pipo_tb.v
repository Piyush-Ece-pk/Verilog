module pipo_tb();
reg clk,rst;
reg [3:0]sin;
wire [3:0]sout;

pipo uut(
    .clk(clk),
    .rst(rst),
    .sin(sin),
    .sout(sout)
);

initial begin
clk <= 1'b0;
forever #5
clk <= ~clk;
end

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,pipo_tb);
rst <= 1'b0; #10;
rst <= 1'b1; 
sin <= 4'b1001; #10;
sin <= 4'b1110; #10;
$finish;
end 
endmodule
