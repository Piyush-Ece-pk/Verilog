module siso_tb();
reg clk,rst;
reg [3:0]sin;
wire [3:0]sout;

siso uut(
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
$dumpvars(0,siso_tb);
rst <= 1'b0; sin <= 1100; #10;
rst <= 1'b1; #400;
$finish;
end
endmodule