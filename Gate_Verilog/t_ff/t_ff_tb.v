module t_ff_tb();
reg clk,rst,t;
wire q;
wire qb;

t_ff uut (
    .clk(clk),
    .rst(rst),
    .t(t),
    .q(q),
    .qb(qb)
);

initial begin
clk <= 0;
forever #5
clk <= ~clk;
end 


initial begin
$dumpfile("dump.vcd");
$dumpvars(0,t_ff_tb);
rst <= 1'b0; t <= 1'b0; #10;
rst <= 1'b1; t <= 1'b0; #10;
t <= 1'b1; #10;
$finish;
end
endmodule

