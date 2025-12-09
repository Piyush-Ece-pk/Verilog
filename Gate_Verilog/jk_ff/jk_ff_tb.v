module jk_ff_tb ();
reg clk,rst,j,k;
wire q;
wire qb;

jk_ff uut(
    .clk(clk),
    .rst(rst),
    .j(j),
    .k(k),
    .q(q),
    .qb(qb)
);

initial begin
clk <= 1'b0;
forever #5 
clk <= ~ clk;
end

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0,jk_ff_tb);
    rst <= 1'b0; j <= 1'b0 ; k<=1'b0; #10;
    rst <= 1'b1; j <= 1'b0 ; k<=1'b0; #10;
    j <= 1'b0 ; k<=1'b1; #10;
    j <= 1'b1 ; k<=1'b0; #10;
    j <= 1'b1 ; k<=1'b1; #10;
    $finish;
end
endmodule