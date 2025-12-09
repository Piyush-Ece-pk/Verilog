module sipo_tb();
reg clk,rst,sin;
wire [3:0]sout;

sipo uut (
    .clk(clk),
    .rst(rst),
    .sin(sin),
    .sout(sout)
);

initial begin
clk<=1'b0;
forever #5
clk <= ~clk;
end

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,sipo_tb);
rst <= 1'b0; #10;
rst <= 1'b1; sin <= 1'b1; #10;
sin <= 1'b0; #10;
sin <= 1'b0; #10;
sin <= 1'b1; #10;
sin <= 1'b0; #10;
$finish;
end 
endmodule