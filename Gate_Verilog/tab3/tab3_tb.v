module tab3_tb();
wire [7:0] result;
wire [3:0] index;
reg clk,rst;

tab3 uut (
    .clk(clk),
    .rst(rst),
    .result(result),
    .index(index)
);

initial begin 
clk <= 1'b0;
forever #5
clk <= ~clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,tab3_tb);
    rst <= 1'b0;
    #10;
    rst<=1'b1;
    #200;
    $finish;
end
endmodule
