`timescale 1ns/1ps
module sr_ff_tb();
reg clk, rst, s, r;
wire q;
wire qb;

sr_ff uut(
    .clk(clk),
    .rst(rst),
    .s(s),
    .r(r),
    .q(q),
    .qb(qb)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns period clock
end

// Test stimulus
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, sr_ff_tb);

    rst = 1'b0;
    s = 0; r = 0;
    #20;

    rst = 1'b1;
    s = 1'b0; r = 1'b0; #10;
    s = 1'b1; r = 1'b0; #10;
    s = 1'b0; r = 1'b1; #10;
    s = 1'b1; r = 1'b1; #10;
    $finish;
end
endmodule
