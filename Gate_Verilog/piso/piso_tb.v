module piso_tb();
reg clk,rst;
wire sout;
reg [3:0]sin;

piso uut (
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
$dumpvars(0,piso_tb);
rst <= 1'b0; #10;
rst <= 1'b1; sin <= 4'b1001; 
#400;
$finish;
end
endmodule