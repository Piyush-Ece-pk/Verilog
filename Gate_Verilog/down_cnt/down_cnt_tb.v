module down_cnt_tb();
reg clk,rst;
wire [3:0]q;

down_cnt uut (
    .clk(clk),
    .rst(rst),
    .q(q)
);

initial begin
clk <= 1'b0;
forever #5
clk <= ~clk;
end

initial begin 
$dumpfile("dump.vcd");
$dumpvars(0,down_cnt_tb);
rst <= 1'b0; #10;
rst <= 1'b1; #400;
$finish;
end 
endmodule