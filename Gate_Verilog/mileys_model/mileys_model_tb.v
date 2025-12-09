module mileys_module_tb();
reg clk,rst,x;
wire z;

mileys_module uut(
    .clk(clk),
    .rst(rst),
    .z(z),
    .x(x)
);

initial begin 
clk <= 1'b0;
forever #5
clk <= ~clk;
end

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,mileys_module_tb);
rst<=1'b0;#10;
rst <= 1'b1;
x <= 1'b0;#10;
x <= 1'b1;#10;
x <= 1'b0;#10;
x <= 1'b1;#10;
x <= 1'b1;#10;
#100;
$finish;
end
endmodule