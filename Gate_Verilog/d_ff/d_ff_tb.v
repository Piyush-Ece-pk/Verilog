module d_ff_tb();
reg clk,rst,d;
wire q;
wire qb;

d_ff uut(
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q),
    .qb(qb)
);

initial begin
clk = 0;
forever #5 
clk = ~clk;
end 

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,d_ff_tb);

rst <=1'b0; d<=1'b0; #10;
rst <=1'b1; d<=1'b0; #10;
d <= 1'b1; #10;
$finish;
end 
endmodule

