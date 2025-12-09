module jh_cnt_tb();
reg clk,rst;
wire [3:0]q;

jh_cnt uut(
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial begin
clk = 1'b0;
forever #5 
clk = ~ clk;
end

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,jh_cnt_tb);
rst <= 1'b0; #10;
rst <= 1'b1; #100;
$finish;
end 
endmodule